//
//  Reactive.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    
    var isLoading: Binder<Bool> {
        return .init(self.base) { vc, isLoading in
            if isLoading {
                vc.showLoader()
            } else {
                vc.removeLoader()
            }
        }
    }
}

extension Reactive where Base: UIViewController {
    var onError: Binder<Error> {
        return .init(self.base) { vc, error in
            vc.showAlert(forError: error)
        }
    }
}
