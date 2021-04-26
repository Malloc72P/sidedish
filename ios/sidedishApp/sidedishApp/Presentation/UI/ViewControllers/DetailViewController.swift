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
        case detailImages(String)
        case info(Detail)
        case descriptionImages(String)
    }
    
    private var category: String!
    private var id: Int!
    
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
//        collectionView.contentMode = .scaleAspectFit
        view.addSubview(collectionView)
        
        let detailImageCellRegistration = UICollectionView.CellRegistration<DetailImageCell, DataItem> { (cell, indexPath, image) in
            if case .detailImages(let image) = image {
                cell.configureCell(image: image)
            }
        }
        
        let detailInfoCellRegistration = UICollectionView.CellRegistration<DetailInfoCell, DataItem> { (cell, indexPath, item) in
            
            if case .detailImages(let item) = item {
                cell.configureCell(item: item)
            }
        }
        
        let descriptionImageCellRegistration = UICollectionView.CellRegistration<DetailImageCell, DataItem> { (cell, indexPath, image) in
            
            if case .descriptionImages(let image) = image {
                cell.configureCell(image: image)
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
//            guard let sectionKind = Section(rawValue: indexPath.section) else  { return UICollectionViewCell() }
            
            return Section(rawValue: indexPath.section)! == .detailImages ?
            collectionView.dequeueConfiguredReusableCell(using: detailImageCellRegistration, for: indexPath, item: item) :
            collectionView.dequeueConfiguredReusableCell(using: descriptionImageCellRegistration, for: indexPath, item: item)
        })
    }
    
    private func fetchData() {
        detailViewModel.dataChanged
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self!.updateSnapshot()
            }
            .store(in: &cancellables)
        detailViewModel.fetchData(path: "main", path: 1)
    }

    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DataItem>()
        snapshot.appendSections(Section.allCases)
    
        snapshot.appendItems(detailViewModel.getDetailItem().getDetailImages().map{DataItem.detailImages($0)}, toSection: .detailImages)
                                
        snapshot.appendItems(detailViewModel.getDetailItem().getDescriptionImages().map{DataItem.descriptionImages($0)}, toSection: .descriptionImages)
        
        dataSource.apply(snapshot)
    }
}

