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
    // TODO share button

    @IBAction func edit() {
        let createVC = self.storyboard!.instantiateViewController(withIdentifier: "CreateMemeView") as! CreateMemeVC
        createVC.meme = meme
        self.navigationController!.pushViewController(createVC, animated: true)
    }
}
