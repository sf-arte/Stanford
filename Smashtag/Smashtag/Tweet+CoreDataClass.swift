//
//  Tweet+CoreDataClass.swift
//  Smashtag
//


import Foundation
import CoreData
import Twitter

public class Tweet: NSManagedObject {
    class func tweetWithTwitterInfo(twitterInfo: Twitter.Tweet, inManagedObjectContext context: NSManagedObjectContext) -> Tweet? {
        let request : NSFetchRequest<NSFetchRequestResult> = Tweet.fetchRequest()
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.id)
        
        if let tweet = (try? context.fetch(request))?.first as? Tweet {
            return tweet
        } else if let tweet = NSEntityDescription.insertNewObject(forEntityName: "Tweet", into: context) as? Tweet {
            tweet.unique = twitterInfo.id
            tweet.text = twitterInfo.text
            tweet.posted = twitterInfo.created
            tweet.tweeter = TwitterUser.twitterUserWithTwitterInfo(twitterInfo: twitterInfo.user, inManagedObjectContext: context)
            return tweet
        }
        return nil
    }
}
