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
    var sectionIdentifier: String? = nil
    
    init(cells: [CollectionViewCellModel]) {
        self.cells = cells
    }
}
