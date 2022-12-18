//
//  MainScreenController.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MainScreenController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let viewModel: MainScreenViewModelProtocol
    
    init(withViewModel viewModel: MainScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        activateBindings()
    }
    
    private func setupTableView() {
        tableView.register(.init(nibName: ImageTableViewCell.nibName, bundle: nil),
                           forCellReuseIdentifier: ImageTableViewCell.identifier)
    }
    
    private func activateBindings() {
        viewModel.isLoading
            .bind(to: rx.isLoading)
            .disposed(by: disposeBag)
        
        viewModel.onError
            .bind(to: rx.onError)
            .disposed(by: disposeBag)
    }

}
