//
//  CreateMemeVC.swift
//  MemeEditor
//
//  Created by Ataias Pereira Reis on 27/11/20.
//

import UIKit

class CreateMemeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var finishEditingButton: UIBarButtonItem!

    // MARK: Properties

    let memeTextDelegate = MemeTextFieldDelegate()

    var meme: Meme?

    /// Indicates we are editing an existing meme after coming from the detail view
    var isEditMode: Bool = false

    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

        memeTextDelegate.postUpdateAction = { self.updateShareButton() }
        topTextField.applyMemeStyle(delegate: memeTextDelegate)
        bottomTextField.applyMemeStyle(delegate: memeTextDelegate)

        // FIXME I tried changing the "Back" to "Cancel", but couldn't; I tried
        // 1) navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        // 2) setToolbarItems([UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)], animated: false)

        // None of these options yielded results

        if let meme = meme {
            self.topTextField.text = meme.topText
            self.imageView.image = meme.original.image
            self.bottomTextField.text = meme.bottomText
        }

        if isEditMode {
            navigationItem.hidesBackButton = true
            shareButton.hide()
        } else {
            finishEditingButton.hide()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.updateShareButton()

        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        unsubscribeFromKeyboardNotifications()
    }

    // MARK: IBActions

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickImage(.photoLibrary)
    }

    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickImage(.camera)
    }

    @IBAction func share() {
        let image = generateMemedImage()

        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        present(shareController, animated: true)

        shareController.completionWithItemsHandler = { (activityType, completed, items, error) in
            if (completed) {
                self.saveMeme(memeImage: image)
                self.navigationController?.popToRootViewController(animated: true)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func saveEdit() {
        let image = generateMemedImage()
        saveMeme(memeImage: image)
        self.navigationController?.popToRootViewController(animated: true)
    }

    // MARK: Image methods

    func pickImage(_ sourceType: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true // to allow cropping
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        present(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            updateShareButton()
        }
        picker.dismiss(animated: true, completion: nil)
    }

    /// Generates a meme image with the current view, hiding the toolbar
    func generateMemedImage() -> UIImage {

        toolbar.isHidden = true

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        toolbar.isHidden = false

        return memedImage
    }

    /// Given state in text fields and image view, enables or disables the share button
    func updateShareButton() {
        shareButton.isEnabled = topTextField.hasText && bottomTextField.hasText && imageView.image != nil
    }

    /// Saves meme state if all relevant fields were set
    func saveMeme(memeImage: UIImage) {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, original: imageView.image!, memed: memeImage)
        self.meme = meme

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        // Only save if the meme does not exist already
        if !appDelegate.memes.contains(meme) {
            appDelegate.memes.append(meme)
            try! FileManager.save(meme)
        }
    }

    // MARK: Keyboard Notifications

    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification:Notification) {

        if bottomTextField.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }

    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }

    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

}

