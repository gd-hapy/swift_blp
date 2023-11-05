//
//  HomeViewController.swift
//  swift_blp
//
//  Created by Apple on 10/19/23.
//

import UIKit
import RxSwift
//import Flutter


public class BasePageViewController: UIViewController {
    
    var gradientLayer: CAGradientLayer!
    var bag = DisposeBag()
    
//    lazy var flutterEngine:FlutterEngine = FlutterEngine(name: "my flutter engine")
//    lazy var flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        _createGradientLayer()
////        navigationController?.navigationBar.backgroundColor = .green
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//
//        
//        //interactivePopGestureRecognizer
//        let isTrue = navigationController?.responds(to: #selector(preferredScreenEdgesDeferringSystemGestures));
//            var isMore:Int = 0;
//            if ((self.navigationController?.viewControllers.count) != nil) {
//                isMore = (self.navigationController?.viewControllers.count)!;
//            }
//            if isMore > 1 {
//                if isTrue! {
//                    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
//                }else{
//                    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
//                }
//            }else{
//                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
//            }
//        flutterEngine.run()
        
//        flutterPlugin(messenger: flutterViewController as! FlutterBinaryMessenger)
    }
    
    func setNavigationBackBtn() {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.rx.tap.subscribe { [weak self] (event) in
            self?._backAction()
        }.disposed(by: bag)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
   @objc func _backAction() {
        navigationController?.popViewController(animated:true)
    }

    
    //初始化gradientLayer并设置相关属性
    func _createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        //设置渐变的主颜色
        //        UIColor(hexString: " #0a2e38")
        //        #0a2e38 0%, #000000 80%
        //        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        gradientLayer.colors = [UIColor(hexString: "#0a2e38").cgColor,UIColor(hexString: "#000000", alpha: 0.8).cgColor]
        //将gradientLayer作为子layer添加到主layer上
        self.view.layer.addSublayer(gradientLayer)
    }
}



//extension BasePageViewController {
//
//    func _pushToFlutter(_ model: InfoModel) {
//        let nav = UINavigationController(rootViewController: flutterViewController)
//        flutterViewController.modalPresentationStyle = .fullScreen
//        self.present(nav, animated: true)
//
//        flutterPlugin(messenger: flutterViewController as! FlutterBinaryMessenger, model)
//    }
//
//    func flutterPlugin(messenger: FlutterBinaryMessenger,_ model: InfoModel) {
//        flutterViewController.pushRoute("/home")
//        let channel = FlutterMethodChannel(name: "plugin_apple", binaryMessenger: messenger)
//        channel.setMethodCallHandler { [self]  (call, result) in
//            if (call.method == "apple_one") {
////                var flag: Int?
////                var flag_name: String?
////                var from: String?
////                var type: String?
////                var id: Int?
////                var title: String?
////                var img: String?
//                let dic = ["flag": model.flag, "flag_name": model.flag_name, "from": model.from, "type": model.type, "id": model.id, "title": model.title, "img": model.img] as [String : String]
//
//                result(["model" : model.toJSON()])
////                result(["result":"success","code":200, "data":"apple_one"]);
//            }
//
//            if (call.method == "apple_two") {
//                result(["result":"success","code":404,"data":"apple_one"]);
//            }
//
//            if (call.method == "close_flutter_page") {
//                flutterViewController.dismiss(animated: true)
//            }
//        }
//    }
//}
