//
//  MainViewController.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit
import Toast

class RootViewController : UINavigationController {
    
    private var rootTabBarController: UITabBarController!
    
    private var vcSearch: ITunesSearchBundleListViewController!
    private var vcFavourites: ITunesFavouriteBundleListViewController!
    private var vcSettings: SettingsViewController!
    
    private var vcSearchTbiLocalizedKey = "tbi_search"
    private var vcFavouritesTbiLocalizedKey = "tbi_favourites"
    private var vcSettingsTbiLocalizedKey = "tbi_settings"
    
    static var current: RootViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a UITabBarController
        rootTabBarController = UITabBarController()

        // Create individual view controllers for tabs
        vcSearch = ITunesSearchBundleListViewController()
        vcSearch.view.backgroundColor = .white

        vcFavourites = ITunesFavouriteBundleListViewController()
        vcFavourites.view.backgroundColor = .white

        vcSettings = SettingsViewController()
        vcSettings.view.backgroundColor = .white

        // Add view controllers to the tab bar controller
        rootTabBarController.viewControllers = [
            vcSearch,
            vcFavourites,
            vcSettings,
        ]

        // Set the tab bar controller as the navigation stack's top view controller
        setViewControllers([rootTabBarController], animated: false)
        
        rootTabBarController.delegate = self

        refreshTabBarItems()

        refreshTitle()
        
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: NSNotification.Name("LanguageDidChange"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RootViewController.current = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        RootViewController.current = nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    @objc private func languageDidChange() {
        refreshTabBarItems()
        refreshTitle()
    }
    
    func refreshTabBarItems() {
        vcSearch.tabBarItem = UITabBarItem(title: vcSearchTbiLocalizedKey.i18n(), image: UIImage(named: "ic_search"), selectedImage: nil)
        vcFavourites.tabBarItem = UITabBarItem(title: vcFavouritesTbiLocalizedKey.i18n(), image: UIImage(named: "ic_favourites"), selectedImage: nil)
        vcSettings.tabBarItem = UITabBarItem(title: vcSettingsTbiLocalizedKey.i18n(), image: UIImage(named: "ic_settings"), selectedImage: nil)
    }
    
    func refreshTitle() {
        if rootTabBarController.selectedViewController?.isKind(of: KCUIViewController.self) == true,
           let vc = rootTabBarController.selectedViewController as? KCUIViewController {
            rootTabBarController.title = vc.titleLocalizationKey.i18n()
            rootTabBarController.navigationItem.rightBarButtonItems = vc.navigationItem.rightBarButtonItems
        } else {
            rootTabBarController.title = rootTabBarController.selectedViewController?.title
            rootTabBarController.navigationItem.rightBarButtonItems = rootTabBarController.selectedViewController?.navigationItem.rightBarButtonItems
        }
    }
    
    
    
    func showToast(message: String?) {
        self.view.makeToast(message)
    }
    
}

extension RootViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        refreshTitle()
    }
}
