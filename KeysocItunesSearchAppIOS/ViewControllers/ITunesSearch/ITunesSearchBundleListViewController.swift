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
    @IBOutlet weak var searchHistoryContainer: UIView?
    
    var vcSong: ITunesMusicItemListViewController?
    var vcAlbum: ITunesMusicItemListViewController?
    var vcArtist: ITunesMusicItemListViewController?
    
    
    var vcSearchHistory: ITunesSearchHistoryListViewController?
    
    
    var selectedCountryValue: String? = nil
    var selectedMediaTypeValue: String? = nil

    
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
        
        
        let barBtnItem = KCUIBarButtonItem(kcTitle: "", style: .plain, target: self, action: #selector(onApplyBarBtnFilter))
        barBtnItem.titleLocalizationKey = "filters"
        navigationItem.rightBarButtonItem = barBtnItem
        
        

        
        vcSearchHistory = ITunesSearchHistoryListViewController()
        vcSearchHistory?.onClickEmptySpace = { [weak self] in
            self?.searchBar?.endEditing(true)
            self?.dismissVcSearchHistory()
            if let text = self?.searchBar?.text,
               self?.vcSearchHistory?.query != text {
                self?.applySearchText(text: text)
            }
        }
        
        vcSearchHistory?.onSelectHistoryItem = { [weak self] text in
            self?.searchBar?.endEditing(true)
            self?.dismissVcSearchHistory()
            self?.searchBar?.text = text
            self?.applySearchText(text: text)
        }
        
        
        if let vcSearchHistory = vcSearchHistory {
            searchHistoryContainer?.addSubview(vcSearchHistory.view)
            addChild(vcSearchHistory)
        }
    }
    
    deinit {
        vcSong?.removeFromParent()
        vcAlbum?.removeFromParent()
        vcArtist?.removeFromParent()
        vcSearchHistory?.removeFromParent()
    }

    
    func dismissVcSearchHistory() {
        UIView.animate(withDuration: 0.25, animations: {
            self.searchHistoryContainer?.alpha = 0.0
        })
    }
    
    func showVcSearchHistory() {
        UIView.animate(withDuration: 0.25) {
            self.searchHistoryContainer?.alpha = 1.0
        }
        vcSearchHistory?.refreshData()
    }
    
    
    func applySearchText(text: String?) {
        if let text = text {
            vcSong?.query = text
            vcAlbum?.query = text
            vcArtist?.query = text
            vcSearchHistory?.query = text
        }
    }
    
    
    @objc func onApplyBarBtnFilter() {
        let vc = ITunesSearchFilterListViewController()
        
        vc.selectedCountryValue = selectedCountryValue
        vc.selectedMediaTypeValue = selectedMediaTypeValue
        
        vc.onDismiss = { [weak self] countryVal, mediaTypeVal in
            self?.selectedCountryValue = countryVal
            self?.selectedMediaTypeValue = mediaTypeVal
            
            self?.vcSong?.selectedCountryValue = self?.selectedCountryValue
            self?.vcSong?.selectedMediaTypeValue = self?.selectedMediaTypeValue
            self?.vcSong?.fetchAny(isRefresh: true)
            
            self?.vcAlbum?.selectedCountryValue = self?.selectedCountryValue
            self?.vcAlbum?.selectedMediaTypeValue = self?.selectedMediaTypeValue
            self?.vcAlbum?.fetchAny(isRefresh: true)
            
            self?.vcArtist?.selectedCountryValue = self?.selectedCountryValue
            self?.vcArtist?.selectedMediaTypeValue = self?.selectedMediaTypeValue
            self?.vcArtist?.fetchAny(isRefresh: true)

        }
        
        getNavigationController?.pushViewController(vc, animated: true)
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
        self.applySearchText(text: searchBar.text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showVcSearchHistory()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismissVcSearchHistory()
    }
}

