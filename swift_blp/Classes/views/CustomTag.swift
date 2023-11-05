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
    
    typealias CustomTagHeightBlock = ((CGFloat) -> (Void))
    var heightBlock: CustomTagHeightBlock?
    
    var totalH = 50.0
    
    init(frame: CGRect, array: Array<InfoModel>, style: CustomTagStyle = .normal) {
        super.init(frame: frame)
        _setSubViews(array: array, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _setSubViews(array: Array<InfoModel>, style: CustomTagStyle) {
        var width = 90.0, height = 30.0, x = 20.0, y = 20.0
        
        for  item in array {
            
            let title = (item.title ?? "") + " " + (item.from ?? "")

            let textW = title.widthWith(font: UIFont.systemFont(ofSize: 16))
            width = textW + 20
          
            if (x + width > kScreenWidth) {
                x = 20
                y += height + 20
            }
            
            let btn = UIButton(frame: CGRect(x: x, y: y, width: width, height: height));
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            btn.setTitle(title, for: .normal)
            btn.setTitle(title, for: .selected)
            btn.setTitleColor(kThemeColor, for: .normal)
            btn.setTitleColor(kThemeColor, for: .selected)
            btn.titleLabel?.textAlignment = .center
            self.addSubview(btn)
            if (style == .border) {
                btn.layer.borderColor = kThemeColor.cgColor
                btn.layer.borderWidth = 1.0
                btn.clipsToBounds = true
                btn.layer.cornerRadius = 10
           
            }
            x += width + 20

            btn.rx.tap.subscribe { [self] (event) in
                if let _ = clickBlock {
                    clickBlock!(item)
                }
            }.disposed(by: bag)
        }
        totalH += y
        print(totalH)
    }
    
    override func layoutSubviews() {
        if let _ = heightBlock {
            heightBlock!(totalH)
        }
    }
    
}

