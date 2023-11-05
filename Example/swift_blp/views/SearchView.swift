//
//  SearchView.swift
//  swift_blp
//
//  Created by Apple on 10/21/23.
//

import Foundation
import UIKit

enum SearchViewType {
case model
case string
}

class SearchView:UIView {
    
//    typealias SearchViewHeightBlock = ((CGFloat) -> (Void))
//    var heightBlock: SearchViewHeightBlock?
    
    typealias SearchViewItemClickBlock = ((InfoModel) -> (Void))
    var itemClickBlock: SearchViewItemClickBlock?
    
    lazy var scrollView: UIScrollView = {
        let scv = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        return scv
        
    }()
    
    init(model: SearchModel?, array: Array<String>?, type: SearchViewType = .model) {
        let frame = CGRect(x: 15, y: kNavigationBar64, width: kScreenWidth - 30, height: kScreenHeight -  kNavigationBar64)
         super.init(frame: frame)
        self.frame = frame
        
        self.addSubview(self.scrollView)
        switch type {
        case .model:
            _setSubView(model: model!)
        case .string:
            _setSubView(array: array!)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _setSubView(model: SearchModel) {
        let tag = CustomTag(frame: self.bounds, array: model.info!, style: .border)
        tag.heightBlock = { [unowned self] (height) in
            _resetContentHeight(height)
        }
        tag.clickBlock = { [unowned self](infoModel) in
            if let _ = self.itemClickBlock {
                self.itemClickBlock!(infoModel)
            }
        }
        self.scrollView.addSubview(tag)
    }
    
    func _setSubView(array: Array<String>) {
        
        var tmpArray = [InfoModel]()
        for item in array {
            var model = InfoModel()
            model.title = item
            tmpArray.append(model)
        }
        let tag = CustomTag(frame: self.bounds, array: tmpArray, style: .border)
        tag.heightBlock = { [unowned self] (height) in
           
            _resetContentHeight(height)
        }
        tag.clickBlock = { [unowned self](model) in
            if let _ = itemClickBlock {
                itemClickBlock!(model)
            }
        }
        self.scrollView.addSubview(tag)
    }
    
    func _resetContentHeight(_ height: CGFloat) {
        let tmp = height > self.scrollView.height ? height : self.scrollView.height
        self.scrollView.contentSize = CGSize(width: self.width, height: tmp)
        self.scrollView.contentSize = CGSize(width: self.width, height: tmp)
    }
    
    deinit {
        print("dd")
    }
}
