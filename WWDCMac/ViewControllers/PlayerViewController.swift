//
//  PlayerViewController.swift
//  WWDCMac
//
//  Created by 刘铎 on 15/11/20.
//  Copyright © 2015年 Derek Liu. All rights reserved.
//

import Cocoa
import AVKit
import AVFoundation
import Async

class PlayerViewController: NSViewController {

    @IBOutlet weak var indicator: NSProgressIndicator!
    @IBOutlet weak var playerView: AVPlayerView!
    @IBOutlet weak var closeButton: NSButton!
    
    var url: String
    
    init(url: String) {
        self.url = url
        super.init(nibName: "PlayerViewController", bundle: nil)!
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.wantsLayer = true
        playerView.showsFullScreenToggleButton = true
        closeButton.wantsLayer = true
        
        playerView.layer?.zPosition = 0
        closeButton.layer?.zPosition = 1
        indicator.layer?.zPosition = 1
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        let player = AVPlayer(URL: NSURL(string: url)!)
        playerView.player = player
        player.play()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        print(__FUNCTION__)
        self.closeButton.hidden = false
        
    }
    
    override func mouseExited(theEvent: NSEvent) {
        print(__FUNCTION__)
        self.closeButton.hidden = true
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        closeButton.removeFromSuperview()
        playerView.player?.pause()
        playerView.removeFromSuperview()
    }
}
