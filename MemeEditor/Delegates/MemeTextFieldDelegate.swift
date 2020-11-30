//
//  MemeTextFieldDelegate.swift
//  MemeEditor
//
//  Created by Ataias Pereira Reis on 28/11/20.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {

    var postUpdateAction: (() -> Void)?

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        postUpdateAction?()
        return false
    }

}


