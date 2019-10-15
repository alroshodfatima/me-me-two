//
//  MemeDetailViewController.swift
//  MeMeTwo
//
//  Created by Fatimah on 15/02/1441 AH.
//  Copyright © 1441 Fatimah. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    // MARK: Properties
    var meme: MeMe!
    
    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: override functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.imageView!.image = self.meme.meMedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
