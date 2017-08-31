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

let kAnimationDuration: TimeInterval = 0.4

class AnimatedTransitioning: NSObject {
    var transitionType: TransitioningType = .present
    var direction: Direction = .left
}

extension AnimatedTransitioning: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return kAnimationDuration
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

    func animatePresenting(in transitionContext: UIViewControllerContextTransitioning, to: UIViewController, from: UIViewController) {
        var fromRect = transitionContext.initialFrame(for: from)
        var toRect = fromRect
        switch direction {
        case .left:
            toRect.origin.x = -toRect.width / 3 * 2 // for the edge panGesture
            if #available(iOS 11, *) {
                // it's maybe a bug of iOS 11, it should be checked some time
                fromRect = CGRect(x: fromRect.minX - (toRect.width / 3)/2, y: fromRect.minY, width: fromRect.width, height: fromRect.height)
            }
        case .right:
            toRect.origin.x = toRect.width / 3 * 2
            if #available(iOS 11, *) {
                // it's maybe a bug of iOS 11, it should be checked some time
                fromRect = CGRect(x: fromRect.minX + (toRect.width / 3)/2, y: fromRect.minY, width: fromRect.width, height: fromRect.height)
            }
        }
        to.view.frame = toRect
        transitionContext.containerView.addSubview(to.view)
        UIView.animate(withDuration: kAnimationDuration, animations: {
            to.view.frame = fromRect
        }) { (_) in
            if transitionContext.transitionWasCancelled {
                transitionContext.completeTransition(false)
            } else {
                transitionContext.completeTransition(true)
            }
        }
    }

    func animateDismissing(in transitionContext: UIViewControllerContextTransitioning, to: UIViewController, from: UIViewController) {
        var fromRect = transitionContext.initialFrame(for: from)
        switch direction {
        case .left:
            fromRect.origin.x = -fromRect.width
        case .right:
            fromRect.origin.x = fromRect.width
        }
        UIView.animate(withDuration: kAnimationDuration, animations: {
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
