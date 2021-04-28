//
//  DetailViewController.swift
//  sidedishApp
//
//  Created by 김지선 on 2021/04/21.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case detailImages
        case info
        case descriptionImages
    }
    
    enum DataItem: Hashable {
        case detailImages(Image)
        case info(Detail)
        case descriptionImages(Image)
    }
    
    var category: String!
    var id: Int!
    
    private var cancellables: Set<AnyCancellable> = []
    private var detailViewModel: DetailViewModelType!
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, DataItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewModel = DetailViewModel()
        configureCollectionView()
        fetchData()
    }
    
    private func configureCollectionView() {
        let layout = DetailLayoutManager().createLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)

        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        
        let detailImageCellRegistration = UICollectionView.CellRegistration<DetailImageCell, DataItem>.init(handler: { (cell, indexPath, image) in
           
            dump(image)
            if case .detailImages(let image) = image {
                cell.configureCell(image: image.getImage())
            }
        })
        
        let infoCellRegistration = UICollectionView.CellRegistration<DetailInfoCell, DataItem>.init(cellNib: UINib(nibName: DetailInfoCell.reuseIdentifier, bundle: nil), handler: { (cell, indexPath, item) in
            if case .info(let item) = item {
                DispatchQueue.main.async {
                    cell.configureCell(item: item)
                }
            }
        })
        
        let descriptionImageCellRegistration = UICollectionView.CellRegistration<DetailImageCell, DataItem>.init(handler: { (cell, indexPath, image) in
            
            if case .descriptionImages(let image) = image {
                cell.configureCell(image: image.getImage())
            }
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let sectionKind = Section(rawValue: indexPath.section) else  { return UICollectionViewCell() }
            var cell: UICollectionViewCell
            
            switch sectionKind {
            case .detailImages:
                cell = collectionView.dequeueConfiguredReusableCell(using: detailImageCellRegistration, for: indexPath, item: item)
            case .info:
                cell = collectionView.dequeueConfiguredReusableCell(using: infoCellRegistration, for: indexPath, item: item)
                
            case .descriptionImages:
                cell = collectionView.dequeueConfiguredReusableCell(using: descriptionImageCellRegistration, for: indexPath, item: item)
            }
            
            return cell
        })
    }
    
    private func fetchData() {
        detailViewModel.dataChanged
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateSnapshot()
            }
            .store(in: &cancellables)
        detailViewModel.fetchData(path: category, path: id)  
    }

    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DataItem>()
        snapshot.appendSections(Section.allCases)

        snapshot.appendItems(detailViewModel.getDetailImages().map{DataItem.detailImages($0)}, toSection: .detailImages)
        snapshot.appendItems([DataItem.info(detailViewModel.getDetailItem())], toSection: .info)
        snapshot.appendItems(detailViewModel.getDescriptionImages().map{DataItem.descriptionImages($0)}, toSection: .descriptionImages)
        
        dataSource.apply(snapshot)
    }
}

