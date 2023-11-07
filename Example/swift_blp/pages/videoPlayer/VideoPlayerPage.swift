//
//  VideoPlayer.swift
//  Pods-swift_blp_Example
//
//  Created by Apple on 10/19/23.
//

import Foundation
import AVKit
import AVFoundation
import ZFPlayer
import RxSwift
import SVProgressHUD


class VideoPlayerPageController: BasePageViewController {
    
    var infoModel: InfoModel?
    var videoModel: VideoModel?
    var videoPlayingModel: VideoPlayingModel?
    var containerView: UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        _requestData()
        setNavigationBackBtn()
    }
    
    func _requestData() {
        VideoPlayerService.requestVideoInfo(flag: infoModel?.flag, id: infoModel?.id) { [unowned self] model in
            videoModel = model
            videoPlayingModel = model.info?.first?.videoModels?.first
            if ((model.url?.hasSuffix(".html")) == nil) { // html
                self._parsePlayingUrl(url: model.url!)
            } else {
                _playVideo(url: model.url!)
            }
        }
    }
    
    static var retryCount = 0
    func _parsePlayingUrl(url: String) {
        VideoPlayerPageController.retryCount = 1
        VideoPlayerService.requestVideoPlayingInfo(url) { [unowned self] str in
            if str.count > 0 {
                _playVideo(url: str)
            } else {
                VideoPlayerPageController.retryCount += 1
                self._parsePlayingUrl_back(url: url);
            }
        }
       
    }
    
    func _parsePlayingUrl_back(url: String) {
        VideoPlayerService.requestVideoPlayingInfo_back(url, completion: { [unowned self] str in
            if str.count > 0 {
                _playVideo(url: str)
            } else {
                VideoPlayerPageController.retryCount = 0
                SVProgressHUD.show(withStatus: "视频加载失败，切换源重试")
            }
        })
    }
    
    
    func _setNavigationRightBtn() {
        if (videoModel?.info?.first?.video?.count ?? 0 > 0) {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            btn.setTitle("...", for: .normal)
            btn.rx.tap.subscribe { [weak self] (event) in
                self?.videoEpisode.showEpisodeView((self?.videoPlayingModel)!)
                self?.videoEpisode.clickBlock = { [unowned self] (playingModel) in
                    print(playingModel)
                    self?.videoPlayingModel = playingModel
                    self?.videoPlayingModel?.videoPlaying = true
                    let index = self?.videoModel?.info?.first?.videoModels?.firstIndex(where: { vmodel in
                        return vmodel.videoFullUrl == playingModel.videoFullUrl
                    })
                    var tmp = playingModel
                    tmp.videoPlaying = true
                    self?.videoModel?.info?[0].videoModels![index!] = (self?.videoPlayingModel!)!
                    self?._switchPlayingVideo()
                }
            }.disposed(by: bag)
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        }
    }
    
    lazy var videoEpisode: VideoEpisodeView = {
        let view = VideoEpisodeView(model: (videoModel?.info?.first)!)
        return view
    }()

    
    func _playVideo(url: String) {
        player.assetURL = URL(string:url)
        
        _setNavigationRightBtn()
    }
    
    lazy var player: ZFPlayerController = {
        containerView = UIView(frame: CGRect(x: 0, y: kNavigationBar64, width: kScreenWidth, height: kScreenHeight-kNavigationBar64 - 20))
        containerView!.backgroundColor = .red
        self.view.addSubview(containerView!)

        let playerManager = ZFAVPlayerManager()
        player = ZFPlayerController(playerManager: playerManager, containerView: containerView!)
        player.controlView = ZFPlayerControlView()
        playerManager.playerPlayStateChanged = {[weak self](asset, playState:ZFPlayerPlaybackState) in
            if (playState != .playStatePlaying) {
                self?._videoSpeedRateAccidentHandle()
            }
        }
        
        var longTap = UILongPressGestureRecognizer(target: self, action: #selector(_videoSpeedRate(_:)))
        player.controlView?.addGestureRecognizer(longTap)
        
        return player
    }()
    
    @objc func _videoSpeedRate(_ ges: UIGestureRecognizer) {
        if  player.currentPlayerManager.isPlaying {
            
            print("rwaVlaue:\(ges.state.rawValue)" )
            if ges.state.rawValue == 3 || ges.state.rawValue == 4 || ges.state.rawValue == 5 {
                
                player.currentPlayerManager.rate = 1.0
                CustomToast.shared.dismissToast()
            } else {
                player.currentPlayerManager.rate = 2.0
                CustomToast.shared.showToast()
            }
        }
    }
    
    // 由于 网络影响快进，直接取消掉快进
    private func _videoSpeedRateAccidentHandle() {
        CustomToast.shared.dismissToast()
    }
    
    func _switchPlayingVideo() {
        let playingUrl = self.videoPlayingModel?.videoUrl
        if ((playingUrl?.hasSuffix(".html")) == nil) { // html
            self._parsePlayingUrl(url: playingUrl!)
        } else {
            _playVideo(url: playingUrl!)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
      if self.navigationController == nil {
          print(self)
          containerView?.removeFromSuperview()
          containerView = nil
      }
        print("viewDidAppear")
        player.stop()
    }
  
    deinit {
        print(#file + #function)
    }
}
