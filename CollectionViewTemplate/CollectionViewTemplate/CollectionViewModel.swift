//
//  CollectionViewModel.swift
//  CollectionViewTemplate
//
//  Created by ChrisMJSong on 29/03/2019.
//  Copyright © 2019 Moojong Song. All rights reserved.
//

import Foundation

struct CollectionViewModel {
    let sections: [CollectionViewSectionModel]
    
    init(sections: [CollectionViewSectionModel]) {
        self.sections = sections
    }
    
    subscript(indexpath: IndexPath) -> CollectionViewCellModel {
        return self.sections[indexpath.section].cells[indexpath.row]
    }
}
