//
//  UILabel+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

extension UILabel {
    
    func setText(text: String, withLineSpacing lineSpacing: CGFloat = 1.0) {
        self.text = nil
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: string.length))
        self.attributedText = string
    }
    
    /**
     Calculates the height of the label for a given width, font, and text
     
     - parameter width: The width to fit in
     - parameter font:  The font used to display the text
     - parameter text:  The text to display
     
     - returns: The height needed to display
     */
    public class func height(forWidth width: CGFloat, font: UIFont, text: String) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let label = UILabel(frame: CGRect(origin: .zero, size: size))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    func createAttributedString(_ value: String) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: value)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func getAttributedText(_ value1: String, _ color1: UIColor, _ value2: String, _ color2: UIColor, _ size: Int) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: value1, attributes: [NSAttributedString.Key.foregroundColor: color1, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(size)) ])
        attributedText.append(NSAttributedString(string: value2, attributes: [NSAttributedString.Key.foregroundColor: color2, NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(size))]))
        return attributedText
    }
}
