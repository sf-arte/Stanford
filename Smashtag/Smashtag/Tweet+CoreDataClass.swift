//
//  Tweet+CoreDataClass.swift
//  Smashtag
//


import Foundation
import CoreData
import Twitter

public class Tweet: NSManagedObject {
    class func tweetWithTwitterInfo(twitterInfo: Twitter.Tweet, inManagedObjectContext context: NSManagedObjectContext) -> Tweet? {
        let request : NSFetchRequest<Tweet> = Tweet.fetchRequest()
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.id)
        
        return (try? request.execute())?.first ?? {
            let tweet = Tweet(context: context)
            tweet.unique = twitterInfo.id
            tweet.text = twitterInfo.text
            tweet.posted = twitterInfo.created
            tweet.tweeter = TwitterUser.twitterUserWithTwitterInfo(twitterInfo: twitterInfo.user, inManagedObjectContext: context)
            return tweet
        }()
    }
}
