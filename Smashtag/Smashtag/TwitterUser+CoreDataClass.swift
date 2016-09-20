//
//  TwitterUser+CoreDataClass.swift
//  Smashtag
//

import Foundation
import CoreData
import Twitter

public class TwitterUser: NSManagedObject {
    class func twitterUserWithTwitterInfo(twitterInfo: Twitter.User, inManagedObjectContext context: NSManagedObjectContext) -> TwitterUser?
    {
        let request : NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
        request.predicate = NSPredicate(format: "screenName = %@", twitterInfo.screenName)
       
        return (try? request.execute())?.first ?? {
            let twitterUser = TwitterUser(context: context)
            twitterUser.screenName = twitterInfo.screenName
            twitterUser.name = twitterInfo.name
            
            return twitterUser
        }()
    }
}
