//
//  DateHelper.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import Foundation

class DateHelper: NSObject {
    
    class func dateParse(str : String?, dateFormat: String = "yyyy-MM-ddTHH:mm:ssZ") -> Date?
    {
        if str == nil
        {
            return nil
        }
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = dateFormatter.date(from: str!)
        return date
    }
    
    class func dateFormat(date : Date?, dateFormat: String = "yyyy-MM-dd") -> String?
    {
        if date == nil
        {
            return ""
        }
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let str = dateFormatter.string(from: date!)
        return str
    }
    
    class func dateFormatLocalized(date : Date?, dateFormat: String = "EEEE MMMM d yyyy") -> String?
    {
        if date == nil
        {
            return ""
        }
        var dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: GetCurrentLanguage(bundle: Bundle.main))
        dateFormatter.setLocalizedDateFormatFromTemplate(dateFormat)
        let str = dateFormatter.string(from: date!)
        return str
    }
    
    
}

