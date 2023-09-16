//
//  GenericPickerViewController.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit

class KCUIGenericPickerViewController: KCUIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    typealias TA_GetSelectedPickerItemValue = (() -> String?)
    typealias TA_OnSelectPickerItemValue = ((_ newValue: String?) -> Void)
    
    private var pickerItemList: [KCUIGenericPickerCellViewModel]?
    private var getSelectedPickerItemValue: TA_GetSelectedPickerItemValue?
    private var onSelectPickerItemValue: TA_OnSelectPickerItemValue?

    init(
        titleLocalizationKey: String = "",
        pickerItemList: [KCUIGenericPickerCellViewModel],
        getSelectedPickerItemValue: TA_GetSelectedPickerItemValue?,
        onSelectPickerItemValue: TA_OnSelectPickerItemValue?
    )
    {
        self.pickerItemList = pickerItemList
        self.getSelectedPickerItemValue = getSelectedPickerItemValue
        self.onSelectPickerItemValue = onSelectPickerItemValue
        super.init(nibName: nil, bundle: nil)
        self.overrideTitleLocalizationKey = titleLocalizationKey
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension KCUIGenericPickerViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickerItemList?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let it = pickerItemList?[indexPath.row] {
            it.fulfillCell(
                cell: cell,
                selectedPickerItemValue: getSelectedPickerItemValue?()
            )
        }
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let it = pickerItemList?[indexPath.row] {
            onSelectPickerItemValue?(it.value)
        }
        tableView.reloadData()
    }
    
    
}


