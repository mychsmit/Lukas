//
//  ViewController.swift
//  Bar_Book
//
//  Created by Mychal Smith on 10/12/22.
//

import UIKit

class BarBookView: UITableViewController {
    
    var SaveBarItem: SaveBarItem!
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SaveBarItem.allBarItems.count;
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell");
        let cell = tableView.dequeueReusableCell(withIdentifier: "barItemCell", for: indexPath) as! BarItemCell;
        
        let item = SaveBarItem.allBarItems[indexPath.row]
        
        cell.drinkTitleLabel.text = item.drinkTitle;
        
        cell.ingredientsLabel.text = item.ingredients;
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let item = SaveBarItem.allBarItems[indexPath.row];
            
            SaveBarItem.removeItem(item);
            
            tableView.deleteRows(at: [indexPath], with: .automatic);
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        SaveBarItem.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row);
        
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
                
                let item = SaveBarItem.allBarItems[row];
                
                let BarItemsView = segue.destination as! BarItemsView;
                
                BarItemsView.BarItem = item;
                
            }
            
        case "addBarItem":
            
            if let row = tableView.indexPathForSelectedRow?.row {
                
                let item = SaveBarItem.allBarItems[row];
                
                let BarItemsView = segue.destination as! AddBarItemView;
                
                BarItemsView.BarItem = item;
                
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

