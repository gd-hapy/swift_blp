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
       let tf = UITextField(frame: CGRect(x: 30, y: 30, width: kScreenWidth - 60, height: 60))
        tf.placeholder = "请输入视频名称或链接"
        tf.textColor = .white
        
        let toutiaoAtt = [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)]
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入视频名称或链接", attributes: toutiaoAtt)
        tf.backgroundColor = .clear
        
        tf.borderStyle = UITextBorderStyle.roundedRect;
        tf.borderStyle = UITextField.BorderStyle.line
        tf.layer.cornerRadius = 15
        tf.layer.borderWidth = 1
        tf.layer.borderColor = kThemeColor.cgColor
        tf.clipsToBounds = true

        tf.leftView =  UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        tf.leftViewMode = .always

        tf.delegate = self
        
        return tf
    }()
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 250, width: kScreenWidth, height: 130))
    }
    
    private override init(frame: CGRect) {
        
        super.init(frame: frame)
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
}

