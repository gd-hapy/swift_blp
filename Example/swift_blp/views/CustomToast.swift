//
//  CustomToast.swift
//  swift_blp_Example
//
//  Created by Apple on 10/25/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import Lottie


class CustomToast: UIView {
    
    
    var array = [Timer]()
    var isWorking: Bool = false
    static let shared = CustomToast()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        print("init called")
    }
    
    private var timer: Timer?
    
    lazy var containView: UIView = {
        var view = UIView(frame: CGRect(x: 0, y: kScreenHeight * 0.3, width: self.width, height: 30))
//        view.backgroundColor = .gray
        return view
    }()
    lazy var playingView: AnimationView = {
        var ani = AnimationView(name: "player_treble_rate_tip")
        ani.loopMode = .loop
        ani.frame = CGRect(x: kScreenWidth * 0.4, y: 0, width: 20, height: 30)
//        ani.backgroundColor = .red
        ani.play()
        return ani
    }()
    
    lazy var label: UILabel = {
        var l = UILabel(frame: CGRect(x: playingView.rightX + 10, y: 0, width: self.width, height: 30))
        l.text = "2x 播放中"
        l.font = UIFont.systemFont(ofSize: 15.0)
        l.textColor = .white
        return l
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func showToast() {
        if isWorking == false {
            _setSubViews()
            print("timer 开始工作")
        }
    }
    
    public func dismissToast() {
        self.removeFromSuperview()
        isWorking = false
        timer?.invalidate()
        timer = nil
        label.removeFromSuperview()
    }
    
    
    deinit {
        print("deinit")
    }
    private func _setSubViews() {
        
        UIApplication.shared.keyWindow?.addSubview(self)
        self.frame = (UIApplication.shared.keyWindow?.rootViewController?.view.bounds)!
        self.backgroundColor = .clear
        
        self.addSubview(containView)
        containView.addSubview(playingView)
        playingView.play()
        containView.addSubview(label)
        
//        let list = ["2x 播放中.", "2x 播放中..", "2x 播放中..."]
//
//        var index = 0
//        if timer == nil {
//            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self](timer) in
//                self?.isWorking = true
//                let t = list[index]
//                DispatchQueue.main.async {
//                    self?.label.text = t
//                }
//
//                index += 1
//                index = index % list.count
//            }
//        }
    }
}
