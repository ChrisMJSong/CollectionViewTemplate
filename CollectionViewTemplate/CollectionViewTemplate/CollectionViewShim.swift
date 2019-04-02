//
//  CollectionViewShim.swift
//  CollectionViewTemplate
//
//  Created by ChrisMJSong on 29/03/2019.
//  Copyright © 2019 Moojong Song. All rights reserved.
//

import UIKit

enum Changeset {
    case add(IndexPath)
    case delete(IndexPath)
    case refreshOnly
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
