//
//  UITextField+Extensions.swift
//  MemeEditor
//
//  Created by Ataias Pereira Reis on 20/12/20.
//

import Foundation
import UIKit

extension UITextField {
    func applyMemeStyle(delegate: UITextFieldDelegate? = nil) {
        self.defaultTextAttributes = MemeTextFieldDelegate.textAttributes
        self.delegate = delegate
        self.textAlignment = .center
    }
}
