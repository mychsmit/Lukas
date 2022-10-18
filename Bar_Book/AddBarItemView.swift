//
//  AddBarItem.swift
//  Bar_Book
//
//  Created by Mychal Smith on 10/17/22.
//

import UIKit

class AddBarItemView: UIViewController, UITextFieldDelegate {
    
    var SaveBarItem: SaveBarItem!
    
    var barItem: BarItem!;
    
    //this is the data that I am trying to pass over to the barbook view
    
    @IBOutlet var drinkTitleField: UITextField!
    
    @IBOutlet var ingredientsField: UITextView!
    
    @IBOutlet var directionsField: UITextView!
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true);
        
    }
    
//    @IBAction func saveButon(_ sender: UIBarButtonItem) {
//        
//        let newItem = SaveBarItem.createItem();
//        
//        if let index = SaveBarItem.allBarItems.firstIndex(of: newItem) {
//            
//            let indexPath = IndexPath(row: index, section: 0);
//            
//            tableView.insertRows(at: [indexPath], with: .automatic)
//            
//        }
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        drinkTitleField!.layer.borderWidth = 1;
        
        drinkTitleField!.layer.borderColor = UIColor.lightGray.cgColor;
        
        ingredientsField!.layer.borderWidth = 1;
        
        ingredientsField!.layer.borderColor = UIColor.lightGray.cgColor;
        
        directionsField!.layer.borderWidth = 1;
        
        directionsField!.layer.borderColor = UIColor.lightGray.cgColor;
    }


}
