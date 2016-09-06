//
//  TweetersTableViewController.swift
//  Smashtag
//

import UIKit
import CoreData

class TweetersTableViewController: CoreDataTableViewController {
    
    var mention: String? { didSet { updateUI() } }
    var managedObjectContext : NSManagedObjectContext[ { didSet { updateUI() } }
    
    private func updateUI() {
        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

}
