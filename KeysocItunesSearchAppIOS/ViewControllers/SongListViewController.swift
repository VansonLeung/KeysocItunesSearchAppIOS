//
//  SongListViewController.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 12/9/2023.
//

import UIKit
import KeysocItunesSearchAPIServiceiOS_Swift

class SongListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var songViewModels: [SongViewModel] = []
    
    var currentPage = 0
    let itemsPerPage = 20
    var isLoading = false
    var isRefreshing = false
    var isEnded = false
    var isError = false
    var refreshHash: Int = 1
    
    var query = "alex"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set the custom cell identifier to "SongCell" in your storyboard or XIB
        tableView.register(UINib(nibName: "KCUISongListCellHorizontal", bundle: nil), forCellReuseIdentifier: "SongCell")

        // Fetch songs and update the view
        fetchSongs()
    }
    
    
    func fetchSongs(isRefresh: Bool = false) {
        
        if isRefreshing {
            return
        }
        
        
        if isRefresh {
            isRefreshing = true
        } else {
            if isEnded {
                return
            }
            if isLoading {
                return
            }
            isLoading = true
        }
        

        // assign runtime values here
        let curRefreshHash = refreshHash
        let page = isRefresh ? 0 : currentPage
        
        KCITunesAPIQueryService.shared.searchSongs(
            withQuery: query,
            limit: itemsPerPage,
            offset: page * itemsPerPage
        ) { [weak self] result in
            switch result {
            case .success(let songs):
                
                self?.isError = false

                // post-processing refresh / loading
                if isRefresh {

                    // update
                    self?.currentPage = 1
                    self?.refreshHash += 1
                    self?.isRefreshing = false
                    self?.isLoading = false
                    self?.isEnded = songs.isEmpty
                    // Refresh the viewmodel list
                    self?.songViewModels.removeAll()
                    self?.songViewModels.append(contentsOf: songs.map { SongViewModel(song: $0) } )
                    // Reload the table view on the main queue
                    self?.reloadList()
                    //

                } else {

                    // check refresh hash:
                    // if hash is unchanged, load more is valid
                    if let h = self?.refreshHash, h == curRefreshHash {
                        // update
                        self?.currentPage += 1
                        self?.isLoading = false
                        self?.isEnded = songs.isEmpty
                        // Append the viewmodel list
                        self?.songViewModels.append(contentsOf: songs.map { SongViewModel(song: $0) } )
                        // Reload the table view on the main queue
                        self?.reloadList()
                    }

                }
                
                self?.refreshState()
                
            case .failure(let error):
                print(error)
                self?.isError = true
                self?.reloadList()
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
            self.tableView.reloadData()
        }
    }
}

extension SongListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songViewModels.count
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 173
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        
        if let cell = cell as? KCUISongListCellHorizontal {
            let it = songViewModels[indexPath.row]
            cell.configure(with: it)
        }

        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height

        // Check if the user has scrolled to the bottom and isLoading is false
        if offsetY > contentHeight - screenHeight, !isLoading {
            fetchSongs()
        }
    }
}


