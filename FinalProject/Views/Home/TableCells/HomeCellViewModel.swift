//
//  HomeCellViewModel.swift
//  FinalProject
//
//  Created by thuan.nguyen on 17/06/2022.
//

import Foundation
final class HomeCellViewModel {
    // MARK: - Properties
    var nameHeader: String?
    var items: [Item] = []

    init(items: [Item], nameHeader: String?) {
        self.items = items
        self.nameHeader = nameHeader
    }

    func contentViewForViewCell(at indexPath: IndexPath) -> CustomHomeViewCellModell {
        let item = items[indexPath.row]
        return CustomHomeViewCellModell(image: item.track?.album?.images, nameSong: item.track?.album?.name, nameSing: item.track?.name)
    }

    func numberOfItemInSection(in section: Int) -> Int {
        return items.count
    }
}
