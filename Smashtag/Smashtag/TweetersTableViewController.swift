//
//  TweetersTableViewController.swift
//  Smashtag
//

import UIKit
import CoreData

class TweetersTableViewController: CoreDataTableViewController {
    
    var mention: String? { didSet { updateUI() } }
    var managedObjectContext : NSManagedObjectContext? { didSet { updateUI() } }
    
    private func updateUI() {
        fetchedResultsController = nil
        
        guard let context = managedObjectContext else { return }
        guard let search = mention else { return }
        
        let request : NSFetchRequest<NSFetchRequestResult> = TwitterUser.fetchRequest()
        request.predicate = NSPredicate(format: "any tweets.text contains[c] %@ and !screenName beginswith[c] %@", search, "darkside")
        request.sortDescriptors = [NSSortDescriptor(
            key: "screenName",
            ascending: true,
            selector: #selector(NSString.localizedCaseInsensitiveCompare(_:))
        )]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
    }

    private func tweetCountWithMentionByTwitterUser(user: TwitterUser) -> Int? {
        var count: Int?
        guard let search = mention else { fatalError("Never called.") }
        user.managedObjectContext?.performAndWait {
            let request: NSFetchRequest<NSFetchRequestResult> = Tweet.fetchRequest()
            request.predicate = NSPredicate(format: "text contains[c] %@ and tweeter = %@", search, user)
            count = (try? user.managedObjectContext?.count(for: request)) ?? nil
        }
        return count
    }
    
    // Required.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterUserCell", for: indexPath)

        if let twitterUser = fetchedResultsController?.object(at: indexPath) as? TwitterUser {
            var screenName: String?
            // async
            twitterUser.managedObjectContext?.performAndWait {
                screenName = twitterUser.screenName
            }
            // UI
            cell.textLabel?.text = screenName
            
            if let count = tweetCountWithMentionByTwitterUser(user: twitterUser) {
                cell.detailTextLabel?.text = (count == 1) ? "1 tweet" : "\(count) tweets"
            } else {
                cell.detailTextLabel?.text = ""
            }
        }

        return cell
    }


}
