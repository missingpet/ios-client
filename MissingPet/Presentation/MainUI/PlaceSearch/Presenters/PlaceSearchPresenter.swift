//
//  PlaceSearchPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 18.12.2020.
//

import Foundation

class PlaceSearchPresenter: PresenterType {

    var updateSearchResultsWithCount: UISetter<Int>?

    var loadingSetter: UISetter<Bool>?

    private let notificationCenter = NotificationCenter.default

    private let placeRepository: PlaceRepositoryType!

    init(placeRepository: PlaceRepositoryType) {
        self.placeRepository = placeRepository
    }

    func postAddressSelectedNotification(userInfo: [String : Any]) {
        notificationCenter.post(name: Notification.Name(Constants.addressSelected),
                                object: nil, userInfo: userInfo)
    }

    func getUserInfoForItem(at index: Int) -> [String : Any] {
        let item = searchResults[index]
        let userInfo: [String : Any] = [
            "address": item.addressLine,
            "latitude": item.latitude,
            "longitude": item.longitude
        ]
        return userInfo
    }

    private var searchResults = [PlaceItem]()

    var itemsTotal: Int {
        return searchResults.count
    }

    private func startLoading() {
        loadingSetter?(true)
    }

    private func stopLoading() {
        loadingSetter?(false)
    }

    func item(at index: Int) -> PlaceItem {
        return searchResults[index]
    }

    func popViewController() {
        Navigator().pop()
    }

    func searchForPlace(searchText: String) {
        self.startLoading()
        self.placeRepository.searchForPlaces(searchText: searchText,
                                             onSuccess: { [weak self] result in
                                                DispatchQueue.main.async {
                                                    self?.searchResults = result
                                                    if let itemsTotal = self?.itemsTotal {
                                                        self?.updateSearchResultsWithCount?(itemsTotal)
                                                    }
                                                    self?.stopLoading()
                                                }
                                             },
                                             onFailure: { [weak self] (_) in
                                                DispatchQueue.main.async {
                                                    self?.stopLoading()
                                                }
                                             })
    }

}
