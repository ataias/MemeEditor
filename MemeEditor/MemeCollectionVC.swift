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
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]

        cell.textLabel.text = meme.topText
        // FIXME: Can I avoid specifying the width/height of the image on the storyboard? I tried, expecting the image would just stretch as much as possible to fit with their own aspect ration, but no matter what I tried the image just disappeared. The example on BondVillains also hard codes the size.
        cell.imageView.image = meme.memed.image
        cell.layer.borderWidth = 0.5

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = self.memes[indexPath.row]
        let detailVC = self.storyboard!.instantiateViewController(withIdentifier: "DetailMemeView") as! DetailMemeViewViewController
        detailVC.meme = detail
        self.navigationController!.pushViewController(detailVC, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)

        collectionView.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView.reloadData()
    }

}
