//
//  SlideMenuManager.swift
//  Slide
//
//  Created by Steve on 2017/8/1.
//  Copyright © 2017年 Jack. All rights reserved.
//

enum Direction {
    case left
    case right
}

public class SideMenuManager: NSObject {
    weak var viewController: UIViewController!
    weak var presentController: UIViewController!
    var presentInteractor: PercentDrivenInteractiveTransition!
    var dismissInteractor: PercentDrivenInteractiveTransition!
    var direction: Direction = .left

    @discardableResult
    public convenience init(_ viewController: UIViewController, left: UIViewController) {
        self.init()
        self.viewController = viewController
        self.presentController = left
        self.direction = .left
        self.configPresent()
    }

    @discardableResult
    public convenience init(_ viewController: UIViewController, right: UIViewController) {
        self.init()
        self.viewController = viewController
        self.presentController = right
        self.direction = .right
        self.configPresent()
    }

    func configPresent() {
        self.presentController?.transitioningDelegate = self
        self.presentController?.modalPresentationStyle = .custom
        self.presentInteractor = PercentDrivenInteractiveTransition(viewController, with: viewController.view, present: self.presentController, direction: self.direction)
    }

    private override init() {
        super.init()
    }
}

extension SideMenuManager: UIViewControllerTransitioningDelegate {

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = PresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.delegate = self
        presentationController.direction = direction
        self.dismissInteractor = PercentDrivenInteractiveTransition(self.presentController, with: presentationController.dimmingView, present: nil, direction: self.direction)
        return presentationController
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = AnimatedTransitioning()
        animator.direction = direction
        animator.transitionType = .dismiss
        return animator
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = AnimatedTransitioning()
        animator.direction = direction
        animator.transitionType = .present
        return animator
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.dismissInteractor.isInteractiveTransition ? self.dismissInteractor : nil
    }

    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.presentInteractor.isInteractiveTransition ? self.presentInteractor : nil
    }
}

extension SideMenuManager: UIAdaptivePresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return self.viewController.traitCollection.verticalSizeClass == .compact ? .overFullScreen : .none
    }
}
