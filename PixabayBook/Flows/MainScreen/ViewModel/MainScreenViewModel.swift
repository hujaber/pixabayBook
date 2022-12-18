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
    var datasource: BehaviorRelay<[Photo]> { get }
    var didSelectPhoto: PublishRelay<Photo> { get }
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    
    let isLoading: BehaviorRelay<Bool> = .init(value: false)
    let onError: PublishRelay<Error> = .init()
    let datasource: BehaviorRelay<[Photo]> = .init(value: [])
    let didSelectPhoto: PublishRelay<Photo> = .init()
    
    private let images: BehaviorSubject<[Photo]> = .init(value: [])
    
    private let repository: ImagesRepositoryProtocol
    private let disposeBag = DisposeBag()
    
    init(repository: ImagesRepositoryProtocol) {
        self.repository = repository
        activateBindings()
    }
    
    private func activateBindings() {
        isLoading.accept(true)
        images
            .subscribe(onNext: { [weak self] photos in
                guard let self else {
                    return
                }
                self.datasource.accept(photos)
                self.isLoading.accept(false)
            }, onError: { [weak self] error in
                self?.isLoading.accept(false)
                self?.onError.accept(error)
            })
            .disposed(by: disposeBag)
            
    
        repository.fetchImages()
            .asObservable()
            .subscribe(images)
            .disposed(by: disposeBag)
    }
    
}

