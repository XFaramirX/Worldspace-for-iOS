//
//  DUStoryTableViewController.swift
//  AttestIOS
//
//  Created by Jennifer Dailey on 8/29/17.
//  Copyright © 2017 Deque Systems Inc. All rights reserved.
//

import UIKit

let DEMO_IDENTIFIER = "Demos"
let DEMO_STORIES_IDENTIFIER = "DemoStoryCell"

let DEMO_TITLE_TAG = 90
let DEMO_LABEL_TAG = 101
let DEMO_IMAGE_TAG = 110

let DEMO_IDENTIFIER_NUM = 0
let DEMO_STORIES_NUM = 1

class MenuViewController: UITableViewController {

    // Updating views for dynamic type
    @objc private func didChangePreferredContentSize() {

        let contentSize = UIApplication.shared.preferredContentSizeCategory
        if contentSize == UIContentSizeCategory.extraSmall {
            self.tableView.rowHeight = 36
        } else if contentSize == UIContentSizeCategory.small {
            self.tableView.rowHeight = 40
        } else if contentSize == UIContentSizeCategory.medium {
            self.tableView.rowHeight = 44
        } else if contentSize == UIContentSizeCategory.large {
            self.tableView.rowHeight = 48
        } else if contentSize == UIContentSizeCategory.extraLarge {
            self.tableView.rowHeight = 52
        } else if contentSize == UIContentSizeCategory.extraExtraLarge {
            self.tableView.rowHeight = 56
        } else if contentSize == UIContentSizeCategory.extraExtraExtraLarge {
            self.tableView.rowHeight = 60
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.clearsSelectionOnViewWillAppear = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.didChangePreferredContentSize()
        
        // Notification for dynamic type
        NotificationCenter.default.addObserver(self, selector: #selector(didChangePreferredContentSize), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == DEMO_STORIES_NUM {
            return Demos.count()
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        var cellLabel: UILabel
        
        if indexPath.section == DEMO_IDENTIFIER_NUM {
            cell = tableView.dequeueReusableCell(withIdentifier: DEMO_IDENTIFIER, for: indexPath)
            cellLabel = cell.viewWithTag(DEMO_TITLE_TAG) as! UILabel
            cellLabel.text = "Worldspace for iOS"
        } else {
            let demoName = Demos.values()[indexPath.row].viewControllerName()

            cell = self.tableView.dequeueReusableCell(withIdentifier: DEMO_STORIES_IDENTIFIER, for: indexPath)
            cellLabel = cell.viewWithTag(DEMO_LABEL_TAG) as! UILabel

            cellLabel.text = demoName
            cellLabel.isAccessibilityElement = false

            // setting accessibility label
            let demoTab = String.localizedStringWithFormat(" %tu of ", indexPath.row + 1)
            cell.accessibilityLabel = "\(cellLabel.text!), \(demoTab) \(String.localizedStringWithFormat("%lu", Demos.names().count))"
            
            // Setting accessibility identifier
            cell.accessibilityIdentifier = cellLabel.text!
        }
        
        let selectedView = UIView()
        cell.selectedBackgroundView = selectedView

        return cell
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        if indexPath.section == DEMO_IDENTIFIER_NUM {
            return nil
        }

        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == DEMO_STORIES_NUM {
            let pattern = Demos.values()[indexPath.row]
            let viewController = pattern.makeViewController()
            viewController.title = "\(pattern.storyBoardName())"
            self.splitViewController!.showDetailViewController(viewController, sender: nil)
        }
    }
}
