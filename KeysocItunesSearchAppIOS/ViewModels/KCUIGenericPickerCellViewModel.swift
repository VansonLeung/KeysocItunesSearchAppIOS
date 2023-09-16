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
        self.label = country.english
        self.value = country.abbr
        self.onSelected = onSelected
        self.cellType = cellType
    }
    
    
    init(mediaType: KCItunesParamMediaType,
         cellType: CellType,
         onSelected: TA_onKCUIGenericPickerCellViewModelSelected? = nil)
    {
        self.label = (mediaType.val ?? "").i18n()
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
