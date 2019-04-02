//
//  CollectionViewCellModel.swift
//  CollectionViewTemplate
//
//  Created by ChrisMJSong on 29/03/2019.
//  Copyright © 2019 Moojong Song. All rights reserved.
//

import UIKit

struct CollectionViewCellModel {
    let cellIdentifier: String
    let applyViewModelToCell: (UICollectionViewCell, Any) -> Void
    let customData: Any
    
    init(cellIdentifier: String, applyViewModelToCell: @escaping(UICollectionViewCell, Any)->Void, customData: Any) {
        self.cellIdentifier       = cellIdentifier
        self.applyViewModelToCell = applyViewModelToCell
        self.customData           = customData
    }
}

extension CollectionViewCellModel {
    func applyViewModelToCell(_ cell: UICollectionViewCell) {
        self.applyViewModelToCell(cell, self.customData)
    }
}
