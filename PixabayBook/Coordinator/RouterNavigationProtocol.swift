//
//  RouterNavigationProtocol.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 17/12/2022.
//

import UIKit

typealias NavigationBackClosure = (() -> Void)

protocol RouterNavigationProtocol: AnyObject {
    func push(_ controller: UIViewController, isAnimated: Bool, onNavigateBack: NavigationBackClosure?)
    func pop(_ isAnimated: Bool)
    func popTo(_ controller: UIViewController, isAnimated: Bool)
    func popToRoot(_ isAnimated: Bool)
    func present(_ controller: UIViewController, isAnimated: Bool)
    func dismiss(_ isAnimated: Bool, onDismiss: NavigationBackClosure?)
    func setRoot(_ controller: UIViewController, animated: Bool)
    
    var navigationController: UINavigationController { get }
}
