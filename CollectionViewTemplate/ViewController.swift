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
    var model: [User] = [User(username: "A", identifier: "UserCell"), User(username: "B", identifier: "OtherCell"), User(username: "C", identifier: "OtherCell"), User(username: "D", identifier: "UserCell")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionViewRenderer = CollectionViewShim(cellTypes: [CellTypeDefinition(nibFileName: "UserCell", cellIdentifier: "UserCell"), CellTypeDefinition(nibFileName: "OtherCell", cellIdentifier: "OtherCell")], collectionView: collectionView)
        self.collectionViewRenderer.collectionViewModel = collectionViewModelForUserList(model)
        self.collectionView.delegate = self // Delegate implement in this class
    }
    
    @IBAction func addUser(_ sender: Any) {
        let randInt = arc4random()%10
        self.model.append(
            User(username: "New User \(randInt)", identifier: userCellIdentifier)
        )
        self.collectionViewRenderer.newViewModelWithChangreset(
            collectionViewModelForUserList(model), changeSet: .insert(
                IndexPath(item: self.model.count - 1, section: 0)
            ), animate: true)
    }
    
    @IBAction func refreshAllUserName(_ sender: Any) {
        self.model = self.model.map{_ in
            let randInt = arc4random()%10
            return User(username: "New User \(randInt)", identifier: userCellIdentifier)
        }
        let indexPaths = collectionView.indexPathsForVisibleItems
        
        for indexPath in indexPaths {
            self.collectionViewRenderer.newViewModelWithChangreset(collectionViewModelForUserList(model), changeSet: .reload(indexPath), animate: true)
        }
    }
}

// MARK: UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Do action
        let user = model[indexPath.row]
        print("Clicked:", user.username)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
