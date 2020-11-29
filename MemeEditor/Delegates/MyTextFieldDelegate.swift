//
//  MyTextFieldDelegate.swift
//  MemeEditor
//
//  Created by Ataias Pereira Reis on 28/11/20.
//

import Foundation
import UIKit

class MyTextFieldDelegate: NSObject, UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


