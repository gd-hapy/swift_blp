//
//  SearchResult.swift
//  Pods-swift_blp_Example
//
//  Created by Apple on 10/19/23.
//

import Foundation
import AudioToolbox

enum SearchType {
    case search // 搜索
    case rank   // 排行榜
}
class SearchResultPageViewController: BasePageViewController {
    
    var searchWord: String = ""
    var searchType: SearchType = .search
        
    var model: SearchModel?
//    {
//        didSet {
//            switch searchType {
//            case .SearchType_search:
//                self.title = "搜索到相关视频\(String(describing: model?.info?.count))个，请点击访问"
//            case .SearchType_rank:
//                self.title = "搜索排行榜-TOP100"
//            }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = kThemeColor//UIColor.green
        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.alpha = 0.0


//        view.backgroundColor = .cyan
//        self.navigationController?.navigationBar.barTintColor = nil
//        let appearance = UINavigationBarAppearance()
//         appearance.backgroundColor = .blue
//         navigationController?.navigationBar.standardAppearance = appearance
//         navigationController?.navigationBar.scrollEdgeAppearance = appearance


            
        switch searchType {
        case .search:
            _requestData(searchWord)
        case .rank:
            _setRankView()
        }
    }
    
    // 搜索结果页
    func _setSearchView() {
        let sv = SearchView(model: model, array:nil , type: .model)
        sv.itemClickBlock = { [self](model) in
            _pushToVideoPlayerPage(model)
        }
        view.addSubview(sv)
        
    }
    
     // 搜索排行榜
    func _setRankView() {
        
        let list = UserDefaults.standard.value(forKey: kHotSearchTop100Key) as! Array<String>
        
        let sv = SearchView(model: model, array:list , type: .string)
        sv.itemClickBlock = { [self](model) in
            _pushToSearchResultPage(model)
        }
        view.addSubview(sv)
    }
    
    func _requestData(_ searchWord: String) {
        SearchService.requestSearch(searchWord) { [self] (m) in
            print("")
            model = m
            _setSearchView()

        }
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        let statusView = statusBarUIView();
    //        statusView?.backgroundColor = UIColor.red;
    //    }
    
    //    // 获取状态栏背景视图
    //    func statusBarUIView() -> (UIView?) {
    //        if #available(iOS 13,*) {
    //            let tag = 128901;
    //            guard let window = UIApplication.shared.delegate?.window else {
    //                return nil;
    //            }
    //            if let statusView = window?.viewWithTag(tag) {
    //                // 已经添加
    //                window?.bringSubview(toFront: statusView);
    //                return statusView;
    //            } else {
    //                // 未添加，现在添加
    //                let statusHeight = isIphoneX() ? 44 : 20;
    //                let statusBarRect = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: statusHeight);
    //                let statusBarView = UIView(frame: statusBarRect);
    //                statusBarView.tag = tag;
    //                window?.addSubview(statusBarView);
    //                return statusBarView;
    //            }
    //        } else {
    //            // 状态栏
    //            let statusWindow = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView;
    //            let statusBar = statusWindow.value(forKey:"statusBar") as! UIView;
    //            return statusBar;
    //        }
    //    }
    
}


extension SearchResultPageViewController {
    
    func _pushToVideoPlayerPage(_ model: InfoModel) {
        let videoPlayerPage = VideoPlayerPageController()
        videoPlayerPage.infoModel = model
        navigationController?.pushViewController(videoPlayerPage, animated: true)
        
        let viewc = handle
    }
    
    func _pushToSearchResultPage(_ model: InfoModel) {
        let searchResultPage = SearchResultPageViewController()
        searchResultPage.searchWord = model.title ?? ""
        searchResultPage.searchType = .search
        self.navigationController?.pushViewController(searchResultPage, animated: true)
    }

    //    self.model?.info?
}
