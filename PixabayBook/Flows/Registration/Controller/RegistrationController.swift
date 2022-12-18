//
//  RegistrationController.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import UIKit
import RxCocoa
import RxSwift

class RegistrationController: UIViewController {
    
    @IBOutlet private weak var emailTextField: ErrorLabelTextField!
    @IBOutlet private weak var passwordTextField: ErrorLabelTextField!
    @IBOutlet private weak var ageTextField: ErrorLabelTextField!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private let viewModel: RegistrationViewModelProtocol
    
    init(withViewModel viewModel: RegistrationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        setupViews()
        activateBindings()
    }
    
    private func setupViews() {
        emailTextField.keyboardType = .emailAddress
        emailTextField.placeholder = "Email address"
        
        passwordTextField.textContentType = .newPassword
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Password"
        
        ageTextField.keyboardType = .numberPad
        ageTextField.placeholder = "Age"
        
        signUpButton.setTitle("Sign Up", for: .normal)
        loginButton.setTitle("Login", for: .normal)
    }
    
    private func activateBindings() {
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        ageTextField.rx.text.orEmpty
            .bind(to: viewModel.age)
            .disposed(by: disposeBag)
        
        viewModel.canSignUp
            .bind(to: signUpButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .bind(to: viewModel.signUp)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(to: viewModel.showLogin)
            .disposed(by: disposeBag)
        
        viewModel.emailErrorMessage
            .bind(to: emailTextField.errorLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.passwordErrorMessage
            .bind(to: passwordTextField.errorLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.ageErrorMessage
            .bind(to: ageTextField.errorLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
