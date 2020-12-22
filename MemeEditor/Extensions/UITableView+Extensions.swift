//
//  UITableView+Extensions.swift
//  MemeEditor
//
//  Created by Ataias Pereira Reis on 22/12/20.
//

import Foundation
import UIKit

// Source: http://www.benmeline.com/ios-empty-table-view-with-swift/
extension UIViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rows.count == 0 {
            tableView.separatorStyle = .None
            tableView.backgroundView?.hidden = false
        } else {
            tableView.separatorStyle = .SingleLine
            tableView.backgroundView?.hidden = true
        }

        return rows.count
    }
}
