//
//  LoginController.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 17/12/2022.
//

import UIKit
import RxCocoa
import RxSwift

final class LoginController: UIViewController {
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var emailTextField: ErrorLabelTextField!
    @IBOutlet private weak var passwordTextField: ErrorLabelTextField!
    @IBOutlet private weak var signUpButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private let viewModel: LoginViewModelProtocol
    
    init(withViewModel viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateBindings()
        title = "Login"
    }
    
    private func setupViews() {
        loginButton.setTitle("Login", for: .normal)
        signUpButton.setTitle("Sign Up", for: .normal)
        
        passwordTextField.isSecureTextEntry = true
    }
    
    private func activateBindings() {
        signUpButton.rx.tap
            .bind(to: viewModel.showSignUp)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        viewModel.passwordErrorMessage
            .bind(to: passwordTextField.errorLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.emailErrorMessage
            .bind(to: emailTextField.errorLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.canLogin
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(to: viewModel.login)
            .disposed(by: disposeBag)
    }
    
}
