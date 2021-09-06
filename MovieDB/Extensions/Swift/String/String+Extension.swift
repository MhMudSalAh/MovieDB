//
//  String+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation

extension String {
    
    func isNotEmpty() -> Bool {
        return self.trimmingCharacters(in: .whitespaces).count > 0
    }
    
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: self.utf16.count)) ?? 0
    }
    
    /**
     Returns the initials from a given string (first letter from the first and last words)

     - returns: The initials from the string
     */
    public var initials: String {
        return self.split(separator: " ").map { String($0.first!) }.joined()
    }
    
    /**
     Returns the first word of the string
     */
    public var firstWord: String? {
        return self.split(separator: " ").map { String($0) }.first
    }
    
    /**
     Converts the first letter of the string to an upper case letter
     
     - returns: The string with a capitalized first letter
     */
    public var capitalizedFirstCharacter: String {
        if self.count > 1 {
            let startIndex = self.index(self.startIndex, offsetBy: 1)
            let begin = self[..<startIndex]
            let end = self[startIndex...]
            let first = begin.uppercased()
            return first + end
        }
        return self.capitalized
    }
    
    func replacingOccurrences(of search: String, with replacement: String, count maxReplacements: Int) -> String {
        var count = 0
        var returnValue = self
        
        while let range = returnValue.range(of: search) {
            returnValue = returnValue.replacingCharacters(in: range, with: replacement)
            count += 1
            
            if count == maxReplacements {
                return returnValue
            }
        }
        
        return returnValue
    }
    
    func truncate(to length: Int, addEllipsis: Bool = false) -> String  {
        if length > count { return self }
        
        let endPosition = self.index(self.startIndex, offsetBy: length)
        let trimmed = self[..<endPosition]
        
        if addEllipsis {
            return "\(trimmed)..."
        } else {
            return String(trimmed)
        }
    }
    
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) { return self }
        return "\(prefix)\(self)"
    }
    
    var toDouble: Double {
        return (self as NSString).doubleValue
    }
    
    var toInt: Int {
        return (self as NSString).integerValue
    }
    
    var toBoolean: Bool {
        return (self as NSString).boolValue
    }
}
