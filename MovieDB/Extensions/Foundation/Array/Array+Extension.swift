//
//  Array+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation

extension Array where Element: Hashable {
    
    /**
     Returns only the unique elements from the array
     
     - returns: Unique array of elements
     */
    var unique: [Element] {
        return Array(Set(self))
    }
    
    /**
     Returns an element from an array at a given index
     
     - parameter index: Index of the element to return
     - returns: An element at the given index
     */
    public func element(at index: Int) -> Element? {
        return index < self.count && index >= 0 ? self[index] : nil
    }
    
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
}

extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
}
