//
//  ApplicationCoordinator.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 17/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class ApplicationCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var isCompleted: (() -> Void)?
    
    private let router: RouterNavigationProtocol
    private let disposeBag = DisposeBag()
    
    init(withWindow window: UIWindow) {
        let navigationController = UINavigationController()
        self.router = RouterNavigation(navigationController: navigationController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        startMainFlow()
        return
        let viewModel = LoginViewModel(emailValidator: EmailValidator(), passwordValidator: PasswordValidator())
        
        viewModel.showSignUp
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { strongSelf, _ in
                strongSelf.showSignUpScreen()
            }
            .disposed(by: disposeBag)
        
        viewModel.endFlow
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { strongSelf, _ in
                strongSelf.startMainFlow()
            }
            .disposed(by: disposeBag)
        
        let loginController = LoginController(withViewModel: viewModel)
        router.setRoot(loginController, animated: true)
    }
    
    private func showSignUpScreen() {
        let viewModel = RegistrationViewModel(emailValidator: EmailValidator(),
                                              passwordValidator: PasswordValidator(),
                                              ageValidator: AgeValidator())
        viewModel.showLogin
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { strongSelf, _ in
                strongSelf.router.pop(true)
            }
            .disposed(by: disposeBag)
        
        viewModel.endFlow
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { strongSelf, _ in
                strongSelf.startMainFlow()
            }
            .disposed(by: disposeBag)
        
        let controller = RegistrationController(withViewModel: viewModel)
        router.push(controller, isAnimated: true, onNavigateBack: nil)
    }
    
    private func startMainFlow() {
        let dataSource = PixabayDataSource(apiClient: APIClient())
        let repository = ImagesRepository(withDataSource: dataSource)
        let viewModel = MainScreenViewModel(repository: repository)
        viewModel.didSelectPhoto
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { strongSelf, photo in
                strongSelf.showPhotoDetailsScreen(forPhoto: photo)
            }
            .disposed(by: disposeBag)
        let controller = MainScreenController(withViewModel: viewModel)
        router.setRoot(controller, animated: true)
    }
    
    private func showPhotoDetailsScreen(forPhoto photo: Photo) {
        let viewModel = ImageDetailsViewModel(photo: photo)
        let controller = ImageDetailsController(withViewModel: viewModel)
        router.push(controller, isAnimated: true, onNavigateBack: nil)
    }

}
