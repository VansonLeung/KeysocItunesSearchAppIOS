//
//  ITunesFavouriteBundleListViewController.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit

class ITunesFavouriteBundleListViewController: KCUIViewController {
    override var titleLocalizationKey: String {
        return "tbi_favourites"
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl?
    @IBOutlet weak var pageView: KCUIPageView?
    
    var vcSong: ITunesMusicItemFavouriteListViewController?
    var vcAlbum: ITunesMusicItemFavouriteListViewController?
    var vcArtist: ITunesMusicItemFavouriteListViewController?

    
    private var navigationItemButtonEdit: KCUIBarButtonItem?
    private var isTableViewEditing: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItemButtonEdit = KCUIBarButtonItem(kcTitle: "", style: .plain, target: self, action: #selector(onApplyEditButton))
        navigationItem.rightBarButtonItem = navigationItemButtonEdit
        refreshEditButton()

        vcSong = ITunesMusicItemFavouriteListViewController(itemType: .song)
        vcAlbum = ITunesMusicItemFavouriteListViewController(itemType: .album)
        vcArtist = ITunesMusicItemFavouriteListViewController(itemType: .artist)
        
        if let vc = vcSong {
            self.addChild(vc)
            pageView?.addPageViewController(vc)
        }

        if let vc = vcAlbum {
            self.addChild(vc)
            pageView?.addPageViewController(vc)
        }

        if let vc = vcArtist {
            self.addChild(vc)
            pageView?.addPageViewController(vc)
        }
        
        pageView?.scrollView.isScrollEnabled = false
    }
    
    deinit {
        vcSong?.removeFromParent()
        vcAlbum?.removeFromParent()
        vcArtist?.removeFromParent()
    }

    
    
    @objc func onApplyEditButton() {
        isTableViewEditing = !isTableViewEditing
        
        vcSong?.isTableViewEditing = isTableViewEditing
        vcAlbum?.isTableViewEditing = isTableViewEditing
        vcArtist?.isTableViewEditing = isTableViewEditing
        
        refreshEditButton()
    }
    
    func refreshEditButton() {
        if isTableViewEditing {
            navigationItemButtonEdit?.titleLocalizationKey = "generic_cancel"
        } else {
            navigationItemButtonEdit?.titleLocalizationKey = "generic_edit"
        }
    }
    
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Handle the value change here
        let selectedIndex = sender.selectedSegmentIndex
        pageView?.goToPage(selectedIndex)
    }
    
    @IBAction func pageViewValueChanged(_ sender: KCUIPageView) {
        // Handle the value change here
        let selectedIndex = sender.currentPage
        segmentedControl?.selectedSegmentIndex = selectedIndex
    }
}

