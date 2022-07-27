//
//  PlayViewControllerModel.swift
//  FinalProject
//
//  Created by thuan.nguyen on 30/06/2022.
//

import Foundation
import UIKit
class PlayViewModel {

    // MARK: - properties
    var item: Item?
    var itemsFromHome: [Item] = []

    init(item: Item = Item()) {
        self.item = item
    }

    func getDataFromHome(items: [Item]) {
        itemsFromHome = items
    }
}
