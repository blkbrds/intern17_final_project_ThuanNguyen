//
//  Music.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import Foundation

class Album {
    var name: String?
    var type: String?
    var images: String?

    init(json: JSObject) {
        guard let IJson = json["images"] as? [JSObject] else { return }
        self.images = IJson.first?["url"] as? String
        self.name = json["name"] as? String
        self.type = json["type"] as? String
    }
}

class Track {

    var album: Album?
    var name: String?
    var previewUrl: String?
    var duration: Int?

    init(json: JSObject) {
        guard let bJson = json["album"] as? JSObject else { return }
        self.album = Album(json: bJson)
        self.duration = json["duration_ms"] as? Int
        self.name = json["name"] as? String
        self.previewUrl = json["preview_url"] as? String
    }
}

class Item {
    var track: Track?
    var isLocal: Bool?

    init(json: JSObject) {
        guard let aJson = json["track"] as? JSObject else { return }
//        self.track = json["track"] as? Track
        self.track = Track(json: aJson)
        self.isLocal = json["is_local"] as? Bool
    }
    init(){ }
}
