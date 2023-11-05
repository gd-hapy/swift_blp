//
//  HomeHotSearchView.swift
//  swift_blp
//
//  Created by Apple on 10/19/23.
//

import Foundation
import RxSwift
import RxCocoa

class HomeHotSearchView: UIView {
    fileprivate lazy var bag = DisposeBag()

    typealias HomeHotSearchItemClickedBlock = ((InfoModel) -> (Void))
    var itemClickedBlock: HomeHotSearchItemClickedBlock?
    
    typealias SearchHeightBlock = ((CGFloat) -> (Void))
    var searchHeightBlock: SearchHeightBlock?

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 400, width: kScreenWidth, height: 200))
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
//        _setSubViews()
      
    }
    
    func refreshSubViews() {
        
        var arr = UserDefaults.standard.value(forKey: kHotSearchKey) as! Array<String>
        arr.insert("热门搜索:", at: 0)
        
        var array = [InfoModel]()
        for title in arr {
            var model = InfoModel()
            model.title = title
            array.append(model)
        }
        
        
        
//        let arr = ["八角笼中", "消失的她", "莲花楼莲花楼莲花楼莲花楼", "长相思", "曾少年", "我的人间烟火", "长风渡", "平凡之路", "当我飞奔向你", "斗罗大陆", "凡人修仙传"]
        let tag = CustomTag(frame: self.bounds, array: array )
//        tag.backgroundColor = .red
        tag.heightBlock = { (height) in
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.bounds.size.width, height: height)
        }
        self.addSubview(tag)
        tag.clickBlock = { [self] (model) in
            if (model.title!.contains("热门搜索")) {
                return
            }
            if let _ = self.itemClickedBlock {
                itemClickedBlock!(model)
            }
        }
       
    }
    
    
//    private func _setSubViews() {
//
//        let arr = ["八角笼中", "消失的她", "莲花楼莲花楼莲花楼莲花楼", "长相思", "曾少年", "我的人间烟火", "长风渡", "平凡之路", "当我飞奔向你", "斗罗大陆", "凡人修仙传"]
//
//        var width = 90.0, height = 30.0, x = 30.0, y = 20.0
//        for  text in arr {
//
//            let textW = text.widthWith(font: UIFont.systemFont(ofSize: 16))
//            width = textW + 20
//
//            if (x + width > kScreenWidth) {
//                x = 30
//                y += height + 20
//            }
//
//            let btn = UIButton(frame: CGRect(x: x, y: y, width: width, height: height));
//
//
//
//
//
//            btn.backgroundColor = .green
//
//            btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
//
//            btn.setTitle(text, for: .normal)
//            btn.setTitle(text, for: .selected)
//            btn.titleLabel?.textAlignment = .center
//            self.addSubview(btn)
//            x += width + 20
//            btn.rx.tap.subscribe { [self] (event) in
//                print(btn.titleLabel?.text ?? "")
//
//                if let _ = itemClickedBlock {
//                    itemClickedBlock!(nil)
//                }
//
//
//            }.disposed(by: bag)
//
//        }
//    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension String{
    /// String的宽度计算
    /// - Parameter font: 设定字体前提
    public func widthWith(font: UIFont) -> CGFloat {
        let str = self as NSString
        return str.size(withAttributes: [NSAttributedString.Key.font:font]).width
    }
    /// String的高度计算
    /// - Parameters:
    ///   - width: 设定宽度前提
    ///   - lineSpacing: 设定行高前提
    ///   - font: 设定字体前提
    public func heightWith(width: CGFloat, lineSpacing: CGFloat = 1.5, font: UIFont) -> CGFloat {
        
        let str = self as NSString
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineSpacing
        let size = str.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.font:font], context: nil).size
        return size.height
    }
    /// String的宽度计算
    /// - Parameter font: 设定字体前提
    public func widthHeight(_ size:CGSize,font: UIFont,attributes : [NSAttributedString.Key : Any]? = nil) -> CGFloat {
        let str = self as NSString
        let s = str.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSAttributedString.Key.font : font], context: nil).size.height
        return s
    }
}
