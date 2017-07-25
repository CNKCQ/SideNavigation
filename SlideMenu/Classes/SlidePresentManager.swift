//
//  SlidePresentManager.swift
//  Pods
//
//  Created by Steve on 2017/7/25.
//
//

public enum PresentDirection {
    case left
    case top
    case right
    case bottom
}

public class SlidePresentManager: NSObject {

    // MARK: - Properties
    public var direction = PresentDirection.left
    public var isCompactHeight = false
}

// MARK: - UIViewControllerTransitioningDelegate
extension SlidePresentManager: UIViewControllerTransitioningDelegate {

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = SlidePresentController(presentedViewController: presented, presenting: presenting, direction: direction)
        presentationController.delegate = self
        return presentationController
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlidePresentAnimator(direction: direction, isPresentation: true)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlidePresentAnimator(direction: direction, isPresentation: false)
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension SlidePresentManager: UIAdaptivePresentationControllerDelegate {

    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        if traitCollection.verticalSizeClass == .compact && isCompactHeight {
            return .overFullScreen
        } else {
            return .none
        }
    }

    public func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        guard case(.overFullScreen) = style else { return nil }
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RotateViewController")
    }
}
