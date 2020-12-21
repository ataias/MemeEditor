//
//  UIBarButtonItem+Extensions.swift
//  MemeEditor
//
//  Created by Ataias Pereira Reis on 21/12/20.
//

import UIKit

extension UIBarButtonItem {

    public func hide() {
        self.isEnabled = false
        self.tintColor = UIColor.clear
    }

}
