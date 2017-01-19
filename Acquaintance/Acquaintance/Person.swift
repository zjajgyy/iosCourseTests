//
//  Person.swift
//  Acquaintance
//
//  Created by zjajgyy on 2016/11/29.
//  Copyright © 2016年 zjajgyy. All rights reserved.
//

import Foundation
import UIKit
class Person: NSObject, NSCoding {
    var name: String
    var photo: UIImage?
    var notes: String?
    var phone: String?
    var email: String?
    var category: String?
    
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let phoneKey = "phone"
        static let emailKey = "email"
        static let notesKey = "notes"
        static let categoryKey = "category"
    }
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("acqList.plist")

    
    init?(name: String, photo: UIImage?, notes: String?, phone: String?, email: String?, category: String?) {
        if name.isEmpty {
        return nil
        }
        self.name = name
        self.photo = photo
        self.notes = notes
        self.category = category
        self.email = email
        self.phone = phone
        super.init()
    }
    
    convenience init?(_ name: String){
        self.init(name: name, photo: nil, notes: nil, phone: nil, email: nil, category: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as? String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        let notes = aDecoder.decodeObject(forKey: PropertyKey.notesKey) as? String
        let phone = aDecoder.decodeObject(forKey: PropertyKey.phoneKey) as? String
        let email = aDecoder.decodeObject(forKey: PropertyKey.emailKey) as? String
        let category = aDecoder.decodeObject(forKey: PropertyKey.categoryKey) as? String


        if name == nil {
            return nil
        }
        // Must call designated initializer.
        self.init(name: name!, photo: photo,
                  notes: notes, phone: phone, email: email, category: category)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
        aCoder.encode(notes, forKey: PropertyKey.notesKey)
        aCoder.encode(phone, forKey: PropertyKey.phoneKey)
        aCoder.encode(email, forKey: PropertyKey.emailKey)
        aCoder.encode(category, forKey: PropertyKey.categoryKey)
    }

}

