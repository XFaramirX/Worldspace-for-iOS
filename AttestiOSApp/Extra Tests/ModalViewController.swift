//
//  Modal.swift
//  AttestiOSApp
//
//  Created by Jennifer Dailey on 5/29/18.
//  Copyright © 2018 Deque Systems Inc. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.titleLabel!.adjustsFontForContentSizeCategory = true
    }
}
