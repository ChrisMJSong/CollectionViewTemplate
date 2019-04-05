//
//  ViewController.swift
//  CollectionViewTemplate
//
//  Created by ChrisMJSong on 01/04/2019.
//  Copyright © 2019 Moojong Song. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    private let itemsPerRow: CGFloat = 2
    private let userCellIdentifier = "UserCell"

    @IBOutlet weak var collectionView: UICollectionView!
    var collectionViewRenderer: CollectionViewShim!
    var sectionModels: [SectionInfo] = [SectionInfo(title: "Title", identifier: "HeaderView"), SectionInfo(title: "Title2", identifier: "HeaderView"), SectionInfo(title: "Title3", identifier: "HeaderView")]
    var cellModels: [[User]] = [[User(username: "1A", identifier: "UserCell")],
                           [User(username: "2A", identifier: "UserCell"), User(username: "2B", identifier: "OtherCell"), User(username: "2C", identifier: "OtherCell"), User(username: "2D", identifier: "UserCell")], [User(username: "3A", identifier: "UserCell")]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionViewRenderer = CollectionViewShim(cellTypes: [CellTypeDefinition(nibFileName: "UserCell", cellIdentifier: "UserCell"), CellTypeDefinition(nibFileName: "OtherCell", cellIdentifier: "OtherCell")], headerTypes:[HeaderTypeDefinition(nibFileName: "SupplementaryHeader", sectionIdentifier: "HeaderView", kind: UICollectionView.elementKindSectionHeader)], collectionView: collectionView)
        self.collectionViewRenderer.collectionViewModel = collectionViewModelForUserList(cellModels, sections: sectionModels)
        self.collectionView.delegate = self // Delegate implement in this class
    }
    
    @IBAction func addUser(_ sender: Any) {
        let randInt = arc4random()%10
        self.cellModels[0].append(
            User(username: "New User \(randInt)", identifier: userCellIdentifier)
        )
        self.collectionViewRenderer.newViewModelWithChangreset(
            collectionViewModelForUserList(cellModels, sections: nil), changeSet: .insert(
                IndexPath(item: self.cellModels[0].count - 1, section: 0)
            ), animate: true)
    }
    
    @IBAction func refreshAllUserName(_ sender: Any) {
        self.cellModels[1] = self.cellModels[1].map{_ in
            let randInt = arc4random()%10
            return User(username: "New User \(randInt)", identifier: userCellIdentifier)
        }
        let indexPaths = collectionView.indexPathsForVisibleItems
        
        for indexPath in indexPaths {
            self.collectionViewRenderer.newViewModelWithChangreset(collectionViewModelForUserList(cellModels, sections: nil), changeSet: .reload(indexPath), animate: true)
        }
    }
}

// MARK: UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Do action
        let user = cellModels[indexPath.section][indexPath.row]
        print("Clicked:", user.username)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem
        
        if indexPath.section == 0 {
            return CGSize(width: availableWidth + sectionInsets.left, height: availableWidth / 2)
        }
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
