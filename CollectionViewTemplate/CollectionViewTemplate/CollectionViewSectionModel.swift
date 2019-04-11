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
    var sectionIdentifer: String? = nil
    var customData: Any? = nil
    let applyViewModelToSectionView: (UICollectionReusableView, Any?) -> Void
    
    init(sectionIdentifier: String?, cells: [CollectionViewCellModel], applyViewModelToSectionView: @escaping(UICollectionReusableView, Any?)->Void, customData: Any?) {
        self.sectionIdentifer = sectionIdentifier
        self.cells = cells
        self.applyViewModelToSectionView = applyViewModelToSectionView
        self.customData = customData
    }
}

extension CollectionViewSectionModel {
    func applyViewModelToSectionView(_ cell: UICollectionReusableView) {
        self.applyViewModelToSectionView(cell, self.customData)
    }
}
