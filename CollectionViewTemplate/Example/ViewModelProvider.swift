//
//  ViewModelProvider.swift
//  CollectionViewTemplate
//
//  Created by ChrisMJSong on 01/04/2019.
//  Copyright © 2019 Moojong Song. All rights reserved.
//

import UIKit

func collectionViewModelForUserList(_ users: [[User]], sections: [SectionInfo]?) -> CollectionViewModel {
    var collectionViewItem: [(users: [User], section: SectionInfo?)] = []
    for i in 0..<users.count {
        collectionViewItem.append((users: users[i], section: sections?[i]))
    }
    
    return CollectionViewModel(sections: collectionViewItem.map({
        viewModelForSection(cells: $0.users.map({viewModelForUser($0)}), section: $0.section)
    }))
}

func viewModelForSection(cells: [CollectionViewCellModel], section: SectionInfo?) -> CollectionViewSectionModel {
    func applyViewModelToSectionView(_ headerView: UICollectionReusableView, sectionInfo: Any?) {
        switch headerView {
        case is SupplementaryHeader:
            guard let sectionView = headerView as? SupplementaryHeader else { return }
            guard let sectionInfo = sectionInfo as? SectionInfo else { return }
            sectionView.titleLabel.text = sectionInfo.title
        default:
            return
        }
    }
    
    return CollectionViewSectionModel(cells: cells, applyViewModelToSectionView: applyViewModelToSectionView, sectionInfo: section)
}

func viewModelForUser(_ user: User) -> CollectionViewCellModel {
    func applyViewModelToCell(_ cell: UICollectionViewCell, user: Any) {
        switch cell {
        case is UserCell:
            guard let cell = cell as? UserCell else { return }
            guard let user = user as? User else { return }
            cell.nameLabel.text = user.username
            
        case is OtherCell:
            guard let cell = cell as? OtherCell else { return }
            guard let user = user as? User else { return }
            cell.otherLabel.text = user.username
            
        default:
            return
        }
    }
    
    return CollectionViewCellModel(cellIdentifier: user.identifier, applyViewModelToCell: applyViewModelToCell, customData: user)
}
