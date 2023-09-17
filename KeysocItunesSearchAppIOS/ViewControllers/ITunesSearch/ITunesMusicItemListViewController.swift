//
//  ITunesMusicItemListViewController.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit
import KeysocItunesSearchAPIServiceiOS_Swift

class ITunesMusicItemListViewController : UIViewController {
    
    enum ItemType {
        case song
        case artist
        case album
    }
    
    @IBOutlet weak private var tableView: UITableView?
    
    private var itemViewModels: [KCUIItunesAnyItemViewModel] = []
    
    private var paginationViewModel = KCUIPaginationViewModel()
    private let itemsPerPage = 20
    
    private var _query : String = ""
    public var query : String {
        get {
            return _query
        }
        set {
            _query = newValue
            paginationViewModel.refreshHash += 1
            fetchAny(isRefresh: true)
        }
    }
    
    
    var selectedCountryValue: String? = nil
    var selectedMediaTypeValue: String? = nil

    
    public var itemType: ItemType = .song
    
    
    init(itemType: ItemType) {
        super.init(nibName: "ITunesMusicItemListViewController", bundle: .main)
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
    
    
    private func fetchSongs(isRefresh: Bool = false) {
        paginationViewModel.onPrepareFetch(isRefresh: isRefresh) {
            [weak self] shouldFetch, curRefreshHash, page in
            
            if !shouldFetch { return }
            
            KCITunesAPIQueryService.shared.searchSongs(
                withQuery: self?.query ?? "",
                limit: self?.itemsPerPage ?? 1,
                offset: page * (self?.itemsPerPage ?? 0),
                mediaType: self?.selectedMediaTypeValue,
                country: self?.selectedCountryValue,
                lang: AppLanguageManager.shared.currentKItunesSearchAPILanguage
            ) { [weak self] result in
                switch result {
                case .success(let songs):
                    
                    self?.paginationViewModel.onPostFetch(
                        curRefreshHash: curRefreshHash,
                        isRefresh: isRefresh,
                        isError: false,
                        isEnded: songs.isEmpty)
                    {
                        if isRefresh {
                            // restore RefreshControl
                            self?.tableView?.refreshControl?.endRefreshing()
                            // Refresh the viewmodel list
                            self?.itemViewModels.removeAll()
                            self?.tableView?.setContentOffset(.zero, animated: false)
                        }
                        
                        // Append the viewmodel list
                        self?.itemViewModels.append(contentsOf: songs.map { KCUIItunesItemSongViewModel(song: $0) } )
                        self?.reloadList()
                        self?.refreshState()
                    }
                    
                case .failure(let error):
                    print(error)
                    self?.paginationViewModel.onPostFetch(
                        curRefreshHash: curRefreshHash,
                        isRefresh: isRefresh,
                        isError: true,
                        isEnded: true)
                    {
                        if isRefresh {
                            // restore RefreshControl
                            self?.tableView?.refreshControl?.endRefreshing()
                        }
                        
                        self?.reloadList()
                        self?.refreshState()
                    }
                }
            }
        }
    }
    
    private func fetchArtists(isRefresh: Bool = false) {
        paginationViewModel.onPrepareFetch(isRefresh: isRefresh) {
            [weak self] shouldFetch, curRefreshHash, page in
            
            if !shouldFetch { return }
            
            KCITunesAPIQueryService.shared.searchArtists(
                withQuery: self?.query ?? "",
                limit: self?.itemsPerPage ?? 1,
                offset: page * (self?.itemsPerPage ?? 0),
                mediaType: self?.selectedMediaTypeValue,
                country: self?.selectedCountryValue,
                lang: AppLanguageManager.shared.currentKItunesSearchAPILanguage
            ) { [weak self] result in
                switch result {
                case .success(let artists):
                    
                    self?.paginationViewModel.onPostFetch(
                        curRefreshHash: curRefreshHash,
                        isRefresh: isRefresh,
                        isError: false,
                        isEnded: artists.isEmpty)
                    {
                        if isRefresh {
                            // restore RefreshControl
                            self?.tableView?.refreshControl?.endRefreshing()
                            // Refresh the viewmodel list
                            self?.itemViewModels.removeAll()
                            self?.tableView?.setContentOffset(.zero, animated: false)
                        }
                        
                        // Append the viewmodel list
                        self?.itemViewModels.append(contentsOf: artists.map { KCUIItunesItemArtistViewModel(artist: $0) } )
                        self?.reloadList()
                        self?.refreshState()
                    }
                    
                case .failure(let error):
                    print(error)
                    self?.paginationViewModel.onPostFetch(
                        curRefreshHash: curRefreshHash,
                        isRefresh: isRefresh,
                        isError: true,
                        isEnded: true)
                    {
                        if isRefresh {
                            // restore RefreshControl
                            self?.tableView?.refreshControl?.endRefreshing()
                        }
                        
                        self?.reloadList()
                        self?.refreshState()
                    }
                }
            }
        }
    }
    
    private func fetchAlbums(isRefresh: Bool = false) {
        paginationViewModel.onPrepareFetch(isRefresh: isRefresh) {
            [weak self] shouldFetch, curRefreshHash, page in
            
            if !shouldFetch { return }
            
            KCITunesAPIQueryService.shared.searchAlbums(
                withQuery: self?.query ?? "",
                limit: self?.itemsPerPage ?? 1,
                offset: page * (self?.itemsPerPage ?? 0),
                mediaType: self?.selectedMediaTypeValue,
                country: self?.selectedCountryValue,
                lang: AppLanguageManager.shared.currentKItunesSearchAPILanguage
            ) { [weak self] result in
                switch result {
                case .success(let albums):
                    
                    self?.paginationViewModel.onPostFetch(
                        curRefreshHash: curRefreshHash,
                        isRefresh: isRefresh,
                        isError: false,
                        isEnded: albums.isEmpty)
                    {
                        if isRefresh {
                            // restore RefreshControl
                            self?.tableView?.refreshControl?.endRefreshing()
                            // Refresh the viewmodel list
                            self?.itemViewModels.removeAll()
                            self?.tableView?.setContentOffset(.zero, animated: false)
                        }
                        
                        // Append the viewmodel list
                        self?.itemViewModels.append(contentsOf: albums.map { KCUIItunesItemAlbumViewModel(album: $0) } )
                        self?.reloadList()
                        self?.refreshState()
                    }
                    
                case .failure(let error):
                    print(error)
                    self?.paginationViewModel.onPostFetch(
                        curRefreshHash: curRefreshHash,
                        isRefresh: isRefresh,
                        isError: true,
                        isEnded: true)
                    {
                        if isRefresh {
                            // restore RefreshControl
                            self?.tableView?.refreshControl?.endRefreshing()
                        }
                        
                        self?.reloadList()
                        self?.refreshState()
                    }
                }
            }
        }
    }
    
    
    private func refreshState() {
        DispatchQueue.main.async {
            // todo: refresh tableview and loading screen visibility
        }
    }
    
    
    private func reloadList() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}


extension ITunesMusicItemListViewController: UITableViewDelegate, UITableViewDataSource {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height

        // Check if the user has scrolled to the bottom and isLoading is false
        if offsetY > contentHeight - screenHeight - screenHeight,
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
        
        AppCoreDataManager.shared.itunesAnyItem_addToFavourites(anyItem: itemViewModels[indexPath.row], itemType: itemType)
    }
}



