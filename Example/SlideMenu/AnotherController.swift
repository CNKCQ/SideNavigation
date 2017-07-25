//
//  AnotherController.swift
//  SlideMenu
//
//  Created by Steve on 2017/7/25.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class AnotherController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
}
