//
//  ITunesMusicItemFavouriteListViewController.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit
import KeysocItunesSearchAPIServiceiOS_Swift

class ITunesMusicItemFavouriteListViewController : UIViewController {
    
    @IBOutlet weak private var tableView: UITableView?
    
    private var itemViewModels: [KCUIItunesAnyItemViewModel] = []
    
    private var paginationViewModel = KCUIPaginationViewModel()
    private let itemsPerPage = 20
    
    
    public var itemType: ITunesMusicItemListViewController.ItemType = .song
    
    
    init(itemType: ITunesMusicItemListViewController.ItemType) {
        super.init(nibName: "ITunesMusicItemFavouriteListViewController", bundle: .main)
        self.itemType = itemType
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view delegate and data source
        tableView?.delegate = self
        tableView?.dataSource = self
        
        // Set the custom cell identifier to "SongCell" in your storyboard or XIB
        tableView?.register(UINib(nibName: "KCUISongListCellHorizontal", bundle: nil), forCellReuseIdentifier: "SongCell")

        // Fetch items and update the view
        fetchAny(isRefresh: true)

        // Add RefreshControl to tableView
        let refreshControl = KCUIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        tableView?.refreshControl = refreshControl
    }
    
    

    @objc func refreshTableView(_ sender: UIRefreshControl) {
        // Fetch items and update the view
        fetchAny(isRefresh: true)
    }
    
    
    func fetchAny(isRefresh: Bool = false) {
        switch itemType {
        case .song:
            fetchSongs(isRefresh: isRefresh)
        case .artist:
            fetchArtists(isRefresh: isRefresh)
        case .album:
            fetchAlbums(isRefresh: isRefresh)
        }
    }
    
    
    func fetchSongs(isRefresh: Bool = false) {
        paginationViewModel.onPrepareFetch(isRefresh: isRefresh) {
            [weak self] shouldFetch, curRefreshHash, page in
            
            if !shouldFetch { return }
            
            let favItems = AppCoreDataManager.shared.itunesAnyItem_selectFavorites(entityType: FavouriteSong.self)
            
            self?.paginationViewModel.onPostFetch(
                curRefreshHash: curRefreshHash,
                isRefresh: isRefresh,
                isError: false,
                isEnded: true)
            {
                if isRefresh {
                    // restore RefreshControl
                    self?.tableView?.refreshControl?.endRefreshing()
                    // Refresh the viewmodel list
                    self?.itemViewModels.removeAll()
                }
                
                // Append the viewmodel list
                self?.itemViewModels.append(contentsOf: favItems.map { KCUIItunesFavouriteAnyItemViewModel(song: $0) } )
                self?.reloadList()
                self?.refreshState()
            }
        }
    }
    
    func fetchArtists(isRefresh: Bool = false) {
        paginationViewModel.onPrepareFetch(isRefresh: isRefresh) {
            [weak self] shouldFetch, curRefreshHash, page in
            
            if !shouldFetch { return }
            
            let favItems = AppCoreDataManager.shared.itunesAnyItem_selectFavorites(entityType: FavouriteArtist.self)
            
            self?.paginationViewModel.onPostFetch(
                curRefreshHash: curRefreshHash,
                isRefresh: isRefresh,
                isError: false,
                isEnded: true)
            {
                if isRefresh {
                    // restore RefreshControl
                    self?.tableView?.refreshControl?.endRefreshing()
                    // Refresh the viewmodel list
                    self?.itemViewModels.removeAll()
                }
                
                // Append the viewmodel list
                self?.itemViewModels.append(contentsOf: favItems.map { KCUIItunesFavouriteAnyItemViewModel(artist: $0) } )
                self?.reloadList()
                self?.refreshState()
            }
        }
    }
    
    func fetchAlbums(isRefresh: Bool = false) {
        paginationViewModel.onPrepareFetch(isRefresh: isRefresh) {
            [weak self] shouldFetch, curRefreshHash, page in
            
            if !shouldFetch { return }
            
            let favItems = AppCoreDataManager.shared.itunesAnyItem_selectFavorites(entityType: FavouriteAlbum.self)
            
            self?.paginationViewModel.onPostFetch(
                curRefreshHash: curRefreshHash,
                isRefresh: isRefresh,
                isError: false,
                isEnded: true)
            {
                if isRefresh {
                    // restore RefreshControl
                    self?.tableView?.refreshControl?.endRefreshing()
                    // Refresh the viewmodel list
                    self?.itemViewModels.removeAll()
                }
                
                // Append the viewmodel list
                self?.itemViewModels.append(contentsOf: favItems.map { KCUIItunesFavouriteAnyItemViewModel(album: $0) } )
                self?.reloadList()
                self?.refreshState()
            }
        }
    }
    
    
    func refreshState() {
        DispatchQueue.main.async {
            // todo: refresh tableview and loading screen visibility
        }
    }
    
    
    func reloadList() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}


extension ITunesMusicItemFavouriteListViewController: UITableViewDelegate, UITableViewDataSource {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height

        // Check if the user has scrolled to the bottom and isLoading is false
        if offsetY > contentHeight - screenHeight,
            paginationViewModel.isLoadNextPageAvailable() {
            fetchAny(isRefresh: false)
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemViewModels.count
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 173
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        
        if let cell = cell as? KCUISongListCellHorizontal {
            let it = itemViewModels[indexPath.row]
            cell.configure(with: it)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if AppLanguageManager.shared.currentLanguage == "zh-Hant" {
            AppLanguageManager.shared.changeAppLanguage(language: "zh-Hans")
        }
        else if AppLanguageManager.shared.currentLanguage == "zh-Hans" {
            AppLanguageManager.shared.changeAppLanguage(language: "en")
        }
        else {
            AppLanguageManager.shared.changeAppLanguage(language: "zh-Hant")
        }
    }
}



