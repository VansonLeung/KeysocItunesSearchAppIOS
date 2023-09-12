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
   
    var paginationViewModel = KCUIPaginationViewModel()
    
    let itemsPerPage = 20

    var query = "alex"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set the custom cell identifier to "SongCell" in your storyboard or XIB
        tableView.register(UINib(nibName: "KCUISongListCellHorizontal", bundle: nil), forCellReuseIdentifier: "SongCell")

        // Fetch songs and update the view
        fetchSongs(isRefresh: true)

        // Add RefreshControl to tableView
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.blue // Change the spinner color
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh") // Add a title
        tableView.refreshControl = refreshControl
    }
    

    @objc func refreshTableView(_ sender: UIRefreshControl) {
        // Fetch songs and update the view
        fetchSongs(isRefresh: true)
    }
    
    
    func fetchSongs(isRefresh: Bool = false) {
        paginationViewModel.onPrepareFetch(isRefresh: isRefresh) {
            [weak self] shouldFetch, curRefreshHash, page in
            
            if !shouldFetch { return }
            
            KCITunesAPIQueryService.shared.searchSongs(
                withQuery: self?.query ?? "",
                limit: self?.itemsPerPage ?? 1,
                offset: page * (self?.itemsPerPage ?? 0)
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
                            self?.tableView.refreshControl?.endRefreshing()
                            // Refresh the viewmodel list
                            self?.songViewModels.removeAll()
                        }
                        
                        // Append the viewmodel list
                        self?.songViewModels.append(contentsOf: songs.map { SongViewModel(song: $0) } )
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
                            self?.tableView.refreshControl?.endRefreshing()
                        }
                        
                        self?.reloadList()
                        self?.refreshState()
                    }
                }
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height

        // Check if the user has scrolled to the bottom and isLoading is false
        if offsetY > contentHeight - screenHeight,
            paginationViewModel.isLoadNextPageAvailable() {
            fetchSongs()
        }
    }


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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


