//
//  ImageDetailsController.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 19/12/2022.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

enum ImageDetailsItem {
    case image(url: String)
    case size(Int)
    case type(String)
    case tags([String])
    case userName(String)
    case views(Int)
    case like(Int)
    case comments(Int)
    case downloads(Int)
}

enum ImageDetailsSectionModel: SectionModelType {
    case information(items: [ImageDetailsItem])
    case engagement(items: [ImageDetailsItem])
    
    var items: [ImageDetailsItem] {
        switch self {
        case .information(let items):
            return items
        case .engagement(let items):
            return items
        }
    }
    
    init(original: ImageDetailsSectionModel, items: [ImageDetailsItem]) {
        switch original {
        case .engagement:
            self = .engagement(items: items)
        case .information:
            self = .information(items: items)
        }
    }
}

class ImageDetailsController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: ImageDetailsViewModelProtocol
    private let disposeBag = DisposeBag()
    
    init(withViewModel viewModel: ImageDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(.init(nibName: ImageDetailCell.nibName, bundle: nil),
                           forCellReuseIdentifier: ImageDetailCell.identifier)
        tableView.register(.init(nibName: ImageCell.nibName, bundle: nil),
                           forCellReuseIdentifier: ImageCell.identifier)
        activateBindings()
    }
    
    private func activateBindings() {
        let dataSource = Self.dataSource()
        viewModel.sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    static func dataSource() -> RxTableViewSectionedReloadDataSource<ImageDetailsSectionModel> {
        return .init { datasource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageDetailCell.identifier, for: indexPath) as! ImageDetailCell
            switch datasource[indexPath] {
            case.downloads(let nbOfDownloads):
                cell.set(title: "#Downloads", details: "\(nbOfDownloads)")
            case .comments(let nbComments):
                cell.set(title: "#Comments", details: "\(nbComments)")
            case .like(let nbLikes):
                cell.set(title: "#Likes", details: "\(nbLikes)")
            case .views(let nbView):
                cell.set(title: "#Views", details: "\(nbView)")
            case .userName(let name):
                cell.set(title: "Uploader name", details: name)
            case .tags(let tags):
                cell.set(title: "Tags", details: tags.joined(separator: ","))
            case .type(let type):
                cell.set(title: "Type", details: type)
            case .size(let size):
                cell.set(title: "Size", details: "\(size) Bytes")
            case .image(let imgURL):
                let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
                cell.setImageURL(imgURL)
                return cell
            }
            return cell
        }
    }


}
