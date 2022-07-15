//
//  CustomHomeViewCellModel.swift
//  FinalProject
//
//  Created by thuan.nguyen on 21/06/2022.
//

import Foundation
class  CustomHomeViewCellModell {

    var image: String?
    var nameSong: String?
    var nameSing: String?
    var previewUrl: String?

    init(image: String?, nameSong: String?, nameSing: String?, previewUrl: String?) {
        self.image = image
        self.nameSong = nameSong
        self.nameSing = nameSing
        self.previewUrl = previewUrl
    }
}
