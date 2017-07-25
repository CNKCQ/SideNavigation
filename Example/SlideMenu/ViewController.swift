//
//  ViewController.swift
//  SlideMenu
//
//  Created by wangchengqvan@gmail.com on 07/25/2017.
//  Copyright (c) 2017 wangchengqvan@gmail.com. All rights reserved.
//

import UIKit
import SlideMenu

class ViewController: UIViewController {

    // MARK: - Properties
    lazy var slideTransitioningDelegate = SlidePresentManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Demo"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "left", style: .plain, target: self, action: #selector(leftClick(sender:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "right", style: .plain, target: self, action: #selector(rightClick(sender:)))
    }

    func leftClick(sender: UIBarButtonItem) {
        let left = LeftViewController()
        left.view.backgroundColor = .red
        slideTransitioningDelegate.direction = .left
        left.transitioningDelegate = slideTransitioningDelegate
        left.didselected = { [weak self] (item) in
            print(item)
            let dest = AnotherController()
            dest.title = item
            left.dismiss(animated: true, completion: nil)
            self?.navigationController?.pushViewController(dest, animated: true)
        }
        left.modalPresentationStyle = .custom
        self.present(left, animated: true, completion: nil)
    }

    func rightClick(sender: UIBarButtonItem) {
        let right = RightViewController()
        right.view.backgroundColor = .blue
        slideTransitioningDelegate.direction = .right
        right.transitioningDelegate = slideTransitioningDelegate
        right.modalPresentationStyle = .custom
        right.didselected = { [weak self] (item) in
            print(item)
            let dest = AnotherController()
            dest.title = item
            right.dismiss(animated: true, completion: nil)
            self?.navigationController?.pushViewController(dest, animated: true)
        }
        self.present(right, animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let dest1 = AnotherController()
        slideTransitioningDelegate.direction = .top
        slideTransitioningDelegate.isCompactHeight = true
        dest1.transitioningDelegate = slideTransitioningDelegate
        dest1.modalPresentationStyle = .custom
        self.present(dest1, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
