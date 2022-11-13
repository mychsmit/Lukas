//
//  ViewBarItems.swift
//  Bar_Book
//
//  Created by Mychal Smith on 10/17/22.
//

import UIKit

class BarItemsView: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate { 
    
    var barItem: BarItem! {
        
        didSet {
            
            navigationItem.title = barItem.drinkTitle;
            
        }
        
    };
    
    //this is the data that I need to make editable - I am trying to make it show up within
    // a text view so I can have multiple lines i.e.
    //Vodka 1oz
    //Cranberry Juice 3oz
    //any other ingredients
    
    var onSave: ((BarItem) -> Void)?
    
    @IBOutlet var drinkTitleLabel: UITextField!
    
    @IBOutlet var ingredientsLabel: UITextField!
    
    @IBOutlet var directionsLabel: UITextField!
    
    @IBOutlet var uploadImageView: UIImageView!
    
    
    @IBAction func uploadImageButton(_ sender: UIButton) {
        
        let image = UIImagePickerController();
        
        image.delegate = self;
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary;
        
        image.allowsEditing = false;
        
        self.present(image, animated: true)
    }
    
    func handleBarItemImage() {
        guard let jpg = uploadImageView.image?.jpegData(compressionQuality: 1),
              let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent( "\(barItem.id.uuidString).jpg" )
        else { return }
        
        do {
            try jpg.write(to: directory, options: [.atomic])
            barItem.drinkImageURL = "\(barItem.id.uuidString).jpg"
        } catch { print( error.localizedDescription ) }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            uploadImageView.image = image;
        }
        else {
            print("error with image");
        }
        self.dismiss(animated: true, completion: nil)
        handleBarItemImage()
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated);
        
        drinkTitleLabel.text = barItem.drinkTitle;
        
        ingredientsLabel.text = barItem.ingredients;
        
        directionsLabel.text = barItem.directions;
        
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent( barItem.drinkImageURL ?? "" ),
           let data = try? Data(contentsOf: url) {
            uploadImageView.image = UIImage(data: data)
        } else {
            uploadImageView.image = UIImage(named: "cocktailImage")
        }
        
        //uploadImageView.image = UIImage(data:BarItem.drinkImage);
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated);
        
        view.endEditing(true);
        
        barItem.drinkTitle = drinkTitleLabel.text ?? "";
        
        barItem.ingredients = ingredientsLabel.text ?? "";
        
        barItem.directions = directionsLabel.text ?? "";
        onSave?( barItem )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder();
        
        return true;
        
    }
}
