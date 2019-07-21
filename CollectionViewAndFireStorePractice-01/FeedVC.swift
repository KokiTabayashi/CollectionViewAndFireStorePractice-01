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
//        fillBascket()
        getDataFromDatabase()
//        collectionView?.reloadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        fillBascket()
//        getDataFromDatabase()
//    collectionView?.reloadData()
//    }
    
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
    
//    func fillBascket() {
//        var newItem = Item(itemName: "1st Bascket 1st Item")
//        items.append(newItem)
//        newItem = Item(itemName: "1st Bascket 2nd Item")
//        items.append(newItem)
//        var newBascket = Bascket(bascketName: "1st Bascket", items: items)
//        basckets.append(newBascket)
//
//        items.removeAll()
//
//        newItem = Item(itemName: "2nd Bascket 1st Item")
//        items.append(newItem)
//        newItem = Item(itemName: "2nd Bascket 2nd Item")
//        items.append(newItem)
//        newBascket = Bascket(bascketName: "2nd Bascket", items: items)
//        basckets.append(newBascket)
//
//        collectionView?.reloadData()
//    }
    
    func getDataFromDatabase() {
        
        Firestore.firestore().collection("baskets").getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if snapshot!.isEmpty {
                print("DEBUG: Snapshot baskets is empty")
            } else {
                guard let snap = snapshot else { return }
                
                self.basckets.removeAll()
                
                for document in snap.documents {
                    let data = document.data()
                    let documentId = document.documentID
                    let bascketName = data["bascketName"] as? String ?? ""
                  
                    Firestore.firestore().collection("baskets").document(documentId).collection("items").getDocuments { (snapshot, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if snapshot!.isEmpty {
                            print("* DEBUG * Snapshot baskets items is empty")
                        } else {
                            guard let snap = snapshot else { return }
                            
                            self.items.removeAll()
                            
                            for document in snap.documents {
                                let data = document.data()
//                                let documentId = document.documentID
                                let itemName = data["itemName"] as? String ?? ""
                                
//                                print("** DEBUG ** Print from for statement: \(itemName)")
                                
                                let newItem = Item(itemName: itemName)
                                self.items.append(newItem)
                            }
                            
                            let newBascket = Bascket(bascketName: bascketName, items: self.items)
                            self.basckets.append(newBascket)
                            
                            print("*** DEBUG *** Bascket name: \(bascketName)")
                            print("*** DEBUG *** Num of items: \(self.items.count)")
                            for item in self.items {
                                let itemName = item.itemName as? String ?? ""
                                print("*** DEBUG *** Item name: \(itemName)")
                            }
                        }
                    }
//                    let newBascket = Bascket(bascketName: bascketName, items: self.items)
//                    self.basckets.append(newBascket)
//
//                    print("bascket name: \(bascketName)")
//                    print("num of items: \(self.items.count)")
//                    for item in self.items {
//                        print("item name: \(item.itemName)")
//                    }
                    
//                    self.getDetailDataFromDatabase(with: documentId, handler: { (items) in
//
//                        let newBascket = Bascket(bascketName: bascketName, items: items)
//                        self.basckets.append(newBascket)
//
//
//                        print(bascketName)
//                        for item in items {
//                            print(item.itemName)
//                        }
//                    })
                    
//                    self.getDetailDataFromDatabase(with: documentId, completion: { (error) in
//                        if let error = error {
//                            print(error.localizedDescription)
//                        } else {
//                            let newBascket = Bascket(bascketName: bascketName, items: self.items)
//                            self.basckets.append(newBascket)
//
//                            print(bascketName)
//                            for item in self.items {
//                                print(item.itemName)
//                            }
//                        }
//                    })
                    
//                    var newItem = Item(itemName: "1st Bascket 1st Item")
//                    self.items.append(newItem)
//                    newItem = Item(itemName: "1st Bascket 2nd Item")
//                    self.items.append(newItem)
//                    let newBascket = Bascket(bascketName: bascketName, items: self.items)
//                    self.basckets.append(newBascket)
                }
                self.collectionView?.reloadData()
            }
        }
    }
    
//    func getDetailDataFromDatabase(with documentId: String, completion: @escaping (_ error: Error?) -> ()) {
//        Firestore.firestore().collection("baskets").document(documentId).collection("items").getDocuments { (snapshot, error) in
//            if let error = error {
//                completion(error)
//            } else if snapshot!.isEmpty {
//                print("DEBUG: Snapshot baskets items is empty")
//                completion(nil)
//            } else {
//                guard let snap = snapshot else { return }
//
//                self.items.removeAll()
//
//                for document in snap.documents {
//                    let data = document.data()
//                    let documentId = document.documentID
//                    let itemName = data["itemName"] as? String ?? ""
//
//                    //                    print(itemName)
//
//                    let newItem = Item(itemName: itemName)
//                    self.items.append(newItem)
//                }
//                completion(nil)
//            }
//        }
//    }

    
//    func getDetailDataFromDatabase(with documentId: String, handler: @escaping(_ items: [Item]) -> ()) {
//        Firestore.firestore().collection("baskets").document(documentId).collection("items").getDocuments { (snapshot, error) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else if snapshot!.isEmpty {
//                print("DEBUG: Snapshot baskets items is empty")
//            } else {
//                guard let snap = snapshot else { return }
//
//                self.items.removeAll()
//
//                for document in snap.documents {
//                    let data = document.data()
//                    let documentId = document.documentID
//                    let itemName = data["itemName"] as? String ?? ""
//
////                    print(itemName)
//
//                    let newItem = Item(itemName: itemName)
//                    self.items.append(newItem)
//                }
//                handler(self.items)
//            }
//        }
//    }
}

