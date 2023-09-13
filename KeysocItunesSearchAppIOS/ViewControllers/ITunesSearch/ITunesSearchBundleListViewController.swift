//
//  ITunesSearchBundleListViewController.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit

class ITunesSearchBundleListViewController: KCUIViewController {
    override var titleLocalizationKey: String {
        return "tbi_search"
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl?
    @IBOutlet weak var pageView: KCUIPageView?
    @IBOutlet weak var searchBar: UISearchBar?
    
    var vcSong: ITunesMusicItemListViewController?
    var vcAlbum: ITunesMusicItemListViewController?
    var vcArtist: ITunesMusicItemListViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vcSong = ITunesMusicItemListViewController(itemType: .song)
        vcAlbum = ITunesMusicItemListViewController(itemType: .album)
        vcArtist = ITunesMusicItemListViewController(itemType: .artist)
        
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
        
        searchBar?.delegate = self
    }
    
    deinit {
        vcSong?.removeFromParent()
        vcAlbum?.removeFromParent()
        vcArtist?.removeFromParent()
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


extension ITunesSearchBundleListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Hide the keyboard when the search button is clicked
        vcSong?.query = searchBar.text ?? ""
        vcAlbum?.query = searchBar.text ?? ""
        vcArtist?.query = searchBar.text ?? ""
    }
}

