//
//  ITunesSearchHistoryListViewController.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 17/9/2023.
//

import UIKit

class ITunesSearchHistoryListViewController : UIViewController {
    
    typealias OnSelectHistoryItem = ((_ item: String?) -> Void)
    typealias OnClickEmptySpace = (() -> Void)

    @IBOutlet weak var tableView: UITableView?
    
    var onSelectHistoryItem: OnSelectHistoryItem?
    var onClickEmptySpace: OnClickEmptySpace?
    
    var pickerCellViewModelList: [KCUIGenericPickerCellViewModel] = []

    public var query : String = "" {
        didSet {
            AppCoreDataManager.shared.historyItunesSearch_upsert(text: query)
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(KCUISubtitleTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView?.backgroundView = UIView()
        tableView?.backgroundView?.backgroundColor = .secondaryLabel
        tableView?.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onClickTableViewEmptySpace)))
    }
    
    func refreshData() {
        pickerCellViewModelList.removeAll()
        pickerCellViewModelList.append(contentsOf: AppCoreDataManager.shared.historyItunesSearch_select(entityType: HistoryItunesSearch.self).map({ it in
            KCUIGenericPickerCellViewModel(historyItunesSearch: it, cellType: .normalItem)
        }))
        tableView?.reloadData()
    }
    
    
    @objc func onClickTableViewEmptySpace() {
        onClickEmptySpace?()
    }
}

extension ITunesSearchHistoryListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickerCellViewModelList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        pickerCellViewModelList[indexPath.row].fulfillCell(cell: cell)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onSelectHistoryItem?(pickerCellViewModelList[indexPath.row].value)
    }
    
}
