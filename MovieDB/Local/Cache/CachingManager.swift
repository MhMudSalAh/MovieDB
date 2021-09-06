//
//  CachingManager.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class CachingManager {

    let defaults = UserDefaults.standard

    func store<T>(_ object: T, _ key: String) {
        let data = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
        defaults.set(data, forKey: key)
        defaults.synchronize()
    }

    func retrive<T>(_ key: String) -> T! {
        if isExist(key) {
            let data = defaults.object(forKey: key) as? Data
            let object = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as? T
                return object
        } else {
            return nil
        }
    }

    func isExist(_ key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }

    func delete(_ key: String) {
        if defaults.object(forKey: key) != nil {
            defaults.removeObject(forKey: key)
        }
    }
}

