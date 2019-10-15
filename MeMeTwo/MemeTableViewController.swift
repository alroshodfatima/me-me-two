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
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Getting the meme title to present it to user before deletion
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // declare delete action
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            
            let alert = UIAlertController(title: "Delete Meme", message: "Are you sure you want to delete Meme: \(meme.topText ?? "") ... \(meme.bottomText ?? "") ?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                actionPerformed(false)
            }))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                // perform delete
                self.deleteMeme(index: indexPath.row)
                //tableView.reloadData()
                tableView.deleteRows(at: [indexPath], with: .fade)
                actionPerformed(true)// to indecate that the action successed and remove the action with the row
            }))
            self.present(alert, animated: true, completion: nil)
        }
        // Adding the action to the configuration and return it
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteMeme(index: Int){
        // Delete meme from the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.remove(at: index)
    }
    
    // MARK: Add button action
    @IBAction func addMemeButton(){
        
        let controller: ViewController
        
        controller = self.storyboard?.instantiateViewController(identifier: "EditMemeViewController") as! ViewController
        present(controller, animated: true, completion: nil)
    }
}
