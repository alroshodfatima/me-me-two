//
//  MemeCollectionViewController.swift
//  MeMeTwo
//
//  Created by Fatimah on 15/02/1441 AH.
//  Copyright © 1441 Fatimah. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    // MARK: outlets
    var memes: [MeMe]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    // MARK: Properties
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: override functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let space:CGFloat = 2.0
        let widthDimension = (view.frame.size.width - (2 * space)) / 4.0
        let heightDimension = (view.frame.size.height - (2 * space)) / 4.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: widthDimension, height: heightDimension)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]

        // Set the name and image of the cell
        cell.nameLabel.text = meme.topText + " ... " + meme.bottomText
        cell.memeImageView?.image = meme.meMedImage

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {

        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController

        //Populate view controller with data from the selected item
        detailController.meme = memes[(indexPath as NSIndexPath).row]

        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)

    }
    
    // MARK: Add button function
    @IBAction func addMemeButton(){
        
        let controller: ViewController
        
        controller = self.storyboard?.instantiateViewController(identifier: "EditMemeViewController") as! ViewController
        present(controller, animated: true, completion: nil)
    }
}
