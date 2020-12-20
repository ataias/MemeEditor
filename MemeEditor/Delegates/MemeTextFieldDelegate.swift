//
//  MemeTextFieldDelegate.swift
//  MemeEditor
//
//  Created by Ataias Pereira Reis on 28/11/20.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {

    // MARK: Static Properties
    static let textAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "Impact", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -3.0 // if positive, foreground is ignored! check docs
    ]

    // MARK: Properties
    var postUpdateAction: (() -> Void)?

    // MARK: Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        postUpdateAction?()
        return false
    }

}


