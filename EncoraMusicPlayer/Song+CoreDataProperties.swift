//
//  Song+CoreDataProperties.swift
//  EncoraMusicPlayer
//
//  Created by Parth Vasavada on 11/04/21.
//
//

import Foundation
import CoreData
import UIKit

extension Song {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: "Song")
    }

    @NSManaged public var artist: String?
    @NSManaged public var id: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var songInfoURL: String?
    @NSManaged public var songURL: String?
    @NSManaged public var title: String?
    @NSManaged public var imageData: Data?

}

extension Song {
    var image: UIImage? {
        guard let imageData = self.imageData else { return nil }
        return UIImage(data: imageData)
    }
}

extension Song : Identifiable {

}
