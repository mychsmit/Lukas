//
//  ViewBarItems.swift
//  Bar_Book
//
//  Created by Mychal Smith on 10/17/22.
//

import UIKit

class BarItemsView: UIViewController {

    var BarItem: BarItem! {
        
        didSet {
            
            navigationItem.title = BarItem.drinkTitle;
            
        }
        
    };
    
    //this is the data that I need to make editable - I am trying to make it show up within
    // a text view so I can have multiple lines i.e.
    //Vodka 1oz
    //Cranberry Juice 3oz
    //any other ingredients
    

    @IBOutlet var drinkTitleLabel: UILabel!
    
    @IBOutlet var ingredientsLabel: UILabel!
    
    @IBOutlet var directionsLabel: UILabel!
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated);
        
        drinkTitleLabel.text = BarItem.drinkTitle;
        
        ingredientsLabel.text = BarItem.ingredients;
        
        directionsLabel.text = BarItem.directions;
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated);
        
        view.endEditing(true);
        
        BarItem.drinkTitle = drinkTitleLabel.text ?? "";
        
        BarItem.ingredients = ingredientsLabel.text ?? "";
        
        BarItem.directions = directionsLabel.text ?? "";
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder();
        
        return true;
        
    }
}
