//
//  HomeSearchBar.swift
//  swift_blp
//
//  Created by Apple on 10/19/23.
//

import Foundation
import RxSwift


class HomeSearchBar: UIView, UITextFieldDelegate {
    fileprivate lazy var bag = DisposeBag()

    typealias HomeSearchBarSearchBlock = (_ searchWords: String) -> Void
    
    var searchBlock: HomeSearchBarSearchBlock?
    
    lazy var textField: UITextField = {
       let tf = UITextField(frame: CGRect(x: 30, y: 30, width: kScreenWidth - 60, height: 40))
        tf.placeholder = "请输入视频名称或链接"
        tf.textColor = .white
        
        let toutiaoAtt = [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)]
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入视频名称或链接", attributes: toutiaoAtt)
        tf.backgroundColor = .clear
        
        tf.borderStyle = UITextBorderStyle.roundedRect;
        tf.borderStyle = UITextField.BorderStyle.line
        tf.layer.cornerRadius = 15
        tf.layer.borderWidth = 1 //这里是边框宽度，0为无边框
        tf.layer.borderColor = kThemeColor.cgColor
        tf.clipsToBounds = true
//        tf.layer.mask = self.configRectCorner(view: tf, corner: [.topLeft, .bottomLeft], radii: CGSize(width: 10, height: 10))
//        tf.layer.cornerRadius = 20
//        if #available(iOS 11.0, *) {
//            tf.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
//        } else {
//            // Fallback on earlier versions
//
//
//        }
//        let corners: UIRectCorner = [.topLeft, .bottomRight]
//        let radii = CGSize(width: 20, height: 20)
//        let path = UIBezierPath(roundedRect: tf.bounds, byRoundingCorners: corners, cornerRadii: radii)
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        tf.layer.mask = mask

        tf.leftView =  UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
//        tf.leftView?.backgroundColor = .clear
           //设置显示模式为永远显示(默认不显示)
//           textField.leftViewMode = UITextFieldViewModeAlways;
        tf.leftViewMode = .always

        
//        let rightView = UIView(frame: CGRect(x: 100, y: 100, width: 30, height: 30))
//        rightView.backgroundColor = .red
//        tf.leftView = rightView

        tf.delegate = self
        
        

  
        return tf
    }()
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 250, width: kScreenWidth, height: 130))
    }
    
    private override init(frame: CGRect) {
        
        super.init(frame: frame)
//        self.backgroundColor = .red
        _setSubView()

    }
    
    func _setSubView() {
        
        self.addSubview(self.textField)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool  {
        if let _ = searchBlock {
            searchBlock!(textField.text ?? "")
        }
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configRectCorner(view: UIView, corner: UIRectCorner, radii: CGSize) -> CALayer {
           
           let maskPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: corner, cornerRadii: radii)
           
           let maskLayer = CAShapeLayer.init()
           maskLayer.frame = view.bounds
           maskLayer.path = maskPath.cgPath
        
           
           return maskLayer
        
        /*
         let corners: UIRectCorner = [.topLeft, .bottomRight]
         let radii = CGSize(width: 20, height: 20)
         let path = UIBezierPath(roundedRect: tf.bounds, byRoundingCorners: corners, cornerRadii: radii)
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         tf.layer.mask = mask
         */
       }
}

