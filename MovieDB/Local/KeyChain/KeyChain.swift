//
//  KeyChainService.swift
//  Network Layer
//
//  Created by MhMuD SalAh on 10/16/19.
//  Copyright © 2019 Tarseya. All rights reserved.
//

import UIKit

class KeyChain {

    @discardableResult
    func store<T>(_ key: String, _ object: T) -> OSStatus {

        let data = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
        let query = initStoreQuery(key, data!)
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }

    func load<T>(_ key: String) -> T? {
        let query = initLoadQuery(key)
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            let result = dataTypeRef as! Data?
            if let object: T = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(result!) as? T {
                return object
            }
        }
        return nil
    }

    @discardableResult
    func delete(_ key: String) -> OSStatus {
        let query = initStoreQuery(key, Data())
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }

    private func initStoreQuery(_ key: String, _ data: Data) -> [String : Any] {
        return [
            kSecClass as String : kSecClassGenericPassword as String,
            kSecAttrAccount as String : createUniqueId(key),
            kSecValueData as String : data
            ] as [String : Any]
    }

    private func initLoadQuery(_ key: String) -> [String : Any] {
        return [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : createUniqueId(key),
            kSecReturnData as String : kCFBooleanTrue!,
            kSecMatchLimit as String : kSecMatchLimitOne
            ] as [String : Any]
    }

    func createUniqueId(_ key: String) -> String {
        let uuid = UIDevice.current.identifierForVendor
        return "\(uuid?.uuidString ?? "")\(key)"
    }
}
