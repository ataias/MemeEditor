//
//  MemeTableVC.swift
//  MemeEditor
//
//  Created by Ataias Pereira Reis on 16/12/20.
//

import UIKit

class MemeTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties

    var memes = [Meme]()

    @IBOutlet weak var tableView: UITableView!

    // MARK: Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // http://www.benmeline.com/ios-empty-table-view-with-swift/
        if memes.count == 0 {
            tableView.separatorStyle = .none
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView?.isHidden = true
        }

        return memes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        let meme = memes[(indexPath as NSIndexPath).row]

        // Set the name and image
        cell.textLabel?.text = meme.topText
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = meme.bottomText
        }
        cell.imageView?.image = meme.memed.image

        return cell
    }

    // MARK: Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = self.memes[indexPath.row]
        let detailVC = self.storyboard!.instantiateViewController(withIdentifier: "DetailMemeView") as! DetailMemeViewViewController
        detailVC.meme = detail
        self.navigationController!.pushViewController(detailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { (action, sourceView, completionHandler) in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let meme = appDelegate.memes[indexPath.row]
            try! FileManager.removeJson(meme)
            appDelegate.memes.remove(at: indexPath.row)
            self.updateMemes()
        }

        return UISwipeActionsConfiguration(actions: [delete])
    }

    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        setupEmptyBackground()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateMemes()
    }

    func updateMemes() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
    }
    
    func setupEmptyBackground() {
        let image = UIImage(systemName: "icloud.and.arrow.down")!
            .withRenderingMode(.alwaysTemplate)
            .applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 64))!

        let topMessage = "Memes"
        let bottomMessage = "You don't have any memes yet. All your memes will show up here."

        tableView.backgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
    }
    
}
