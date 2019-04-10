//
//  CollectionViewSectionModel.swift
//  CollectionViewTemplate
//
//  Created by ChrisMJSong on 29/03/2019.
//  Copyright © 2019 Moojong Song. All rights reserved.
//

import UIKit

struct CollectionViewSectionModel {
    let cells: [CollectionViewCellModel]
    var sectionInfo: Any? = nil
    let applyViewModelToSectionView: (UICollectionReusableView, Any?) -> Void
    
    init(cells: [CollectionViewCellModel], applyViewModelToSectionView: @escaping(UICollectionReusableView, Any?)->Void, sectionInfo: SectionInfo?) {
        self.cells = cells
        self.applyViewModelToSectionView = applyViewModelToSectionView
        self.sectionInfo = sectionInfo
    }
}

extension CollectionViewSectionModel {
    func applyViewModelToSectionView(_ cell: UICollectionReusableView) {
        self.applyViewModelToSectionView(cell, self.sectionInfo)
    }
}
