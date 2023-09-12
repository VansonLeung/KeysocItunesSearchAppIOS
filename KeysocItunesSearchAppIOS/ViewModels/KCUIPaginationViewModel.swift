//
//  KCUIPaginationViewModel.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import Foundation

class KCUIPaginationViewModel {
    var currentPage = 0
    var isLoading = false
    var isRefreshing = false
    var isEnded = false
    var isError = false
    var refreshHash: Int = 1
    
    
    func isLoadNextPageAvailable() -> Bool {
        return !isEnded && !isLoading && !isRefreshing && !isError
    }
    
    
    func onPrepareFetch(
        isRefresh: Bool,
        completion: @escaping (_ shouldFetch: Bool, _ curRefreshHash: Int, _ page: Int) -> Void)
    {
        if isRefreshing {
            return completion(false, -1, -1)
        }
        
        if isRefresh {
            isRefreshing = true
        } else {
            if isEnded {
                return completion(false, -1, -1)
            }
            if isLoading {
                return completion(false, -1, -1)
            }
            isLoading = true
        }
        

        // assign runtime values here
        let curRefreshHash = refreshHash
        let page = isRefresh ? 0 : currentPage
        
        return completion(true, curRefreshHash, page)
    }
    
    
    
    func onPostFetch(
        curRefreshHash: Int,
        isRefresh: Bool,
        isError: Bool,
        isEnded: Bool,
        completion: @escaping () -> Void)
    {
        // post-processing error
        if isError {
            self.isError = true
            self.isRefreshing = false
            self.isLoading = false
            // Reload
            DispatchQueue.main.async {
                completion()
            }
        }
        
        // post-processing refresh
        else if isRefresh {

            // update
            self.currentPage = 1
            self.refreshHash += 1
            self.isRefreshing = false
            self.isLoading = false
            self.isEnded = isEnded
            // Reload
            DispatchQueue.main.async {
                completion()
            }
        }
        
        // post-processing loading
        else {

            // check refresh hash:
            // if hash is unchanged, load more is valid
            if self.refreshHash == curRefreshHash {
                // update
                self.currentPage += 1
                self.isLoading = false
                self.isEnded = isEnded
                // Reload
                DispatchQueue.main.async {
                    completion()
                }
            }

        }
        
    }
}
