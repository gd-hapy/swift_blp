////
////  SearchResult.swift
////  Pods-swift_blp_Example
////
////  Created by Apple on 10/19/23.
////
//
import Foundation
//import AudioToolbox
import UIKit

enum SearchType {
    case search // 搜索
    case rank   // 排行榜
}
class SearchResultPageViewController: BasePageViewController {

    var searchWord: String = ""
    var searchType: SearchType = .search

    var model: SearchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = kThemeColor
            
    
        switch searchType {
        case .search:
            _requestData(searchWord)
        case .rank:
            _setRankView()
        }

        setNavigationBackBtn()
    }



    // 搜索结果页
    func _setSearchView() {
        self.title = "搜索到相关视频\(model?.info?.count ?? 0)个，请点击访问"

        let sv = SearchView(model: model, array:nil , type: .model)
        sv.itemClickBlock = { [unowned self](model) in
            _pushToVideoPlayerPage(model)
        }
        view.addSubview(sv)
    }


     // 搜索排行榜
    func _setRankView() {
        self.title = "搜索排行榜-TOP100"
        let list = UserDefaults.standard.value(forKey: kHotSearchTop100Key) as! Array<String>

       let sv = SearchView(model: model, array:list , type: .string)
        sv.itemClickBlock = { [unowned self](model) in
            self._pushToSearchResultPage(model)
        }
        view.addSubview(sv)
    }

    func _requestData(_ searchWord: String) {
        SearchService.requestSearch(searchWord) { [weak self] (m) in
            self?.model = m
            self?._setSearchView()

        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#column)
        print(#function)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
       
        if self.navigationController == nil {
            for  item in self.view.subviews {
                item.removeFromSuperview()
            }
        }
    }

    deinit {
        print(#file + #function)
    }
}


extension SearchResultPageViewController {

    func _pushToVideoPlayerPage(_ model: InfoModel) {
        let videoPlayerPage = VideoPlayerPageController()
        videoPlayerPage.infoModel = model
        navigationController?.pushViewController(videoPlayerPage, animated: true)
    }

    func _pushToSearchResultPage(_ model: InfoModel) {
        let searchResultPage = SearchResultPageViewController()
        searchResultPage.searchWord = model.title ?? ""
        searchResultPage.searchType = .search
        self.navigationController?.pushViewController(searchResultPage, animated: true)
    }

}
