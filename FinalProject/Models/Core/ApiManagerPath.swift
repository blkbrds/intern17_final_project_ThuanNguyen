//
//  ApiManagerPath.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import Foundation

extension ApiManager {

    struct Key {
        static let rapidAPIKey: String = "c61ea92b81mshb1a02b6d13bcbbbp1d81dfjsn6ae0a0a2dc40"
        static let rapidAPIHost: String = "spotify23.p.rapidapi.com"
    }

    struct Path {
        static let baseURL: String = "https://spotify23.p.rapidapi.com"

        // example

        static let networkPath: String = baseURL + "/playlist_tracks/?id=37i9dQZF1DX4Wsb4d7NKfP&offset=0&limit=100"
    }
}
