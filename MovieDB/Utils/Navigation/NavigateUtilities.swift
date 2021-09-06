//
//  NavigateUtilities.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation
import UIKit
import SafariServices

let NAV_UTIL = NavigateUtilities.sharedNavigateUtilities

@objc protocol UtilitiesDelegate {
    @objc optional func didSelectImage(_ base64: String, _ image: UIImage)
}

class NavigateUtilities: Utilities, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SFSafariViewControllerDelegate {
    
    static var sharedNavigateUtilities = NavigateUtilities()
    
    let camera = UIImagePickerController()
    let imagePicker = UIImagePickerController()
    
    func openUrl(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        getTopViewController().present(safariVC, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func callNumber(phoneNumber: String) {
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    application.openURL(phoneCallURL as URL)
                }
            }
        }
    }
    
    func showCamera(_ viewController: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            camera.delegate = self
            camera.allowsEditing = false
            camera.sourceType = .camera
            viewController.present(camera, animated: true, completion: nil)
        }
    }
    
    func showPhotoLibrary(_ viewController: UIViewController) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            let imageData = pickedImage.jpegData(compressionQuality: 0.25)!
            let strBase64: String = imageData.base64EncodedString()
            if delegate != nil && delegate!.didSelectImage != nil {
                delegate!.didSelectImage!(strBase64, pickedImage)
                delegate = nil
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func convertToDictionary(_ object: Any?) -> [String: Any]? {
        if let text = object as? String, let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                Console.LOG("convertToDictionary", error.localizedDescription)
            }
        }
        return nil
    }
    
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }

    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
}

