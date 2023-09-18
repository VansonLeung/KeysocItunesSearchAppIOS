# KeysocItunesSearchAppIOS

## Demo

https://github.com/VansonLeung/KeysocItunesSearchAppIOS/assets/1129695/07f3b490-6e35-45c6-a2bb-042dea3943de

## iOS target OS version

- 11.0

## Project installation

1. Download / clone from:
https://github.com/VansonLeung/KeysocItunesSearchAppIOS

2. Open Xcode project file: `KeysocItunesSearchAppIOS.xcodeproj`

3. Run project (schema name: `KeysocItunesSearchAppIOS`)

4. Or, launch tests in `KeysocItunesSearchAppIOSUITests`


## Project modules / dependencies

- [KeysocItunesSearchAPIServiceiOS-Swift](https://github.com/VansonLeung/KeysocItunesSearchAPIServiceiOS-Swift)

- [SDWebImage](https://github.com/SDWebImage/SDWebImage)

- [Toast-Swift](https://github.com/scalessec/Toast-Swift)



## App Architecture

![app_architecture drawio](https://github.com/VansonLeung/KeysocItunesSearchAppIOS/assets/1129695/3dd69073-dd34-4f21-bf6e-be0b8a36ddf1)

- KCUI* is a UI element family that extends from UIKit.
- KCUI*'s Main features include:
  - App localization observer
  - App UI element base styling
  - Adapt any data to presentation layer via KCUI*ViewModel
- Core Data functions to:
  - store favourites
  - store search history


## App MVVM flow

The MVVM architecture separates the concerns of data retrieval, presentation logic, and user interface interactions, ensuring a well-structured and maintainable codebase.

### Components

#### `ITunesSearchBundleListViewController`
- This view controller serves as the primary user interface for our iTunes search app.
- It includes a `UISearchBar` for user input.
- It also includes an embedded `ITunesMusicItemListViewController` for displaying search results.

#### `ITunesMusicItemListViewController`
- Responsible for displaying the search results to the user.
- Manages a var itemViewModels: `[KCUIItunesItemAnyViewModel]` to store view models for displaying items.
- Utilizes a `UITableView` (tableView) for rendering the search results.
- Contains a var paginationViewModel: `KCUIPaginationViewModel` to manage the pagination state of the search list.

#### User Interaction Flow
- The user interacts with the `UISearchBar` by entering keywords for their search.
- In response to the user's action, the `ITunesMusicItemListViewController` triggers the `fetchAny(isRefresh: true)` function.

#### Fetching Songs / Albums / Artists ( `fetchAny(isRefresh: true)` )
- Initiates a refresh of the item list.
- Calls `paginationViewModel.onPrepareFetch(isRefresh: true, completion: @escaping (_ shouldFetch: Bool, _ curRefreshHash: Int, _ page: Int) -> Void)` to determine if a fetch operation is allowed, and obtain the fetch params (e.g. refresh hash, load more page).

#### API Call
- Songs: `KCITunesAPIQueryService.shared.searchSongs(...)`
- Albums: `KCITunesAPIQueryService.shared.searchAlbums(...)`
- Artists: `KCITunesAPIQueryService.shared.searchArtists(...)`
- If the fetch operation is allowed, the view controller makes an API call to the iTunes search API.
- The API call includes parameters such as query, pagination, media type, country, and language.
- Usage example:
```swift
...


    func fetchAny(isRefresh: Bool = false) {
        switch itemType {
        case .song:
            fetchSongs(isRefresh: isRefresh)
        case .artist:
            fetchArtists(isRefresh: isRefresh)
        case .album:
            fetchAlbums(isRefresh: isRefresh)
        }
    }
    
    private func fetchSongs(isRefresh: Bool = false) {
        paginationViewModel.onPrepareFetch(isRefresh: isRefresh) {
            [weak self] shouldFetch, curRefreshHash, page in
            
            if !shouldFetch { return }
            
            KCITunesAPIQueryService.shared.searchSongs(
                withQuery: self?.query ?? "",
                limit: self?.itemsPerPage ?? 1,
                offset: page * (self?.itemsPerPage ?? 0),
                mediaType: self?.selectedMediaTypeValue,
                country: self?.selectedCountryValue,
                lang: AppLanguageManager.shared.currentKItunesSearchAPILanguage
...

```

#### API Response Handling
- Upon receiving a response from the API call, the following steps are taken:
  - `paginationViewModel.onPostFetch(...)` is called to update the pagination state and perform post-processing.
  - If it's a refresh operation, the view is cleared ( `itemViewModels.removeAll()` ) and refreshed ( `tableView?.setContentOffset(...)` ) before appending new data.
  - View models for the fetched items are created (e.g. `KCUIItunesItemSongViewModel(song: $0))` and added to itemViewModels.
  - The list view is reloaded ( `tableView.reloadData()` ) to reflect the changes.
  - The UI's refresh state is updated based on the post-processing logic.
  - Code snippet:
    ```swift
    ...
    ) { [weak self] result in
        switch result {
        case .success(let songs):

          self?.paginationViewModel.onPostFetch(
              curRefreshHash: curRefreshHash,
              isRefresh: isRefresh,
              isError: false,
              isEnded: songs.isEmpty)
          {
              if isRefresh {
                  // restore RefreshControl
                  self?.tableView?.refreshControl?.endRefreshing()
                  // Refresh the viewmodel list
                  self?.itemViewModels.removeAll()
                  self?.tableView?.setContentOffset(.zero, animated: false)
              }
              
              // Append the viewmodel list
              self?.itemViewModels.append(contentsOf: songs.map { KCUIItunesItemSongViewModel(song: $0) } )
              self?.reloadList()
              self?.refreshState()
          }
    ...
    ```

#### Pagination (`KCUIPaginationViewModel`)
- The app includes pagination for loading additional search results.
- `KCUIPaginationViewModel` is used to store the pagination state and act as a state reducer:
  ```swift
  class KCUIPaginationViewModel {
    
    /// current page of the list data fetch
    var currentPage = 0
    
    /// loading busy status
    var isLoading = false
    
    /// refreshing busy status
    var isRefreshing = false
    
    /// whether the list data is ended
    var isEnded = false
    
    /// whether the list data encounters an error
    var isError = false
    
    /// used for identifying each refresh action
    var refreshHash: Int = 1

  ...
  ...
  ```
- The `scrollViewDidScroll` delegate method is used to detect if the user has scrolled to the bottom of the list.
- The `paginationViewModel.isLoadNextPageAvailable()` function checks whether loading the next page is allowed.
- If the user has reached the bottom and loading the next page is permitted, `fetchAny(isRefresh: false)` is called to fetch more data.


### Summary
Our iTunes search app implements a clean and organized MVVM architecture to provide users with a seamless search experience. By separating concerns and managing data retrieval, presentation, and user interactions, we ensure that our app is maintainable and user-friendly. This documentation serves as a reference for our development team members to understand the app's architecture and flow.


