//
//  KCUISegmentedControl.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit

class KCUISegmentedControl: UISegmentedControl {
    @IBInspectable var segmentsLocalizationKeyArray: [String] = [] {
        didSet {
            updateText()
        }
    }
    
    /// Used for setting localization keys for each segment button title, separated by ","
    ///
    /// Example input:
    /// `Apple,Banana,Circle`
    @IBInspectable private var stringArrayInspectable: String {
        get {
            return segmentsLocalizationKeyArray.joined(separator: ",")
        }
        set {
            segmentsLocalizationKeyArray = newValue.components(separatedBy: ",")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: NSNotification.Name(AppLanguageManager.kLanguageDidChangeKey), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func updateText() {
        for k in 0 ..< max(segmentsLocalizationKeyArray.count, numberOfSegments) {
            let t = segmentsLocalizationKeyArray[k].trimmingCharacters(in: .whitespacesAndNewlines)
            if !t.isEmpty {
                setTitle(t.i18n(), forSegmentAt: k)
            }
        }
    }

    @objc private func languageDidChange() {
        updateText()
    }
    
}
