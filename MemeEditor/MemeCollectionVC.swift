//
//  MemeCollectionVC.swift
//  MemeEditor
//
//  Created by Ataias Pereira Reis on 17/12/20.
//

import UIKit

class MemeCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var memes = [Meme]()
    @IBOutlet weak var collectionView: UICollectionView!

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]

        cell.textLabel.text = meme.topText
        cell.imageView.image = meme.memed.image

        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView.reloadData()
    }

}
