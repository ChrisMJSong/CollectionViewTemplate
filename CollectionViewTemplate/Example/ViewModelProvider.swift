//
//  ViewModelProvider.swift
//  CollectionViewTemplate
//
//  Created by ChrisMJSong on 01/04/2019.
//  Copyright © 2019 Moojong Song. All rights reserved.
//

import UIKit

func collectionViewModelForUserList(_ users: [User]) -> CollectionViewModel {
    return CollectionViewModel(sections: [
        CollectionViewSectionModel(cells:
            users.map({viewModelForUser($0)}))
        ])
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
