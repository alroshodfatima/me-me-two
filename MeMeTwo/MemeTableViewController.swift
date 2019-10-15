//
//  MemeTableViewController.swift
//  MeMeTwo
//
//  Created by Fatimah on 15/02/1441 AH.
//  Copyright © 1441 Fatimah. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    
    // MARK: Properties
    var memes: [MeMe]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    // MARK: override functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView!.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.textLabel?.text = meme.topText + " ... " + meme.bottomText
        cell.imageView?.image = meme.meMedImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         // Grab the DetailVC from Storyboard
               let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController

               //Populate view controller with data from the selected item
               detailController.meme = memes[(indexPath as NSIndexPath).row]

               // Present the view controller using navigation
               navigationController!.pushViewController(detailController, animated: true)
    }
    
    // MARK: Add button action
    @IBAction func addMemeButton(){
        
        let controller: ViewController
        
        controller = self.storyboard?.instantiateViewController(identifier: "EditMemeViewController") as! ViewController
        present(controller, animated: true, completion: nil)
    }
}
