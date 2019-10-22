//
//  UserDefaults.swift
//  Quotes
//
//  Created by Agstya Technologies on 16/10/19.
//  Copyright © 2019 Mayur. All rights reserved.
//

import Foundation


class Helper {
    // Image Array
     let arrImg = [UIImage(named: "calm1")!,UIImage(named: "calm2")!,UIImage(named: "calm3")!,UIImage(named: "calm4")!,UIImage(named: "calm5")!,UIImage(named: "calm6")!,UIImage(named: "calm7")!,UIImage(named: "calm8")!,UIImage(named: "calm9")!,UIImage(named: "calm10")!,UIImage(named: "calm11")!,UIImage(named: "calm12")!,UIImage(named: "calm13")!,UIImage(named: "calm14")!,UIImage(named: "calm15")!,UIImage(named: "calm16")!,UIImage(named: "calm17")!,UIImage(named: "calm18")!,UIImage(named: "calm19")!,UIImage(named: "calm20")!,UIImage(named: "calm21")!,UIImage(named: "calm22")!,UIImage(named: "calm23")!,UIImage(named: "calm24")!,UIImage(named: "calm25")!,UIImage(named: "calm26")!,UIImage(named: "calm27")!,UIImage(named: "calm28")!,UIImage(named: "calm29")!,UIImage(named: "calm30")!,UIImage(named: "calm31")!]
    
    // Add favorite quote in user defaults array
    func setUserDefaults(favorite: String) {
        let defaults = UserDefaults.standard
        var arrSavedFavorite = defaults.object(forKey:"savedFavorite") as? [String] ?? [String]()
        arrSavedFavorite.append(favorite) 
        defaults.set(arrSavedFavorite, forKey: "savedFavorite")
        defaults.synchronize()
    }
    
    // remove quote from user default  array
    func removeFavorite(quote: String) {
        let defaults = UserDefaults.standard
        var arrSavedFavorite = defaults.object(forKey:"savedFavorite") as? [String] ?? [String]()
        let quoteRemove = arrSavedFavorite.firstIndex(of: quote )
        arrSavedFavorite.remove(at: quoteRemove! )
        defaults.set(arrSavedFavorite, forKey: "savedFavorite")
        defaults.synchronize()
    }
    
    //check userdefalt array contain quote or not
    func checkQuote(quote: String) -> Bool {
        let defaults = UserDefaults.standard
        let favorite = defaults.stringArray(forKey: "savedFavorite") ?? [String]()
        return favorite.contains(quote)
    }
    
    //set favorite
    func setFavoriteBtnImage(quote: String) -> Bool {
        let defaults = UserDefaults.standard
        let favorite = defaults.stringArray(forKey: "savedFavorite") ?? [String]()
        return favorite.contains(quote)
    }
}

