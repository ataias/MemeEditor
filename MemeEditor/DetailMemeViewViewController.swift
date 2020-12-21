//
//  DetailMemeViewViewController.swift
//  MemeEditor
//
//  Created by Ataias Pereira Reis on 20/12/20.
//

import UIKit

class DetailMemeViewViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!

    // MARK: Properties

    var meme: Meme!

    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        self.topTextField.text = meme.topText
        self.imageView.image = meme.original.image
        self.bottomTextField.text = meme.bottomText

        self.topTextField.applyMemeStyle()
        self.bottomTextField.applyMemeStyle()
    }

    // MARK: Actions
    @IBAction func share() {
        let image = meme.memed.image

        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        present(shareController, animated: true)

        shareController.completionWithItemsHandler = { (activityType, completed, items, error) in
            self.dismiss(animated: true, completion: nil)
        }

    }

    @IBAction func edit() {
        let createVC = self.storyboard!.instantiateViewController(withIdentifier: "CreateMemeView") as! CreateMemeVC
        createVC.meme = meme
        createVC.isEditMode = true

        // QUESTION: When I set animated = true, I see on the simulator a temporary black block on the right of the screen. How would I fix it if I wanted this animated?
        // FWIW: I liked it non-animated better, but would like to understand the problem
        self.navigationController!.pushViewController(createVC, animated: false)
    }
}
