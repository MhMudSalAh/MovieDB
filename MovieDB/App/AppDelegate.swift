//
//  AppDelegate.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import AuthenticationServices

let APP = UIApplication.shared.delegate! as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    override init() {
        super.init()
        UIFont.overrideInitialize()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupThirdPartServices()
        checkLocale()
        presentRootScreen()
        return true
    }
    
    fileprivate func setupThirdPartServices() {
        // MARK: TODO: Fabric.with([Crashlytics.self])
        // MARK: TODO: FirebaseApp.configure()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: AppFontName.light, size: 12)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
    }
        
    fileprivate func checkLocale() {
        if (!LocaleManager.shared.isExist()) {
            LOCAL.setDefaultAppLocale()
        }
    }
    
    fileprivate func presentRootScreen() {
        window = UIWindow(frame: UIScreen.main.bounds)
        RootRouter().presentRootScreen(in: window!)
    }
    
    fileprivate func settingsVersion() {
        let version = Bundle.main.infoDictionary!["CFBundleVersion"]!
        let shortVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]!
        _ = "v\(shortVersion) (\(version))"
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

