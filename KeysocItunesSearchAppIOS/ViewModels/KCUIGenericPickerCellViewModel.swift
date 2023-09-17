//
//  KCUIGenericPickerCellViewModel.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 16/9/2023.
//

import UIKit
import KeysocItunesSearchAPIServiceiOS_Swift

/// Generic picker view model for UITableViewCell
class KCUIGenericPickerCellViewModel {
    
    typealias TA_onKCUIGenericPickerCellViewModelSelected = (() -> Void)

    
    /// Cell type
    ///
    /// Cases:
    ///   - pickerItem: for use in picker view, will display `checkmark` indicator for selected item(s)
    ///   - actionItem: for use in action view, will display `disclosureIndicator` indicator, and will display intrinsic value in `detailTextView`
    ///   - normalItem: for use in any view, will display no indicators or intrinsic values
    enum CellType {
        case pickerItem
        case actionItem
        case normalItem
    }
    
    
    
    var label: String?
    var value: String?
    var onSelected: TA_onKCUIGenericPickerCellViewModelSelected?

    var cellType: CellType = .pickerItem
    

    

    
    /// `init` used for any generic use
    ///
    /// Cases:
    ///   - label: cell title
    ///   - value: cell intrinsic value
    ///   - cellType: cell type
    ///   - onSelected: callback when the cell is being selected
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
    
    
    /// `init` used by picker list `KCItunesParamCountry`
    ///
    /// Cases:
    ///   - country: `KCItunesParamCountry`
    ///   - cellType: cell type
    ///   - onSelected: callback when the cell is being selected
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
    
    
    /// `init` used by picker list `KCItunesParamMediaType`
    ///
    /// Cases:
    ///   - mediaType: `KCItunesParamMediaType`
    ///   - cellType: cell type
    ///   - onSelected: callback when the cell is being selected
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
    
    
    
    
    /// `init` used by picker list `HistoryItunesSearch`
    ///
    /// Cases:
    ///   - historyItunesSearch: `HistoryItunesSearch`
    ///   - cellType: cell type
    ///   - onSelected: callback when the cell is being selected
    init(historyItunesSearch: HistoryItunesSearch,
         cellType: CellType,
         onSelected: TA_onKCUIGenericPickerCellViewModelSelected? = nil)
    {
        self.label = historyItunesSearch.text
        self.value = historyItunesSearch.text
        self.onSelected = onSelected
        self.cellType = cellType
    }
    
    
    /// Configure `UITableViewCell`'s display
    ///
    /// Parameters:
    ///   - cell: target `UITableViewCell` to display
    ///   - selectedPickerItemValue: selected value
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

        case .normalItem:
            
            cell.textLabel?.text = label ?? ""
            cell.detailTextLabel?.text = nil
            cell.accessoryType = .none
            
        }
    }
    
}
