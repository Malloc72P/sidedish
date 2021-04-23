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
        //case info
        case descriptionImages
    }
    
    enum DataItem: Hashable {
        case detailImages(String)
        //case info(Detail)
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
        configureDataSource()
        fetchData()
    }
    
    private func configureCollectionView() {
        let layout = DetailLayoutManager().createLayout()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }
    
    func configureDataSource() {
        
        let detailImageCellRegistration = UICollectionView.CellRegistration<DetailImageCell, DataItem> { (cell, indexPath, item) in
            
            if case .detailImages(let image) = item {
                guard let url = URL(string: image) else { return }
                cell.backgroundColor = .blue
                cell.imageView.setImage(with: url)
            }
        }
        
        let descriptionImageCellRegistration = UICollectionView.CellRegistration<DetailImageCell, DataItem> { (cell, indexPath, item) in
            
            if case .descriptionImages(let image) = item {
                guard let url = URL(string: image) else { return }
                cell.backgroundColor = .blue
                cell.imageView.setImage(with: url)
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
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

