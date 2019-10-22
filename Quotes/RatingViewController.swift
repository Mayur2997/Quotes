//
//  RatingViewController.swift
//  Quotes
//
//  Created by Agstya Technologies on 15/10/19.
//  Copyright © 2019 Mayur. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {
    //MARK:- outlet
    @IBOutlet weak var btnSideMenu: UIBarButtonItem!
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayMenuBtn()
    }
    
    //MARK:- other method
    func displayMenuBtn() {
        btnSideMenu.target = self.revealViewController()
        btnSideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}
