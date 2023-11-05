//
//  HomeViewController.swift
//  swift_blp
//
//  Created by Apple on 10/19/23.
//

import UIKit
import EZLoadingActivity
import RxSwift


public class HomePageViewController: BasePageViewController {
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        _setSubViews()
    }
    
    
    func _setSubViews() {
        // 时间
        let timer = HomeTimerView()
        view.addSubview(timer)
        
        // 搜索框
        let searchBar = HomeSearchBar()
        searchBar.searchBlock = { [unowned self](text) in
            _pushToSearchResultPage(text: text)
        }
        view.addSubview(searchBar)
        
        // 热门搜索
        let hotSearch = HomeHotSearchView()
        hotSearch.itemClickedBlock = { [unowned self] (model) in
            _pushToSearchResultPage(text: model.title!)
        }
        view.addSubview(hotSearch)
        HomeService.requestHomeData { [unowned self] () in
            hotSearch.refreshSubViews()
            _customSwitchSourceBtn(hotSearch.bottomY)
        }
    }
    
    
   
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension HomePageViewController {
    
    func _pushToSearchResultPage(text: String) {
        let searchResultPage = SearchResultPageViewController()
        searchResultPage.searchWord = text
        searchResultPage.searchType = text.contains("更多") ? .rank : .search
        self.navigationController?.pushViewController(searchResultPage, animated: true)
    }
    
   
    func _customSwitchSourceBtn(_ y: CGFloat) {
        let btn = UIButton(frame: CGRect(x: 30, y: y + 30, width: 90, height: 40));
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle("换源", for: .normal)
        btn.setTitle("换源", for: .selected)
        btn.setTitleColor(kThemeColor, for: .normal)
        btn.setTitleColor(kThemeColor, for: .selected)
        btn.titleLabel?.textAlignment = .center
        self.view.addSubview(btn)
        
        btn.layer.borderColor = kThemeColor.cgColor
        btn.layer.borderWidth = 1.0
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.rx.tap.subscribe { (event) in

            APIManager.switchBaseUrl()
        }.disposed(by: bag)
    }
}
