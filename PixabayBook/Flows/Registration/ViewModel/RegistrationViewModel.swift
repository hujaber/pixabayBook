//
//  RegistrationViewModel.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

protocol RegistrationViewModelProtocol: AnyObject {
    var email: PublishRelay<String> { get }
    var password: PublishRelay<String> { get }
    var age: PublishRelay<String> { get }
    
    var showLogin: PublishRelay<Void> { get }
    var signUp: PublishRelay<Void> { get }
    
    var canSignUp: BehaviorRelay<Bool> { get }
    
    var emailErrorMessage: PublishRelay<String?> { get }
    var passwordErrorMessage: PublishRelay<String?> { get }
    var ageErrorMessage: PublishRelay<String?> { get }
}

final class RegistrationViewModel: RegistrationViewModelProtocol {
    let email: PublishRelay<String> = .init()
    let password: PublishRelay<String> = .init()
    let age: PublishRelay<String> = .init()
    
    let showLogin: PublishRelay<Void> = .init()
    let signUp: PublishRelay<Void> = .init()
    let canSignUp: BehaviorRelay<Bool> = .init(value: false)
    
    let emailErrorMessage: PublishRelay<String?> = .init()
    let passwordErrorMessage: PublishRelay<String?> = .init()
    let ageErrorMessage: PublishRelay<String?> = .init()
    
    private let disposeBag = DisposeBag()
    
    init(emailValidator: Validator, passwordValidator: Validator, ageValidator: Validator) {
        
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
        
        age
            .map {
                if ageValidator.isValid($0) {
                    return nil
                } else {
                    return "Age must be between 18-99"
                }
            }
            .bind(to: ageErrorMessage)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(email, password, age)
            .map { emailValidator.isValid($0) && passwordValidator.isValid($1) && ageValidator.isValid($2) }
            .bind(to: canSignUp)
            .disposed(by: disposeBag)
        
        signUp
            .withLatestFrom(Observable.combineLatest(email, password, age)) {
                ($1.0, $1.1, $1.2)
            }
            .withUnretained(self)
            .subscribe { result in
                result.0.signUp(email: result.1.0, password: result.1.1, age: result.1.2)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func signUp(email: String, password: String, age: String) {
        
    }
    
}
