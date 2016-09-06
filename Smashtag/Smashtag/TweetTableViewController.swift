//
//  TweetTableViewController.swift
//  Smashtag
//

import UIKit
import Twitter
import CoreData

class TweetTableViewController: UITableViewController, UITextFieldDelegate {
    
    var managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    
    var tweets = [Array<Twitter.Tweet>]() {
        
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchText: String? {
        didSet {
            tweets.removeAll()
            lastTwitterRequest = nil
            searchForTweets()
            title = searchText
        }
    }
    
    private var twitterRequest: Twitter.Request? {
        if let query = searchText, !query.isEmpty {
            return Twitter.Request(search: query + " -filter:retweets", count: 100)
        }
        return lastTwitterRequest?.requestForNewer
    }
    
    private var lastTwitterRequest: Twitter.Request?
    
    private func searchForTweets() {
        if let request = twitterRequest {
            lastTwitterRequest = request
            request.fetchTweets { [weak self] newTweets in
                // this closure is been executed off the main queue when those tweets come back sometime in the future
                DispatchQueue.main.async {
                    if request == self?.lastTwitterRequest && !newTweets.isEmpty {
                        self?.tweets.insert(newTweets, at: 0)
                        self?.updateDatabase(newTweets)
                    }
                    self?.refreshControl?.endRefreshing()
                }
            }
        } else {
            self.refreshControl?.endRefreshing()
        }
    }
    
    private func updateDatabase(_ newTweets: [Twitter.Tweet]) {
        // async
        managedObjectContext?.perform {
            for twitterInfo in newTweets {
                guard let context = self.managedObjectContext else { return }
                _ = Tweet.tweetWithTwitterInfo(twitterInfo: twitterInfo, inManagedObjectContext: context)
            }
            do {
                try self.managedObjectContext?.save()
            } catch let error {
                print("Core Data Error: \(error)")
            }
        }
        printDatabaseStatistics()
        print("done printing database statistics")
    }
    
    private func printDatabaseStatistics() {
        // async
        managedObjectContext?.perform {
            guard let context = self.managedObjectContext else { return }
            let request : NSFetchRequest<NSFetchRequestResult> = TwitterUser.fetchRequest()
            if let results = try? context.fetch(request) {
                print("\(results.count) TwitterUsers")
            }
            guard let tweetCount = try? context.count(for: Tweet.fetchRequest()) else { return }
            print("\(tweetCount) Tweets")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TweetersMentioningSearchTerm" {
            guard let tweetersTVC = segue.destination as? TweetersTableViewController else { fatalError("Unexpected segue.") }
            tweetersTVC.mention = searchText
            tweetersTVC.managedObjectContext = managedObjectContext
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count
    }

    // Required. 
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }
    
    private struct Storyboard {
        static let TweetCellIdentifier = "Tweet"
    }

    // Required.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TweetCellIdentifier, for: indexPath)

        let tweet = tweets[indexPath.section][indexPath.row]
        if let tweetCell  = cell as? TweetTableViewCell {
            tweetCell.tweet = tweet
        }

        return cell
    }

    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchText = textField.text
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
