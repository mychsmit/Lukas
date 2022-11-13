//
//  AddBarItem.swift
//  Bar_Book
//
//  Created by Mychal Smith on 10/17/22.
//

import UIKit

class AddBarItemView: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate { 
    
    //var saveBarItem = SaveBarItem()
    
    //var BarItem: BarItem!;
    var barItem = BarItem()
    var onSave: (( BarItem ) -> Void)?
    
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

        self.present(image, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            uploadImageView.image = image;
            handleBarItemImage()
        }
        else {
            print("error with image");
        }
        self.dismiss(animated: true, completion: nil)
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
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true);
        
    }
    
    @IBAction func saveButon(_ sender: UIBarButtonItem) {
        barItem.drinkTitle = drinkTitleField.text ?? ""
        barItem.directions = directionsField.text ?? ""
        barItem.ingredients = ingredientsField.text ?? ""
        onSave?( self.barItem )
        navigationController?.popToRootViewController(animated: true)
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
