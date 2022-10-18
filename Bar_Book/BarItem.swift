//
//  BarItem.swift
//  Bar_Book
//
//  Created by Mychal Smith on 10/17/22.
//

import UIKit

class BarItem: Equatable, Codable {
    
    var ingredients: String;
    
    var drinkTitle: String;
    
    var ratingValue: Int;
    
    var directions: String;
    
    
    init(drinkTitle: String, ingredients: String, ratingValue: Int, directions: String) {
        
        self.drinkTitle = drinkTitle;
        
        self.ingredients = ingredients;
        
        self.ratingValue = ratingValue;
        
        self.directions = directions;
        
    }
    
    convenience init(random: Bool = false) {
        
        if random {
            
            self.init(drinkTitle: "Cosmopolitan", ingredients: "Vodka, Cranberry Juice", ratingValue: 5, directions: "mix");
            
        } else {
            
            self.init(drinkTitle: "", ingredients: "", ratingValue: 0, directions: "");
            
        }
        
    }
    
    static func ==(lhs: BarItem, rhs: BarItem) -> Bool {
    
    return lhs.drinkTitle == rhs.drinkTitle
        && lhs.ingredients == rhs.ingredients
        && lhs.ratingValue == rhs.ratingValue
        && lhs.directions == rhs.directions;
    
    }
}
