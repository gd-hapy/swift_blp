//
//  File.swift
//  swift_blp
//
//  Created by Apple on 10/19/23.
//

import Foundation
import RxSwift

enum CustomTagStyle {
    case normal
    case border
}


class CustomTag: UIView {
    private var bag = DisposeBag()
    typealias CustomTagClickBlock = ((InfoModel) -> (Void))
    var clickBlock: CustomTagClickBlock?
    
    
    typealias CustomTagClickBlock2 = ((VideoPlayingModel) -> (Void))
    var clickBlock2: CustomTagClickBlock2?
    
    typealias CustomTagHeightBlock = ((CGFloat) -> (Void))
    var heightBlock: CustomTagHeightBlock?
    
    var totalH = 50.0
    
    init(frame: CGRect, array: Array<InfoModel>, style: CustomTagStyle = .normal) {
        super.init(frame: frame)
        _setSubViews(array: array, style: style)
    }
    
    init(frame: CGRect, videoInfoModel: VideoInfoModel, style: CustomTagStyle = .normal) {
        super.init(frame: frame)
        _setSubViewsWithImage(videoInfoModel: videoInfoModel, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setSubViews(array: Array<InfoModel>, style: CustomTagStyle) {
        var width = 90.0, height = 30.0, x = 0.0, y = 20.0
        for  item in array {
            
            let title = (item.title ?? "") + " " + (item.from ?? "")

            var textW = title.widthWith(font: UIFont.systemFont(ofSize: 17))
            var shouldSizeFit = false
            if (textW > self.width) {
                textW = self.width
                shouldSizeFit = true
            }
            width = textW + 10
          
            if (x + width > self.width) {
                x = 0
                y += height + 20
            }
            
            let btn = UIButton(frame: CGRect(x: x, y: y, width: width, height: height));
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            btn.setTitle(title, for: .normal)
            btn.setTitle(title, for: .selected)
            btn.setTitleColor(kThemeColor, for: .normal)
            btn.setTitleColor(kThemeColor, for: .selected)
            btn.titleLabel?.textAlignment = .center
            if (shouldSizeFit) {
                btn.sizeToFit()
            }
            self.addSubview(btn)
            if (style == .border) {
                btn.layer.borderColor = kThemeColor.cgColor
                btn.layer.borderWidth = 1.0
                btn.clipsToBounds = true
                btn.layer.cornerRadius = 10
           
            }
            x += width + 20

            btn.rx.tap.subscribe { [weak self] (event) in
                if let _ = self?.clickBlock {
                    self?.clickBlock!(item)
                }
            }.disposed(by: bag)
        }
        totalH += y
        print(totalH)
    }
    
    private func _setSubViewsWithImage(videoInfoModel: VideoInfoModel, style: CustomTagStyle) {
        
        let closeImv = UIImageView(frame: CGRect(x: kScreenWidth - 60, y: 10, width: 45, height: 45))
        closeImv.image = UIImage(named: "close")
        closeImv.contentMode = .center
        self.addSubview(closeImv)
     

        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 45, width: kScreenWidth, height: self.height - 45))
        self.addSubview(scrollView)
        
        var width = 120.0, height = 30.0, x = 0.0, y = 20.0
        
        for item in videoInfoModel.videoModels! {
            
            let title = (item.videoName ?? "")

            if (x + width > kScreenWidth) {
                x = 0.0
                y += height + 20
            }

            let btn = UIButton(frame: CGRect(x: x, y: y, width: width, height: height));
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            btn.setTitle(title, for: .normal)
            btn.setTitle(title, for: .selected)
            btn.setTitleColor(kThemeColor, for: .normal)
            btn.setTitleColor(kThemeColor, for: .selected)
            btn.titleLabel?.textAlignment = .center
            scrollView.addSubview(btn)
            if (style == .border) {
                btn.layer.borderColor = kThemeColor.cgColor
                btn.layer.borderWidth = 1.0
                btn.clipsToBounds = true
                btn.layer.cornerRadius = 10

            }
            btn.addSubview(playingImgV)

            x += width + 20

            btn.rx.tap.subscribe { [weak self] (event) in
                self?._resetCurrentPlayingBtn(item)
                if let _ = self?.clickBlock2 {
                    self?.clickBlock2!(item)
                }
            }.disposed(by: bag)
        }
        totalH += y
        scrollView.contentSize = CGSize(width: kScreenWidth, height: totalH > self.height ? totalH : scrollView.height)
        print(totalH)
    }
    var playingImgV: UIImageView {
        let image = UIImage(named: "playing")
        let imageV = UIImageView(frame: CGRect(x: 5, y: 10, width: 15, height: 15))
        imageV.image = image
        imageV.isHidden = true
        imageV.contentMode = .scaleAspectFit
        return imageV
    }
    
    func _resetCurrentPlayingBtn(_ playingModel: VideoPlayingModel) {
        for item in self.subviews {
            if item.isKind(of: UIScrollView.self) {
                for sub in item.subviews {
                    if sub.isKind(of: UIButton.self) {
                        
                        let btn = sub as! UIButton
                        let imv = btn.subviews.last
                        imv?.isHidden = true
                        
                        if (btn.titleLabel?.text == playingModel.videoName) {
                            imv?.isHidden = false
                        }
                    }
                }
            }
        }
    }
    
    override func layoutSubviews() {
        if let _ = heightBlock {
            heightBlock!(totalH)
        }
    }
}

