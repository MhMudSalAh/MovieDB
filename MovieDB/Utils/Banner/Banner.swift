//
//  Banner.swift
//  Network Layer
//
//  Created by MhMuD SalAh on 10/16/19.
//  Copyright © 2019 Tarseya. All rights reserved.
//

//import Foundation
//import NotificationBannerSwift
//
//struct Banner  {
//    
//    static func showSuccess(_ message: String) {
//        DispatchQueue.main.async {
//            self.show(localizedText("success"), message, .success, 1)
//        }
//    }
//    
//    static func showError(_ message: String) {
//        DispatchQueue.main.async {
//            self.show(localizedText("error"), message, .danger, 1)
//        }
//    }
//    
//    static func show(_ title: String, _ message: String, _ style: BannerStyle, _ duration: Int) {
//        let banner = GrowingNotificationBanner(title: title, subtitle: message, style: style)
//        banner.duration = 2
//        banner.show()
//        banner.remove()
//    }
//    
//    static func empty(_ fieldKey: String) {
//        show(localizedText("error"), localizedText("please_enter") + " " + localizedText(fieldKey), .danger, 1)
//    }
//    
//    static func inValid(_ fieldKey: String) {
//        show(localizedText("error"), localizedText("invalid") + " " + localizedText(fieldKey), .danger, 1)
//    }
//    
//    static func showAPIError(_ error: APIError) {
//        DispatchQueue.main.async {
//            serverError(error.message)
//            //            switch error {
//            //            case .unknown, .noData:
//            //                self.serverError()
//            //                break
//            //            case let .known( _, message, _):
//            //                self.serverError(message)
//            //                break
//            //            case .string:
//            //                break
//            //            }
//        }
//    }
//    
//    static func serverError(_ message: String? = nil) {
//        DispatchQueue.main.async {
//            self.showError(message ?? localizedText("something_went_wrong"))
//        }
//    }
//}
//
