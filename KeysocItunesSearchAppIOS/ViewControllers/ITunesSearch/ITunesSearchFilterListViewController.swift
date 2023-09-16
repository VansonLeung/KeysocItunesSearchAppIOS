//
//  ITunesSearchFilterListViewController.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 16/9/2023.
//

import UIKit
import KeysocItunesSearchAPIServiceiOS_Swift

class ITunesSearchFilterListViewController : KCUIViewController {
    
    public var selectedCountryValue: String? = nil {
        didSet {
            tableView?.reloadData()
        }
    }
    public var selectedMediaTypeValue: String? = nil {
        didSet {
            tableView?.reloadData()
        }
    }

    public var onDismiss: ((_ selectedCountryValue: String?, _ selectedMediaTypeValue: String?) -> Void)?

    
    
    
    private var countryCellViewModelList: [KCUIGenericPickerCellViewModel] = []
    private var mediaTypeCellViewModelList: [KCUIGenericPickerCellViewModel] = []

    private var actionCountryCellViewModelList: [KCUIGenericPickerCellViewModel] = []

    @IBOutlet private var tableView: UITableView?
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(KCUISubtitleTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView?.register(KCUITableSectionHeaderViewCell.classForCoder(), forHeaderFooterViewReuseIdentifier: "HeaderView")

        
        let countryList : [KCItunesParamCountry] = KCItunesParamCountryManager.shared.CountryListArray
        let mediaTypeList : [KCItunesParamMediaType] = KCItunesParamMediaTypeManager.shared.MediaTypeListArray
        
        countryCellViewModelList = countryList.map({ it in
            KCUIGenericPickerCellViewModel(
                country: it,
                cellType: .pickerItem)
        })
        
        mediaTypeCellViewModelList = mediaTypeList.map({ it in
            KCUIGenericPickerCellViewModel(
                mediaType: it,
                cellType: .pickerItem)
        })
        
        actionCountryCellViewModelList = [
            KCUIGenericPickerCellViewModel(
                label: "select_country".i18n(),
                value: selectedCountryValue,
                cellType: .actionItem,
                onSelected: { [weak self] in
                    
                    let vc = KCUIGenericPickerViewController(
                        titleLocalizationKey: "select_country".i18n(),
                        pickerItemList: self?.countryCellViewModelList ?? []) {
                            return self?.selectedCountryValue
                        } onSelectPickerItemValue: { newValue in
                            self?.selectNewCountryValue(newVal: newValue)
                        }

                    self?.navigationController?.pushViewController(vc, animated: true)
                })
                
        ]
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDismiss?(selectedCountryValue, selectedMediaTypeValue)
    }
    
    
    
    func selectNewCountryValue(newVal: String?) {
        if let newVal = newVal {
            if newVal == selectedCountryValue {
                selectedCountryValue = nil
            } else {
                selectedCountryValue = newVal
            }
        } else {
            selectedCountryValue = newVal
        }
    }
    
    
    
    func selectNewMediaTypeValue(newVal: String?) {
        if let newVal = newVal {
            if newVal == selectedMediaTypeValue {
                selectedMediaTypeValue = nil
            } else {
                selectedMediaTypeValue = newVal
            }
        } else {
            selectedMediaTypeValue = newVal
        }
    }
    
    
}

extension ITunesSearchFilterListViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return mediaTypeCellViewModelList.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? KCUITableSectionHeaderViewCell
        if let cell = cell {
            if section == 0 {
                cell.label?.text = "by_country".i18n()
            } else if section == 1 {
                cell.label?.text = "by_mediatype".i18n()
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if indexPath.section == 0 {
            
            actionCountryCellViewModelList[indexPath.row].fulfillCell(cell: cell, selectedPickerItemValue: selectedCountryValue)

            
        } else if indexPath.section == 1 {
            
            mediaTypeCellViewModelList[indexPath.row].fulfillCell(cell: cell, selectedPickerItemValue: selectedMediaTypeValue)
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
            actionCountryCellViewModelList[indexPath.row].onSelected?()
            
        } else if indexPath.section == 1 {
            
            selectNewMediaTypeValue(newVal: mediaTypeCellViewModelList[indexPath.row].value)
            
        }
    }
}



