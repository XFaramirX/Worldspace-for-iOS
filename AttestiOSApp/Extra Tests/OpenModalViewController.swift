//
//  ColorContrastViewController.swift
//  AttestiOSApp
//
//  Created by Jennifer Dailey on 5/29/18.
//  Copyright © 2018 Deque Systems Inc. All rights reserved.
//

import UIKit

class OpenModalViewController: UIViewController {
    
    @IBOutlet weak var openModalButton: UIButton!
    
    @IBAction func openModal() {
        let storyboard = UIStoryboard(name: "ExtraTestCases", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Modal")
        viewController.definesPresentationContext = true
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openModalButton.titleLabel!.adjustsFontForContentSizeCategory = true
    }
}
