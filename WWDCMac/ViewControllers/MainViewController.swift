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
    
    private let years = [2015, 2014, 2013, 2012, 2011]
    
    private func setupTabItems() {
        var items = [NSTabViewItem]()
        
        for year in years {
            let yearStoryboard = NSStoryboard(name: "Year", bundle: nil)
            let videoViewController = yearStoryboard.instantiateInitialController() as! NSSplitViewController
            
            let item = NSTabViewItem(viewController: videoViewController)
            item.identifier = year
            item.label = "WWDC\(year)"
            
            items.append(item)
        }
        
        self.tabViewItems = items
    }
    
    // MARK: - NSTabViewDelegate
    
    override func tabView(tabView: NSTabView, didSelectTabViewItem tabViewItem: NSTabViewItem?) {
        guard let year = tabViewItem?.identifier else { return }
        print(year)
    }
    
}
