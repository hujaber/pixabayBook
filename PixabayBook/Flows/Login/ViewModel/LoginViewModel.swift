//
//  LoginViewModel.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 17/12/2022.
//

import UIKit
import RxSwift
import RxCocoa



protocol LoginViewModelProtocol: AnyObject {
    var showSignUp: PublishRelay<Void> { get }
    var email: PublishRelay<String> { get }
    var password: PublishRelay<String> { get }
    
    var emailErrorMessage: PublishRelay<String?> { get }
    var passwordErrorMessage: PublishRelay<String?> { get }
    var canLogin: BehaviorRelay<Bool> { get }
    var login: PublishRelay<Void> { get }
    var endFlow: PublishRelay<Void> { get }
}

final class LoginViewModel: LoginViewModelProtocol {
    let showSignUp: PublishRelay<Void> = .init()
    let email: PublishRelay<String> = .init()
    let password: PublishRelay<String> = .init()
    
    let emailErrorMessage: PublishRelay<String?> = .init()
    let passwordErrorMessage: PublishRelay<String?> = .init()
    let canLogin: BehaviorRelay<Bool> = .init(value: false)
    let login: PublishRelay<Void> = .init()
    let endFlow: PublishRelay<Void> = .init()
    
    private let disposeBag = DisposeBag()
    
    init(emailValidator: Validator, passwordValidator: Validator) {
        password
            .map {
                if passwordValidator.isValid($0) {
                    return nil
                } else {
                    return "Password must be 6-12 characters"
                }
            }
            .bind(to: passwordErrorMessage)
            .disposed(by: disposeBag)
        
        email
            .map {
                if emailValidator.isValid($0) {
                    return nil
                } else {
                    return "Email not valid"
                }
            }
            .bind(to: emailErrorMessage)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(email, password)
            .map { emailValidator.isValid($0) && passwordValidator.isValid($1) }
            .bind(to: canLogin)
            .disposed(by: disposeBag)
        
        login
            .withLatestFrom(Observable.combineLatest(email, password)) {
                ($1.0, $1.1)
            }
            .withUnretained(self)
            .subscribe(onNext: { result in
                result.0.login(withEmail: result.1.0, andPassword: result.1.1)
            })
            .disposed(by: disposeBag)
    }
    
    private func login(withEmail email: String, andPassword password: String) {
        endFlow.accept(())
    }
}
