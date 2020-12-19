//
//  MemeTableVC.swift
//  MemeEditor
//
//  Created by Ataias Pereira Reis on 16/12/20.
//

import UIKit

class MemeTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var memes = [Meme]()
    @IBOutlet weak var tableView: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = self.memes[indexPath.row]
        let detailVC = self.storyboard!.instantiateViewController(withIdentifier: "CreateMemeView") as! CreateMemeVC
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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
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
    

    
}
