//
//  HomeViewController.swift
//  swift_blp
//
//  Created by Apple on 10/19/23.
//

import UIKit

public class BasePageViewController: UIViewController {
    
    var gradientLayer: CAGradientLayer!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        _createGradientLayer()
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
