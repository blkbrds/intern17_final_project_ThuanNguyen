//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by thuan.nguyen on 17/06/2022.
//

import Foundation
import SwiftUI

final class HomeViewModel {

    // MARK: - properties
    var imageList: [String] = []
    private var items: [Item] = []
    private var headerImageList: [String] = []
    private var randomNumberArray: [Int] = []
    private var itemList: [String] = []
    private var chillList: [Item] = []
    private var moodList: [Item] = []
    private var singList: [Item] = []
    private var instrucList: [Item] = []
    private var throwList: [Item] = []

    // MARK: Funtions
    private func makeList(_ n: Int) {
        randomNumberArray = (0..<n).map { _ in .random(in: 0..<imageList.count) }
    }

    func viewModelForHeaderViewItem(at indexPath: IndexPath) -> CustomHeaderViewModell {
        let image = imageList[randomNumberArray[indexPath.row]]
        return CustomHeaderViewModell(image: image)
    }

    private func getHeaderImageList() {
        items.forEach { item in
            if let imageUrl = item.track?.album?.images {
                headerImageList.append(imageUrl)
                imageList.append(imageUrl)
            }
        }
    }

    func numberOfItemInSection(in section: Int) -> Int {
        guard let type = SectionType(rawValue: section) else { return 0 }
        switch type {
        case .chill:
            return chillList.count
        case .sing:
            return singList.count
        case .mood:
            return moodList.count
        case .instrumental:
            return instrucList.count
        case .throwback:
            return throwList.count
        }
    }

    private func handleArr() {
        for i in 0 ... 99 {
            switch i {
            case 0...19:
                chillList.append(items[i])
            case 20...39:
                singList.append(items[i])
            case 40...59:
                moodList.append(items[i])
            case 60...79:
                instrucList.append(items[i])
            case 80...99:
                throwList.append(items[i])
            default:
                return
            }

        }
    }

    func contentModelForViewItem(at indexPath: IndexPath) -> HomeCellViewModel? {
        guard let type = SectionType(rawValue: indexPath.row) else { return nil }
        switch type {
        case .chill:
            return HomeCellViewModel(items: chillList, nameHeader: type.nameSection)
        case .sing:
            return HomeCellViewModel(items: singList, nameHeader: type.nameSection)
        case .mood:
            return HomeCellViewModel(items: moodList, nameHeader: type.nameSection)
        case .instrumental:
            return HomeCellViewModel(items: instrucList, nameHeader: type.nameSection)
        case .throwback:
            return HomeCellViewModel(items: throwList, nameHeader: type.nameSection)
        }
    }

    // MARK: Funtions get request API
    func requestAPI(completion: @escaping APICompletion) {
        let headers = [
            "X-RapidAPI-Key": ApiManager.Key.rapidAPIKey,
            "X-RapidAPI-Host": ApiManager.Key.RapidAPIHost
        ]
        ApiManager.shared.request(method: .get, headers: headers, with: ApiManager.Path.networkPath) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                guard let data = data else { return }
                if let items = data["items"] as? [JSObject] {
                    for item in items {
                        this.items.append(Item(json: item))
                    }
                    this.getHeaderImageList()
                    this.makeList(6)
                    this.handleArr()
                    completion(.success(data))

                } else {
                    print("fail")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum SectionType: Int, CaseIterable {
    case chill, sing, mood, instrumental, throwback

    var nameSection: String {
        switch self {
        case .chill:
            return "Chill"
        case .sing:
            return "Sing-along"
        case .mood:
            return "Mood"
        case .instrumental:
            return "Instrumental "
        case .throwback:
            return "Throwback"
        }
    }
}
