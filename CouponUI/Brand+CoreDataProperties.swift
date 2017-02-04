//
//  Brand+CoreDataProperties.swift
//  
//
//  Created by Joosung Kim on 31/01/2017.
//
//

import Foundation
import CoreData


extension Brand {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Brand> {
        return NSFetchRequest<Brand>(entityName: "Brand");
    }

    @NSManaged public var title: String?
    @NSManaged public var toCoupon: NSSet?
    @NSManaged public var toImage: Image?
    @NSManaged public var toMembership: NSSet?

}

// MARK: Generated accessors for toCoupon
extension Brand {

    @objc(addToCouponObject:)
    @NSManaged public func addToToCoupon(_ value: Coupon)

    @objc(removeToCouponObject:)
    @NSManaged public func removeFromToCoupon(_ value: Coupon)

    @objc(addToCoupon:)
    @NSManaged public func addToToCoupon(_ values: NSSet)

    @objc(removeToCoupon:)
    @NSManaged public func removeFromToCoupon(_ values: NSSet)

}

// MARK: Generated accessors for toMembership
extension Brand {

    @objc(addToMembershipObject:)
    @NSManaged public func addToToMembership(_ value: Membership)

    @objc(removeToMembershipObject:)
    @NSManaged public func removeFromToMembership(_ value: Membership)

    @objc(addToMembership:)
    @NSManaged public func addToToMembership(_ values: NSSet)

    @objc(removeToMembership:)
    @NSManaged public func removeFromToMembership(_ values: NSSet)

}
