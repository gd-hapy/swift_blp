//
//  HomeViewController.swift
//  swift_blp
//
//  Created by Apple on 10/19/23.
//

import UIKit


public class HomePageViewController: BasePageViewController {
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .brown
        navigationController?.navigationBar.backgroundColor = .green
        
        
//        self.title = "sddd"
     

        _setSubViews()
    }
    
   
    
    func _setSubViews() {
        // 时间
        let timer = HomeTimerView()
        view.addSubview(timer)
        
        // 搜索框
        let searchBar = HomeSearchBar()
        searchBar.searchBlock = { [self](text) in
            _pushToSearchResultPage(text: text)
        }
        view.addSubview(searchBar)

        // 热门搜索
        let hotSearch = HomeHotSearchView()
        hotSearch.itemClickedBlock = { [self] (model) in
            print("vc")
            print(model.title)
            _pushToSearchResultPage(text: model.title!)
        }
        view.addSubview(hotSearch)

        HomeService.requestHomeData { () in
            hotSearch.refreshSubViews()
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
}
