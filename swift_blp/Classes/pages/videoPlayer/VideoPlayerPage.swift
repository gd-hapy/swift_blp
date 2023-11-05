//
//  VideoPlayer.swift
//  Pods-swift_blp_Example
//
//  Created by Apple on 10/19/23.
//

import Foundation
import AVKit
import AVFoundation

class VideoPlayerPageController: BasePageViewController {
    
    var infoModel: InfoModel?
    
    let playerVC = AVPlayerViewController()
    let player = AVPlayer(url: URL(string: "http://vjs.zencdn.net/v/oceans.mp4")!)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        playerVC.player?.play()
        ////        playerVC.shouldAutorotate = true
        ////        playerVC.supportedInterfaceOrientations = .all
        ////        playerVC.preferredInterfaceOrientationForPresentation = .portrait
        ////        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        //
        //
        //        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        //        playerVC.view.addGestureRecognizer(pan)
        ////        let nowPlayingInfo: [String: Any] = [
        ////            MPMediaItemPropertyTitle: "Title",
        ////            MPMediaItemPropertyArtist: "Artist",
        ////        ]
        ////        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        //
        //        _setSubViews()
        
        //        let videoUrl = Bundle.main.url(forResource: "playdoh-bat", withExtension: "mp4")!
        
        
        
        VideoPlayerService.requestVideoInfo(flag: infoModel?.flag, id: infoModel?.id) { [self] model in
            print("")
            if ((model.url?.hasSuffix(".html")) != nil) { // html
                VideoPlayerService.requestVideoPlayingInfo(model.url!) { str in
                    print("")
                    _play(url: str)
                }
            } else {
                _play(url: model.url!)
            }
        }
       
    }
    
    func _play(url: String) {
//        let playerItem = AVPlayerItem(url: URL(string: "http://vjs.zencdn.net/v/oceans.mp4")!)
        let playerItem = AVPlayerItem(url: URL(string: url)!)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.bounds = view.bounds
        playerLayer.position = view.center
        view.layer.addSublayer(playerLayer)
        
        player.play()
    }
    
    func _setSubViews() {
        
        playerVC.player = player
        addChildViewController(playerVC)
        view.addSubview(playerVC.view)
    }
    
    @IBAction func speedDidChange(_ sender: UISlider) {
        playerVC.player?.rate = sender.value
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) in
            let targetFrame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            let layer = self.playerVC.view.layer.sublayers?.first
            layer?.frame = targetFrame
            self.playerVC.view.frame = targetFrame
        }, completion: nil)
    }
    
    // 添加手势控制音量、亮度和播放进度
    
    
    // 手势控制时，调节音量、亮度和播放进度
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: playerVC.view)
        let translation = sender.translation(in: playerVC.view)
        
        if sender.state == .began {
            let isVertical = abs(translation.y) > abs(translation.x)
            switch isVertical {
            case true:
                // 显示音量或亮度面板
                break
            case false:
                // 跳转到指定时间，显示进度条
                break
            }
        } else if sender.state == .changed {
            let isVertical = abs(translation.y) > abs(translation.x)
            //            switch isVertical {
            //            case true:
            //                let changeRate = -translation.y / playerVC.view.bounds.height
            //                let volume = max(0, min(1, originalVolume + changeRate))
            //                showVolumePanel(volume)
            //            case false:
            //                let time = max(0, min(CMTimeGetSeconds(playerVC.player!.currentItem!.duration), originalTime + Double(translation.x / playerVC.view.bounds.width)))
            //                showProgressSlider(time)
            //            }
        } else if sender.state == .ended {
            //            hideControlPanel()
        }
    }
}
