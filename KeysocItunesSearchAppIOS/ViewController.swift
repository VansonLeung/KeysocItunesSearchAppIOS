//
//  ViewController.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 12/9/2023.
//

import UIKit
import KeysocItunesSearchAPIServiceiOS_Swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        KCITunesAPIQueryService.shared.searchSongs(withQuery: "alex") { result in
            switch result {
            case .success(let items):
                print(items)
            case .failure(let error):
                print(error)
            }
        }
    }


}

