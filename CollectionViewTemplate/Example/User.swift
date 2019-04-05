//
//  User.swift
//  CollectionViewTemplate
//
//  Created by ChrisMJSong on 01/04/2019.
//  Copyright © 2019 Moojong Song. All rights reserved.
//

import Foundation

struct User {
    let username: String
    var identifier: String
    var sectionIdentifier: String?
    
    init(username: String, identifier: String) {
        self.username   = username
        self.identifier = identifier
    }
}
