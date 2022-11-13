//
//  BarItem.swift
//  Bar_Book
//
//  Created by Mychal Smith on 10/17/22.
//

import Foundation
import UIKit

class BarItem: Equatable, Codable, Identifiable { 
    
    var ingredients: String;
    
    var id = UUID()
    
    var drinkTitle: String;
//
//    var ratingValue: Int;
    
    var directions: String;
    
    //var drinkImage: Data;
    var drinkImageURL: String?
    
//    init(drinkTitle: String, ingredients: String, directions: String, drinkImage: UIImage ) {
//
//        self.drinkTitle = drinkTitle;
//
//        self.ingredients = ingredients;
//
//        self.directions = directions;
//
//        self.drinkImage = drinkImage.jpegData(compressionQuality: 0.5)!;
//    }
    
    init() {
        self.ingredients = ""
        self.drinkTitle = ""
        self.directions = ""
    }
    
//    convenience init(drinkTitle: String, ingredients: String, directions: String) {
//            
//            self.init(drinkTitle: "Cosmopolitan", ingredients: "Vodka, Cranberry Juice", ratingValue: 5, directions: "mix");
//        
//    }
    
    static func ==(lhs: BarItem, rhs: BarItem) -> Bool {
    
    return lhs.drinkTitle == rhs.drinkTitle
        && lhs.ingredients == rhs.ingredients
        && lhs.directions == rhs.directions
        && lhs.drinkImageURL == rhs.drinkImageURL;
    
    }
}
