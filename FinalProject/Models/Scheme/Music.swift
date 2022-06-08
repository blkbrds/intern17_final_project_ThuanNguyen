//
//  Music.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import Foundation

final class Music {
    var id: String
    var artistName: String
    var releaseDate: String
    var name: String
    var artworkUrl100: String

    init(json: JSObject) {
        self.id = json["id"] as? String ?? ""
        self.artistName = json["artistName"] as? String ?? ""
        self.releaseDate = json["releaseDate"] as? String ?? ""
        self.name = json["name"] as? String ?? ""
        self.artworkUrl100 = json["artworkUrl100"] as? String ?? ""
    }
}
