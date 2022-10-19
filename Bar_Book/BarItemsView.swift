//
//  ViewBarItems.swift
//  Bar_Book
//
//  Created by Mychal Smith on 10/17/22.
//

import UIKit

class BarItemsView: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

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
    

    @IBOutlet var drinkTitleLabel: UITextField!
    
    @IBOutlet var ingredientsLabel: UITextField!
    
    @IBOutlet var directionsLabel: UITextField!
    
    @IBOutlet var uploadImageView: UIImageView!
    
    
    @IBAction func uploadImageButton(_ sender: UIButton) {
        
        let image = UIImagePickerController();
        
        image.delegate = self;
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary;
        
        image.allowsEditing = false;
        
        self.present(image, animated: true){
            
            
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            uploadImageView.image = image;
            }
        else {
        print("error with image");
    }
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated);
        
        drinkTitleLabel.text = BarItem.drinkTitle;
        
        ingredientsLabel.text = BarItem.ingredients;
        
        directionsLabel.text = BarItem.directions;
        
        uploadImageView.image = UIImage(data:BarItem.drinkImage);
        
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
