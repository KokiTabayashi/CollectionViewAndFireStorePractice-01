//
//  ViewController.swift
//  CollectionViewPractice-01
//
//  Created by Koki Tabayashi on 7/18/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var bascket: Bascket?
    var basckets = [Bascket]()
    var item: Item?
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView!.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        fillBascket()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let height = width + 20
        
        return CGSize(width: width, height: height)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return basckets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        cell.bascket = basckets[indexPath.item]
        return cell
    }
    
    func fillBascket() {
        var newItem = Item(itemName: "1st Bascket 1st Item")
        items.append(newItem)
        newItem = Item(itemName: "1st Bascket 2nd Item")
        items.append(newItem)
        var newBascket = Bascket(bascketName: "1st Bascket", items: items)
        basckets.append(newBascket)
        
        items.removeAll()
        
        newItem = Item(itemName: "2nd Bascket 1st Item")
        items.append(newItem)
        newItem = Item(itemName: "2nd Bascket 2nd Item")
        items.append(newItem)
        newBascket = Bascket(bascketName: "2nd Bascket", items: items)
        basckets.append(newBascket)
        
        collectionView?.reloadData()
    }
    
    func getDataFromDatabase() {
        
        
        
        
    }
}

