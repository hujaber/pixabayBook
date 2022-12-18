//
//  Validator.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import Foundation

protocol Validator {
    func isValid(_ input: String) -> Bool
}

struct EmailValidator: Validator {
    func isValid(_ input: String) -> Bool {
        let pattern = "^[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9.-]+(?<!\\.)\\.[A-Za-z]{2,6}$"
        let patternPred = NSPredicate(format:"SELF MATCHES %@", pattern)
        return patternPred.evaluate(with: input)
    }
}

struct PasswordValidator: Validator {
    func isValid(_ input: String) -> Bool {
        input.count >= 6 && input.count <= 12
    }
}


struct AgeValidator: Validator {
    func isValid(_ input: String) -> Bool {
        guard let input = Int(input) else {
            return false
        }
        return (18...99).contains(input)
    }
}
