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
//        detailViewModel.fetchData(path: "main", path: 0)
        configureCollectionView()
        configureDataSource()
        fetchData()
        dump(detailViewModel.getDetailItem())
        
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
            
            guard let url = URL(string: self.detailViewModel.getDetailItem().getDetailImage(at: indexPath.item)) else { return }
            cell.imageView.setImage(with: url)
        }
        
        let descriptionImageCellRegistration = UICollectionView.CellRegistration<DetailImageCell, DataItem> { (cell, indexPath, item) in
            
            guard let url = URL(string: self.detailViewModel.getDetailItem().getDescriptionImage(at: indexPath.item)) else { return }
            cell.imageView.setImage(with: url)
        }
        
//        let InfoCellRegistration = UICollectionView.CellRegistration<TestCell, Int> { (cell, indexPath, identifier) in
//
//        }
        
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
        detailViewModel.fetchData(path: "main", path: 0)
      // 파싱한 데이터
    }

    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DataItem>()
        snapshot.appendSections(Section.allCases)
    
        snapshot.appendItems(detailViewModel.getDetailItem().getDetailImages().map{DataItem.detailImages($0)}, toSection: .detailImages)
                                
        snapshot.appendItems(detailViewModel.getDetailItem().getDescriptionImages().map{DataItem.descriptionImages($0)}, toSection: .descriptionImages)
        
        dataSource.apply(snapshot)
    }
}

