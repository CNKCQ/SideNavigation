//
//  PercentDrivenInteractiveTransition.swift
//  Slide
//
//  Created by Steve on 2017/8/1.
//  Copyright © 2017年 Jack. All rights reserved.
//


class PercentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition {
    weak var viewController: UIViewController!
    weak var presentViewController: UIViewController?
    var shouldComplete: Bool = false
    var isInteractiveTransition = false
    var direction: Direction = .left

    convenience init(_ viewController: UIViewController, with view: UIView?, present: UIViewController?, direction: Direction? = .left) {
        self.init()
        self.viewController = viewController
        self.direction = direction ?? .left
        self.presentViewController = present
        if self.presentViewController != nil {
            switch self.direction {
            case .left:
                let dgeEPanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(onPan(sender:)))
                dgeEPanGesture.edges = .left
                self.viewController.view.addGestureRecognizer(dgeEPanGesture)
            case .right:
                let dgeEPanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(onPan(sender:)))
                dgeEPanGesture.edges = .right
                self.viewController.view.addGestureRecognizer(dgeEPanGesture)
                break
            }
        } else {
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(sender:)))
            view?.addGestureRecognizer(panGesture)
            let dismissPanGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(sender:)))
            self.viewController.view.addGestureRecognizer(dismissPanGesture)
        }
    }

    private override init() {
        super.init()
    }

    func onPan(sender: UIPanGestureRecognizer) {
        let  translation = sender.translation(in: sender.view?.superview)
        switch sender.state {
        case .began:
            self.isInteractiveTransition = true
            if self.presentViewController != nil {
                self.viewController.present(self.presentViewController!, animated: true, completion: nil)
            } else {
                self.viewController.dismiss(animated: true, completion: nil)
            }
        case .changed:
            let screenWidth = -UIScreen.main.bounds.size.width
            var dragAmount = self.presentViewController == nil ? screenWidth : -screenWidth
            switch direction {
            case .left:
                dragAmount = self.presentViewController == nil ? screenWidth : -screenWidth
            case .right:
                dragAmount = self.presentViewController != nil ? screenWidth : -screenWidth
            }
            let threshold: CGFloat = 0.20
            var percent = translation.x / dragAmount
            percent = max(percent, 0.0)
            percent = min(percent, 1.0)
            update(percent)
            self.shouldComplete = percent > threshold
        case .cancelled, .ended:
            self.isInteractiveTransition = false
            if self.shouldComplete == false || sender.state == .cancelled {
                cancel()
            } else {
                finish()
            }
        default:
            break
        }
    }
}
