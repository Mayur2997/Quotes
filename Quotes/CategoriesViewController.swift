//
//  ViewController.swift
//  Quotes
//
//  Created by Agstya Technologies on 09/10/19.
//  Copyright © 2019 Mayur. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

//MARK:- Structure
struct Quotestruct {
    let quote: String
}

struct CategoriesStruct {
    let category: String
    let arrQuotes: [Quotestruct]
}

class CategoriesViewController: UIViewController {
    
    //MARK:- Outlet and Variables Declaration
    @IBOutlet weak var tableViewQuoteCategory: UITableView!
    @IBOutlet weak var btnSideMenu: UIBarButtonItem!
  
    var arrCategory = [CategoriesStruct]()
    var arrFavorites = [String]()
    
    let group = DispatchGroup()
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayMenuBtn()
        showActivityIndicator()
        requestData()
        setupUI()
    }
    
    //MARK:- other Methods
    // UIController
    func setupUI() {
        tableViewQuoteCategory.tableFooterView = UIView()
    }
    //menu bar button
    func displayMenuBtn() {
        btnSideMenu.target = self.revealViewController()
        btnSideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    //show activityIndicator
    func showActivityIndicator() {
//        tableViewQuoteCategory.isHidden = true
//        SVProgressHUD.show(withStatus: "Loading...")
    }
    
    //hide activitiIndicator
    func hideActivityIndicator() {
        self.tableViewQuoteCategory.isHidden = false
        self.tableViewQuoteCategory.reloadData()
        SVProgressHUD.dismiss()
    }
    
    //MARK:- API Call
    func requestData() {
        // json data request
        Alamofire.request("https://raw.githubusercontent.com/vtboyarc/SimpleZenQuotes/master/SimpleZenQuotes.json").responseJSON { (response) in
            if let json = response.result.value {
                if let arrJson = json as? [[String: Any]] {
                    for theValue in arrJson {
                        if let categoryName = theValue["Category"] as? String {
                            if let arrQuotes = theValue["Quotes"] as? [[String: Any]] {
                                var quoteStruct = [Quotestruct]()
                                for quoteValue in arrQuotes {
                                    if let strQuote = quoteValue["quote"] as? String {
                                        let structQuote = Quotestruct(quote: strQuote)
                                        quoteStruct.append(structQuote)
                                    }
                                }
                                let theStruct = CategoriesStruct(category: categoryName , arrQuotes: quoteStruct)
                                self.arrCategory.append(theStruct)
                                self.tableViewQuoteCategory.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
}

//MARK:- TableView Controller
extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCategory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: QuoteCategoriesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QuoteCategoriesTableViewCell
        cell.quoteCategoriesLabel.text = arrCategory[indexPath.row].category
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewQuoteCategory.deselectRow(at: indexPath, animated: true)
        let quotes: QuotesDisplayViewController = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as! QuotesDisplayViewController
        quotes.arrQuotes = self.arrCategory[indexPath.row].arrQuotes
        quotes.quoteType = arrCategory[indexPath.row].category
        self.navigationController?.pushViewController(quotes, animated: true)
    }
}
