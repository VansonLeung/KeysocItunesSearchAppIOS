//
//  SettingsLanguageViewController.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit


class SettingsLanguagePickerViewController: KCUIViewController {
    
    let languageOptions = ["English", "繁體中文", "簡體中文"]
    let languageOptionsMapping = ["en", "zh-Hant", "zh-Hans"]

    override var titleLocalizationKey: String {
        return "tbi_languages"
    }
    
    @IBOutlet weak private var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "LanguageCell")
    }
}

extension SettingsLanguagePickerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)
        cell.textLabel?.text = languageOptions[indexPath.row]
        if languageOptionsMapping[indexPath.row] == AppLanguageManager.shared.currentLanguage {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        AppLanguageManager.shared.changeAppLanguage(language: languageOptionsMapping[indexPath.row])
        tableView.reloadData()
    }
}
    

