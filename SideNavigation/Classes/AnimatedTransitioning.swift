//
//  AnimatedTransitioning.swift
//  Slide
//
//  Created by Steve on 2017/8/1.
//  Copyright © 2017年 Jack. All rights reserved.
//


enum TransitioningType {
    case present
    case dismiss
}

class AnimatedTransitioning: NSObject {
    var transitionType: TransitioningType = .present
    var direction: Direction = .left
    var animationDuration: TimeInterval = 0.4
}

extension AnimatedTransitioning: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        switch transitionType {
        case .present:
            animatePresenting(in: transitionContext, to: to!, from: from!)
        case .dismiss:
            animateDismissing(in: transitionContext, to: to!, from: from!)
        }
    }

    @objc func animatePresenting(in transitionContext: UIViewControllerContextTransitioning, to: UIViewController, from: UIViewController) {
        let fromRect = transitionContext.initialFrame(for: from)
        var toRect = transitionContext.initialFrame(for: from)
        switch direction {
        case .left:
            toRect.origin.x = -toRect.width
        case .right:
            toRect.origin.x = toRect.width
        }
        to.view.frame = toRect
        transitionContext.containerView.addSubview(to.view)
        UIView.animate(withDuration: animationDuration, animations: {
            to.view.frame = fromRect
        }) { (_) in
            if transitionContext.transitionWasCancelled {
                transitionContext.completeTransition(false)
            } else {
                transitionContext.completeTransition(true)
            }
        }
    }

    @objc func animateDismissing(in transitionContext: UIViewControllerContextTransitioning, to: UIViewController, from: UIViewController) {
        var fromRect = transitionContext.initialFrame(for: from)
        switch direction {
        case .left:
            fromRect.origin.x = -fromRect.width
        case .right:
            fromRect.origin.x = fromRect.width
        }
        UIView.animate(withDuration: animationDuration, animations: {
            from.view.frame = fromRect
        }) { (_) in
            if transitionContext.transitionWasCancelled {
                transitionContext.completeTransition(false)
            } else {
                transitionContext.completeTransition(true)
            }
        }
    }
}
