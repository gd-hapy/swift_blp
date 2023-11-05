//
//  ViewController.swift
//  swift_blp
//
//  Created by gd-hapy on 10/19/2023.
//  Copyright (c) 2023 gd-hapy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let home = HomePageViewController()
        let nav = UINavigationController(rootViewController: home)
        self.addChildViewController(nav)
        view.addSubview(nav.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

