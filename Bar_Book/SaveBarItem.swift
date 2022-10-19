//
//  SaveBarItem.swift
//  Bar_Book
//
//  Created by Mychal Smith on 10/17/22.
//

import UIKit

class SaveBarItem {
    
    var addBarItem = AddBarItemView();
    
    var allBarItems = [BarItem]();
    
    let itemArchiveURL: URL = {
        
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask);
        
        let documentDirectory = documentsDirectories.first!;
        
        return documentDirectory.appendingPathComponent("items.plist");
        
    }()
    
    @discardableResult func createItem() -> BarItem {
        
        let newBarItem = BarItem(drinkTitle: addBarItem.drinkTitleField.text!, ingredients: addBarItem.ingredientsField.text!, directions: addBarItem.directionsField.text!, drinkImage: addBarItem.uploadImageView.image!);
        
        print(newBarItem);

        allBarItems.append(newBarItem);

        return newBarItem;
        
        
    }
    
    func removeItem(_ item: BarItem) {
        
        if let index = allBarItems.firstIndex(of: item) {
            allBarItems.remove(at: index);
        }
        
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        
        let movedItem = allBarItems[fromIndex]
        
        allBarItems.remove(at: fromIndex);
        
        allBarItems.insert(movedItem, at: toIndex);
        
    }
    
    @objc func saveChanges() -> Bool {
        
        print("Saving items to: \(itemArchiveURL)")
        
        do {
        
            let encoder = PropertyListEncoder();
        
            let data = try encoder.encode(allBarItems);
            
            try data.write(to: itemArchiveURL, options: [.atomic]);
            
            print("Saved all of the items");
            
            return true;
            
        } catch {
            
            print("Error encoding allItems: \(error)");
            
            return false;
            
        }
        
        
    }
    
    init() {
        
        do {
            
            let data = try Data(contentsOf: itemArchiveURL);
            
            let unarchiver = PropertyListDecoder();
            
            let items = try unarchiver.decode([BarItem].self, from: data);
            
            allBarItems = items;
            
        } catch {
            
            print("Error reading in saved items: \(error)");
            
        }
        
        let notificationCenter = NotificationCenter.default;
        
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil);
        
    }
    
}

