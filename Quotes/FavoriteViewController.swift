//
//  FavoriteViewController.swift
//  Quotes
//
//  Created by Agstya Technologies on 16/10/19.
//  Copyright © 2019 Mayur. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    //MARK:- Array and Outlet
    @IBOutlet weak var btnSideMenu: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var lblNoFavorite: UILabel!
    
    var arrFavorite = UserDefaults.standard.stringArray(forKey: "savedFavorite") ?? [String]()
    let objHelper = Helper()
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayMenuBtn()
        setupUi()
        manageButtons()
    }
    
    //MARK:- IBAction Methods
    @IBAction func btnPrevious(_ sender: Any) {
        let currentPage = self.currentPage()
        if Int(currentPage) == 0 {
             print("no data available")
        } else {
            collectionView.scrollToItem(at: IndexPath(item: Int(currentPage) - 1, section: 0), at: .left, animated: true)
            setFavorite(theIndex: Int(currentPage) - 1)
        }
        manageButtons()
    }
    
    @IBAction func btnNext(_ sender: Any) {
        let currentPage = self.currentPage()
        if Int(currentPage) == arrFavorite.count - 1 {
            print("no data available")
        } else {
            collectionView.scrollToItem(at: IndexPath(item: Int(currentPage) + 1, section: 0), at: .right, animated: true)
            setFavorite(theIndex: Int(currentPage) + 1)
        }
        manageButtons()
    }
    
    @IBAction func onBtnFavoriteClick(_ sender: Any) {
        let currentPage = Int(self.currentPage())
        let quote = arrFavorite[currentPage]
        objHelper.removeFavorite(quote: quote)
        arrFavorite.remove(at: currentPage)
        self.collectionView.reloadData()
        setupUi()
        setFavorite(theIndex: currentPage )
    }
        

    //MARK:- Other Methods
    func displayMenuBtn() {
        btnSideMenu.target = self.revealViewController()
        btnSideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    func manageButtons() {
        let currentPage = Int(self.currentPage())
        if currentPage == 0 && arrFavorite.count - 1 == currentPage {
            btnPrevious.isEnabled = false
            btnNext.isEnabled = false
        } else if currentPage - 1 == 0 && currentPage != (arrFavorite.count - 1){
            btnNext.isEnabled = true
            btnPrevious.isEnabled = false
        } else if currentPage + 1 == (arrFavorite.count - 1) {
            btnNext.isEnabled = false
            btnPrevious.isEnabled = true
        } else if currentPage == 0 {
            btnNext.isEnabled = true
            btnPrevious.isEnabled = false
        } else if currentPage != 0 && currentPage + 1 != (arrFavorite.count - 1) {
            btnNext.isEnabled = true
            btnPrevious.isEnabled = true
        }
    }
    
    func setupUi() {
        if arrFavorite.count == 0 {
            lblNoFavorite.isHidden = false
            btnFavorite.isHidden = true
            btnPrevious.isHidden = true
            btnNext.isHidden = true
        } else {
            lblNoFavorite.isHidden = true
            btnFavorite.isSelected = true
            btnFavorite.setImage(UIImage(named: "filledStar")!, for: .selected)
        }
    }
    
    func setFavorite(theIndex: Int) {
        if arrFavorite.count != 0 {
            btnFavorite.isSelected = true
            btnFavorite.setImage(UIImage(named: "filledStar")!, for: .selected)
        }
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight = collectionView.bounds.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFavorite.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FavoriteCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavoriteCollectionViewCell
        cell.lblQuote.text = arrFavorite[indexPath.row]
        cell.imgQuote.image = objHelper.arrImg.randomElement()
        return cell
    }
    
    func currentPage() -> CGFloat {
        let currentPage = (self.collectionView.contentOffset.x / self.collectionView.frame.size.width)
        return currentPage
    }
}

extension FavoriteViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let currentPage = (self.collectionView.contentOffset.x / self.collectionView.frame.size.width)
        collectionView.scrollToItem(at: IndexPath(item:  Int(round(currentPage)) , section: 0), at: .right, animated: true)
    }
}

