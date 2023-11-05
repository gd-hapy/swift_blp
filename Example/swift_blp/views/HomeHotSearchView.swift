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
        self.init(frame: CGRect(x: 20, y: 400, width: kScreenWidth - 40, height: 200))
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        let tag = CustomTag(frame: self.bounds, array: array )
        tag.heightBlock = { (height) in
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.bounds.size.width, height: height)
        }
        self.addSubview(tag)
        tag.clickBlock = { [unowned self] (model) in
            if (model.title!.contains("热门搜索")) {
                return
            }
            if let _ = self.itemClickedBlock {
                self.itemClickedBlock!(model)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
