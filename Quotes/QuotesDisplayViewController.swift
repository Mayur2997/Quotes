//
//  secondViewController.swift
//  Quotes
//
//  Created by Agstya Technologies on 10/10/19.
//  Copyright © 2019 Mayur. All rights reserved.
//

import UIKit

class QuotesDisplayViewController: UIViewController {
    
    //MARK:- Array and Outlet declaration
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var arrQuotes = [Quotestruct]()
    var quoteType = ""
    var arrFavorites = ""
    let objHelper = Helper()
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFavoriteBtnState()
    }
    
    //MARK:- IBAction Methods
    @IBAction func btnFavoritePressed(_ sender: Any) {
        self.btnFavorite.isSelected = !self.btnFavorite.isSelected
        let currentPage = self.currentPage()
        if self.btnFavorite.isSelected {
            arrFavorites = arrQuotes[Int(round(currentPage))].quote
            objHelper.setUserDefaults(favorite: arrFavorites)
        } else {
            let quote = arrQuotes[Int(currentPage)].quote
            objHelper.removeFavorite(quote: quote)
        }       
    }
    
    @IBAction func previousBtn(_ sender: Any) {
        let currentPage = self.currentPage()
        collectionView.scrollToItem(at: IndexPath(item:  Int(currentPage) - 1, section: 0), at: .left, animated: true)
        if Int(currentPage) == 0 {
            print("no page available")
        } else {
            setFavorite(theIndex: Int(currentPage) - 1)
        }
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        let currentPage = self.currentPage()
        collectionView.scrollToItem(at: IndexPath(item: Int(currentPage) + 1, section: 0), at: .right, animated: true)
        if Int(currentPage) == arrQuotes.count - 1 {
            print("no page available")
        } else {
            setFavorite(theIndex: Int(currentPage) + 1)
        }
    }

    //MARK:- Other Method
    func setupUI() {
        navigationItem.title = quoteType
        btnFavorite.setImage(UIImage(named: "emptyStar")!, for: .normal)
        btnFavorite.setImage(UIImage(named: "filledStar")!, for: .selected)
    }
    
    func setFavoriteBtnState() {
        let currentPage = self.currentPage()
        let quote = arrQuotes[Int(currentPage)].quote
        if objHelper.checkQuote(quote: quote) {
            self.btnFavorite.isSelected = true
            btnFavorite.setImage(UIImage(named: "filledStar")!, for: .selected)
        } else {
            self.btnFavorite.isSelected = false
            btnFavorite.setImage(UIImage(named: "emptyStar")!, for: .normal)
        }
    }
    
    func setFavorite(theIndex: Int) {
        let quote = arrQuotes[Int((theIndex))].quote
        if objHelper.setFavoriteBtnImage(quote: quote) {
            self.btnFavorite.isSelected = true
            btnFavorite.setImage(UIImage(named: "filledStar")!, for: .selected)
        } else {
            self.btnFavorite.isSelected = false
            btnFavorite.setImage(UIImage(named: "emptyStar")!, for: .normal)
        }
    }
    
    func currentPage() -> CGFloat {
         let currentPage = (self.collectionView.contentOffset.x / self.collectionView.frame.size.width)
         return currentPage
    }
}

//MARK:- CollectionView
extension QuotesDisplayViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight = collectionView.bounds.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrQuotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:QuoteDisplayCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! QuoteDisplayCollectionViewCell
        cell.quoteBackgroundImg.image = objHelper.arrImg.randomElement()
        cell.quoteLbl.text = arrQuotes[indexPath.row].quote
        return cell
    }
}

extension QuotesDisplayViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let currentPage = (self.collectionView.contentOffset.x / self.collectionView.frame.size.width)
        collectionView.scrollToItem(at: IndexPath(item:  Int(round(currentPage)) , section: 0), at: .right, animated: true)
        setFavorite(theIndex: Int(round(currentPage)))
    }
}
