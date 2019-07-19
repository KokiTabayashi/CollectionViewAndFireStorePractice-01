//
//  Bascket.swift
//  CollectionViewPractice-01
//
//  Created by Koki Tabayashi on 7/18/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import Foundation

class Bascket {
    private(set) var bascketName: String!
    private(set) var items = [Item]()
    
    init(bascketName: String, items: [Item]) {
        self.bascketName = bascketName
        self.items = items
    }
}
