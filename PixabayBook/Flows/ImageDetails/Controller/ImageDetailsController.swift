//
//  ImageDetailsController.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 19/12/2022.
//

import UIKit
import RxCocoa
import RxSwift

class ImageDetailsController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: ImageDetailsViewModelProtocol
    
    init(withViewModel viewModel: ImageDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func activateBindings() {
        
    }


}
