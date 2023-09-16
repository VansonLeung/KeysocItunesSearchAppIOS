//
//  KCUIGenericPickerCellViewModel.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 16/9/2023.
//

import UIKit
import KeysocItunesSearchAPIServiceiOS_Swift

class KCUIGenericPickerCellViewModel {
    
    typealias TA_onKCUIGenericPickerCellViewModelSelected = (() -> Void)
    
    enum CellType {
        case pickerItem
        case actionItem
    }
    
    
    
    var label: String?
    var value: String?
    var onSelected: TA_onKCUIGenericPickerCellViewModelSelected?

    var cellType: CellType = .pickerItem
    

    

    
    
    init(label: String?,
         value: String?,
         cellType: CellType,
         onSelected: TA_onKCUIGenericPickerCellViewModelSelected? = nil)
    {
        self.label = label
        self.value = value
        self.onSelected = onSelected
        self.cellType = cellType
    }
    
    
    init(country: KCItunesParamCountry,
         cellType: CellType,
         onSelected: TA_onKCUIGenericPickerCellViewModelSelected? = nil)
    {
        let lang = AppLanguageManager.shared.currentLanguage
        if lang == "en" {
            self.label = country.english
        } else if lang == "zh-Hant" {
            self.label = country.chinese_tc
        } else if lang == "zh-Hans" {
            self.label = country.chinese_sc
        } else {
            self.label = country.english
        }
        self.value = country.abbr
        self.onSelected = onSelected
        self.cellType = cellType
    }
    
    
    init(mediaType: KCItunesParamMediaType,
         cellType: CellType,
         onSelected: TA_onKCUIGenericPickerCellViewModelSelected? = nil)
    {
        let lang = AppLanguageManager.shared.currentLanguage
        if lang == "en" {
            self.label = mediaType.val_en
        } else if lang == "zh-Hant" {
            self.label = mediaType.val_zh_hk
        } else if lang == "zh-Hans" {
            self.label = mediaType.val_zh_cn
        } else {
            self.label = mediaType.val_en
        }
        self.value = mediaType.val
        self.onSelected = onSelected
        self.cellType = cellType
    }
    
    
    
    func fulfillCell(
        cell: UITableViewCell,
        selectedPickerItemValue: String? = nil
    ) {
        
        switch cellType {
            
        case .pickerItem:
            cell.textLabel?.text = label ?? ""
            cell.detailTextLabel?.text = ""

            if value == selectedPickerItemValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
        case .actionItem:
            
            cell.textLabel?.text = label ?? ""
            cell.detailTextLabel?.text = selectedPickerItemValue ?? ""
            cell.accessoryType = .disclosureIndicator

        }
    }
    
}
