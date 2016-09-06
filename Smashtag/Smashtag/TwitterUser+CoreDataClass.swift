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
        let request : NSFetchRequest<NSFetchRequestResult> = TwitterUser.fetchRequest()
        request.predicate = NSPredicate(format: "screenName = %@", twitterInfo.screenName)
        if let twitterUser = (try? context.fetch(request))?.first as? TwitterUser {
            return twitterUser
        } else if let twitterUser = NSEntityDescription.insertNewObject(forEntityName: "TwitterUser", into: context) as? TwitterUser {
            twitterUser.screenName = twitterInfo.screenName
            twitterUser.name = twitterInfo.name
            return twitterUser
        }
        return nil
    }
}
