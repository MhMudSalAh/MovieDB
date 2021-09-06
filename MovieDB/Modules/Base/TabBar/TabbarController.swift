//
//  TabbarController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

var TAB = TabBarController.shared

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private var shapeLayer: CALayer?
    
    var icon1 = UITabBarItem()
    var icon2 = UITabBarItem()
    var icon3 = UITabBarItem()
    
    struct Static {
        static var instance: TabBarController?
    }
    
    class var shared: TabBarController {
        if Static.instance == nil {
            Static.instance = TabBarController()
        }
        return Static.instance!
    }
    
    func dispose() {
        TabBarController.Static.instance = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addShape()
    }
    
    func setupTab() {
        tabBar.tintColor = .white
        tabBar.barTintColor = .primary
        tabBar.isTranslucent = true
        delegate = self
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: tabBar.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 25, height: 0.0)).cgPath
        shapeLayer.fillColor = UIColor.primary.cgColor
        shapeLayer.shadowPath =  UIBezierPath(roundedRect: tabBar.bounds, cornerRadius: 25).cgPath
        shapeLayer.shadowColor = UIColor.white.cgColor
        shapeLayer.shadowOpacity = 0.4
        shapeLayer.shadowOffset = CGSize(width: 1, height: -7)
        shapeLayer.shouldRasterize = true
        shapeLayer.rasterizationScale = UIScreen.main.scale
        
        if let oldShapeLayer = self.shapeLayer {
            tabBar.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            tabBar.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    private func setupView() {
        let item1 = NowPlayRouter.assembleModule()
        let item2 = TopRatedRouter.assembleModule()
        let item3 = SearchRouter.assembleModule()
        
        icon1 = UITabBarItem(title: localizedText("now-playing"), image: UIImage(named: "tab-now-play"), selectedImage: UIImage(named: "tab-now-play"))
        icon2 = UITabBarItem(title: localizedText("top-rated"), image: UIImage(named: "tab-top-rate"), selectedImage: UIImage(named: "tab-top-rate"))
        icon3 = UITabBarItem(title: localizedText("search"), image: UIImage(named: "tab-search"), selectedImage: UIImage(named: "tab-search"))
        
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        item3.tabBarItem = icon3
        
        let controllers = [item1, item2, item3]
        self.viewControllers = controllers
    }
}
