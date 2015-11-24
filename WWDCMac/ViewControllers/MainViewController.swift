//
//  MainViewController.swift
//  WWDCMac
//
//  Created by 刘铎 on 15/11/18.
//  Copyright © 2015年 刘铎. All rights reserved.
//

import Cocoa

class MainViewController: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        setupTabItems()
        
        // OS X上还要这样自己设置一下。。。
        self.tabView.delegate = self
    }
    
    // MARK: - Private - Setup UI
    
    private let years = [
        "WWDC 2015",
        "WWDC 2014",
        "WWDC 2013",
        "WWDC 2012",
        "WWDC 2011",
        "Tech Talks 2013"
    ]
    
    private func setupTabItems() {
        var items = [NSTabViewItem]()
        
        for year in years {
            let yearStoryboard = NSStoryboard(name: "Year", bundle: nil)
            let videoViewController = yearStoryboard.instantiateInitialController() as! NSSplitViewController
            
            let item = NSTabViewItem(viewController: videoViewController)
            item.identifier = year
            item.label = "\(year)"
            
            items.append(item)
        }
        
        self.tabViewItems = items
    }
    
    // MARK: - NSTabViewDelegate
    
    override func tabView(tabView: NSTabView, didSelectTabViewItem tabViewItem: NSTabViewItem?) {
        NSNotificationCenter.defaultCenter().postNotificationName("SelectedTabViewItem", object: nil)
    }
    
}
