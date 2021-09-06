//
//  UITextView+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

@IBDesignable class DesignableTextView: UITextView, UITextViewDelegate {
    
    var placeholderLabel: UILabel!
    
    func addLabel() {
        delegate = self
        
        let labelFrame = CGRect(x: textContainer.lineFragmentPadding, y: textContainerInset.top, width: frame.width, height: 20)
        placeholderLabel = UILabel(frame: labelFrame)
        placeholderLabel.font = font
        placeholderLabel.text = "Write..."
        placeholderLabel.textColor = .lightGray
        addSubview(placeholderLabel)
        
        addObserver(self, forKeyPath: "text", options: [], context: nil)
    }
    
    deinit {
        removeObserver(self, forKeyPath: "text")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if LOCAL.getLanguage() == Language.AR.rawValue {
            let labelFrame = CGRect(x: textContainer.lineFragmentPadding - 10, y: textContainerInset.top, width: frame.width, height: 20)
            placeholderLabel.frame = labelFrame
        } else {
            let labelFrame = CGRect(x: textContainer.lineFragmentPadding, y: textContainerInset.top, width: frame.width, height: 20)
            placeholderLabel.frame = labelFrame
        }
    }
    
    @IBInspectable var placeholder: String? {
        get {
            return placeholderLabel.text
        }
        set {
            if placeholderLabel == nil {
                addLabel()
            }
            
            placeholderLabel.text = newValue
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            textChanged()
        }
    }
    
    func textChanged() {
        if text.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if text.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
    
    func textViewEnablebtn(_ button: UIButton) {
        if text.isEmpty {
            button.isEnabled = true
            button.alpha = 1.0
        } else {
            button.isEnabled = false
            button.alpha = 0.5
        }
        
    }
    
    func validate(_ textView: UITextView) -> Bool {
        guard let text = textView.text,
            !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                return false
        }
        return true
    }
    
    func localize() {
        self.textAlignment = (LOCAL.getLanguage() == Language.EN.rawValue ? .left : .right)
    }
}

