//
//  VideoEpisodeView.swift
//  swift_blp_Example
//
//  Created by Apple on 10/23/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class VideoEpisodeView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    typealias VideoEpisodeClickBlock = ((VideoPlayingModel) -> (Void))
    var clickBlock: VideoEpisodeClickBlock?
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: kScreenHeight * 0.5, width: kScreenWidth, height: kScreenHeight * 0.5))
//        view.backgroundColor = .black
        view.backgroundColor = .white
        
        return view
    }()
    
  
    var tagView: CustomTag?
    init(model: VideoInfoModel) {
        super.init(frame: CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: kScreenHeight))
//        super.init(frame: CGRect.zero)
        _sstSubViews()
        
        tagView = CustomTag(frame: CGRect(x: 15, y: 0, width: kScreenWidth - 30, height: self.contentView.height), videoInfoModel: model, style: .border)
        tagView!.clickBlock2 = { [unowned self] (playingModel) in
            if let _ = clickBlock {
                clickBlock?(playingModel)
                hideClick()
            }
        }
        self.contentView.addSubview(tagView!)
    }
    
    private func _sstSubViews() {
        self.frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: kScreenHeight)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1    );

        
        self.addSubview(contentView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideClick))
        self.addGestureRecognizer(tap)
    }

    @objc func hideClick() {
        hideEpisodeVIew()
        self.removeFromSuperview()
        
    }
    
 
    
    public func showEpisodeView(_  model: VideoPlayingModel) {
        UIApplication.shared.keyWindow?.addSubview(self)
                
        UIView.animate(withDuration: 0.5, animations: {
//            self.alpha = 1
            self.y = kScreenHeight-(self.height) + kNavigationBar64 - 64
        }, completion: nil)
        tagView!._resetCurrentPlayingBtn(model)
    }
    
    public func hideEpisodeVIew() {
        self.removeFromSuperview()
        UIView.animate(withDuration: 0.5) {
            self.y = kScreenHeight
        }

        
    }
    
    
}
