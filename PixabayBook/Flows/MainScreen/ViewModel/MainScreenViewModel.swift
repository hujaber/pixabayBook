//
//  MainScreenViewModel.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import RxSwift
import RxCocoa

protocol MainScreenViewModelProtocol: AnyObject {
    var isLoading: BehaviorRelay<Bool> { get }
    var onError: PublishRelay<Error> { get }
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    
    let isLoading: BehaviorRelay<Bool> = .init(value: false)
    let onError: PublishRelay<Error> = .init()
    
    private let repository: ImagesRepositoryProtocol
    
    init(repository: ImagesRepositoryProtocol) {
        self.repository = repository
    }
    
}

