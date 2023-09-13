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
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: NSNotification.Name("LanguageDidChange"), object: nil)
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
