//
//  AddBarItem.swift
//  Bar_Book
//
//  Created by Mychal Smith on 10/17/22.
//

import UIKit

class AddBarItemView: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var SaveBarItem: SaveBarItem!
    
    var BarItem: BarItem!;
    
    var BarBook: BarBookView!;
    
    //this is the data that I am trying to pass over to the barbook view
    
    @IBOutlet var drinkTitleField: UITextField!
    
    @IBOutlet var ingredientsField: UITextView!
    
    @IBOutlet var directionsField: UITextView!
    
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
    
    @IBAction func saveButon(_ sender: UIBarButtonItem) {
        
        let newItem = SaveBarItem.createItem();

        if let index = SaveBarItem.allBarItems.firstIndex(of: newItem) {

            let indexPath = IndexPath(row: index, section: 0);

            BarBook.tableView.insertRows(at: [indexPath], with: .automatic)

        }
        
    }
    
    
    
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
