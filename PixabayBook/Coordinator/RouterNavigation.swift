//
//  RouterNavigation.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 17/12/2022.
//

import UIKit

class RouterNavigation : NSObject, RouterNavigationProtocol {

    let navigationController: UINavigationController
    private var closures: [String: NavigationBackClosure] = [:]

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }

    func push(_ controller: UIViewController, isAnimated: Bool, onNavigateBack closure: NavigationBackClosure?) {
        if let closure = closure {
            closures.updateValue(closure, forKey: controller.description)
        }
        navigationController.pushViewController(controller, animated: isAnimated)
    }

    func pop(_ isAnimated: Bool) {
        if let poppedViewController = navigationController.popViewController(animated: isAnimated) {
            if !isAnimated {
                executeClosure(poppedViewController)
            }
        }
    }
    
    func popTo(_ controller: UIViewController, isAnimated: Bool) {
        if let poppedViewControllers = navigationController.popToViewController(controller, animated: isAnimated) {
            if !isAnimated {
                poppedViewControllers.forEach(executeClosure(_:))
            }
        }
    }
    
    func popToRoot(_ isAnimated: Bool) {
        if let poppedViewControllers = navigationController.popToRootViewController(animated: isAnimated) {
            if !isAnimated {
                poppedViewControllers.forEach { executeClosure($0) }
            }
        }
    }
    
    func present(_ controller: UIViewController, isAnimated: Bool) {
        if navigationController.presentedViewController == nil {
            navigationController.present(controller, animated: isAnimated)
        } else if let topController = navigationController.topViewController {
            topController.present(controller, animated: isAnimated, completion: nil)
        }
        
    }
    
    func dismiss(_ isAnimated: Bool, onDismiss closure: NavigationBackClosure?) {
        navigationController.dismiss(animated: isAnimated, completion: closure)
    }

    func setRoot(_ controller: UIViewController, animated: Bool) {
        navigationController.viewControllers = [controller]
        navigationController.setViewControllers([controller], animated: animated)
    }
    
    private func executeClosure(_ viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        closure()
    }
    
}

extension RouterNavigation: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(previousController) else {
                return
        }
        executeClosure(previousController)
    }
}
