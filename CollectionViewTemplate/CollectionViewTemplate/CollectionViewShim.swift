//
//  CollectionViewShim.swift
//  CollectionViewTemplate
//
//  Created by ChrisMJSong on 29/03/2019.
//  Copyright © 2019 Moojong Song. All rights reserved.
//

import UIKit

enum Changeset {
    case insert(IndexPath)
    case delete(IndexPath)
    case reload(IndexPath)
}

struct CellTypeDefinition {
    let nibFileName: String
    let cellIdentifier: String
}

public final class CollectionViewShim: NSObject {
    var collectionViewModel: CollectionViewModel!
    let cellTypes: [CellTypeDefinition]
    let collectionView: UICollectionView
    
    init(cellTypes: [CellTypeDefinition], collectionView: UICollectionView) {
        self.cellTypes = cellTypes
        self.collectionView = collectionView
        
        cellTypes.forEach {
            let nibFile = UINib(nibName: $0.nibFileName, bundle: nil)
            collectionView.register(nibFile, forCellWithReuseIdentifier: $0.cellIdentifier)
        }
        
        super.init()
        
        self.collectionView.dataSource = self
//        self.collectionView.delegate = self   // implementation in ViewController
    }
    
    func newViewModelWithChangreset(_ newViewModel: CollectionViewModel, changeSet: Changeset) {
        self.newViewModelWithChangreset(newViewModel, changeSet: changeSet, animate: false)
    }
    
    func newViewModelWithChangreset(_ newViewModel: CollectionViewModel, changeSet: Changeset, animate: Bool) {
        self.collectionViewModel = newViewModel
        
        if animate {
            switch changeSet {
            case let .insert(indexPath):
                self.collectionView.insertItems(at: [indexPath])
                
            case let .delete(indexPath):
                self.collectionView.deleteItems(at: [indexPath])
                break
                
            case let .reload(indexPath):
                self.collectionView.reloadItems(at: [indexPath])
                break
            }
        } else {
            self.collectionView.reloadData()
        }
    }
}

extension CollectionViewShim: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionViewModel.sections[section].cells.count
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collectionViewModel.sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = self.collectionViewModel[indexPath]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellIdentifier, for: indexPath)
        
        cellViewModel.applyViewModelToCell(cell)
        
        return cell
    }
}
