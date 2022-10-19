//
//  ViewController.swift
//  Bar_Book
//
//  Created by Mychal Smith on 10/12/22.
//

import UIKit

class BarBookView: UITableViewController {
    
    var saveBarItem = SaveBarItem()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return saveBarItem.allBarItems.count;
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell");
        let cell = tableView.dequeueReusableCell(withIdentifier: "barItemCell", for: indexPath) as! BarItemCell;
        
        let item = saveBarItem.allBarItems[indexPath.row]
        
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent( item.drinkImageURL ?? "" ),
           let data = try? Data(contentsOf: url) {
            cell.drinkImageView.image = UIImage(data: data)
        } else {
            cell.drinkImageView.image = UIImage(named: "cocktailImage")
        }
        
        cell.drinkTitleLabel.text = item.drinkTitle;
        
        cell.ingredientsLabel.text = item.ingredients;
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let item = saveBarItem.allBarItems[indexPath.row];
            
            saveBarItem.removeItem(item);
            
            tableView.deleteRows(at: [indexPath], with: .automatic);
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        saveBarItem.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row);
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        tableView.rowHeight = UITableView.automaticDimension;
        
        tableView.estimatedRowHeight = 120;
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
                
            case "showBarItem":
                
                if let row = tableView.indexPathForSelectedRow?.row {
                    
                    let item = saveBarItem.allBarItems[row];
                    
                    let BarItemsView = segue.destination as! BarItemsView;
                    
                    BarItemsView.barItem = item;
                    BarItemsView.onSave = { barItem in
                        self.saveBarItem.update(with: barItem)
                    }
                    
                }
                
            case "addBarItem":
                if let barItemsView = segue.destination as? AddBarItemView {
                    
                    barItemsView.onSave = { barItem in
                        self.saveBarItem.update(with: barItem)
                    }
                }
                
            default: preconditionFailure("Unexpected segue identifier.")
                
        }
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated);
        
        tableView.reloadData();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
        
        navigationItem.leftBarButtonItem = editButtonItem;
        
    }
    
    
}

