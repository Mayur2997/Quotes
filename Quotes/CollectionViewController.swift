//
//  CollectionViewController.swift
//  Quotes
//
//  Created by Agstya Technologies on 09/10/19.
//  Copyright © 2019 Mayur. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    //MARK:- Array declaration
    var arrQuotes = [Quotestruct]()
    let arrImg = [#imageLiteral(resourceName: "calm1.jpg"),#imageLiteral(resourceName: "calm8"),#imageLiteral(resourceName: "calm24"),#imageLiteral(resourceName: "calm12"),#imageLiteral(resourceName: "calm18"),#imageLiteral(resourceName: "calm16"),#imageLiteral(resourceName: "calm27"),#imageLiteral(resourceName: "calm7"),#imageLiteral(resourceName: "calm6"),#imageLiteral(resourceName: "calm22"),#imageLiteral(resourceName: "calm28"),#imageLiteral(resourceName: "calm25"),#imageLiteral(resourceName: "calm26"),#imageLiteral(resourceName: "calm19"),#imageLiteral(resourceName: "calm14"),#imageLiteral(resourceName: "calm21"),#imageLiteral(resourceName: "calm26"),#imageLiteral(resourceName: "calm12"),#imageLiteral(resourceName: "calm13"),#imageLiteral(resourceName: "calm28"),#imageLiteral(resourceName: "calm23"),#imageLiteral(resourceName: "calm5"),#imageLiteral(resourceName: "calm4"),#imageLiteral(resourceName: "calm22")]
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}


//MARK:- CollectionViewController
extension CollectionViewController  {
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrQuotes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.quoteBackgroundImg.image = arrImg.randomElement()
        cell.quoteLbl.text = arrQuotes[indexPath.row].quote
        cell.quoteLbl.sizeToFit()
        return cell
    }
}
