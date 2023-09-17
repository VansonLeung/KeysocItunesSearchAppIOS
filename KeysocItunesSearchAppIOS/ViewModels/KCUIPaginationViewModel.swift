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
    
    
    /// State function to determine whether the pagination view model can load next page
    func isLoadNextPageAvailable() -> Bool {
        return !isEnded && !isLoading && !isRefreshing && !isError
    }
    
    
    /// Prepare the pagination view model to load the next request (next page or refresh)
    ///
    /// - Parameters:
    ///   - isRefresh: whether the next request is refresh or load-more
    ///   - completion: callback of:
    ///     - shouldFetch: `Bool` whether the next request should be called or not
    ///     - curRefreshHash: `Int` to identify each refresh action
    ///     - page: `Int` to return the current page (or return 0 for refresh action)
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
    
    
    
    /// Post-process the pagination view model to end the current request
    ///
    /// - Parameters:
    ///   - curRefreshHash: input of `curRefreshHash` from `onPrepareFetch(..)`
    ///   - isRefresh: input of `isRefresh` from `onPrepareFetch(..)`
    ///   - isError: `Bool` to indicate if the request has error (e.g. API error)
    ///   - isEnded: `Bool` to indicate if the request has ended (e.g. last page has reached, no more results)
    ///   - completion: callback, post-processing is done
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

            if self.refreshHash == curRefreshHash {
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
