//
//  Tweet+CoreDataProperties.swift
//  Smashtag
//


import Foundation
import CoreData

extension Tweet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tweet> {
        return NSFetchRequest<Tweet>(entityName: "Tweet");
    }

    @NSManaged public var text: String?
    @NSManaged public var unique: String?
    @NSManaged public var posted: Date?
    @NSManaged public var tweeter: TwitterUser?

}
