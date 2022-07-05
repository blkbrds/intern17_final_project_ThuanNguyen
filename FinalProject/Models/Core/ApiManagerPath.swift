//
//  ApiManagerPath.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import Foundation

extension ApiManager {

    struct Key {
        static let rapidAPIKey: String = "5736dfa7d1msh2f886e8f3131557p19ffffjsn30b2d03ed2ec"
        static let RapidAPIHost: String = "spotify23.p.rapidapi.com"
    }

    struct Path {
        static let baseURL: String = "https://spotify23.p.rapidapi.com"

        // example

        static let networkPath: String = baseURL + "/playlist_tracks/?id=37i9dQZF1DX4Wsb4d7NKfP&offset=0&limit=100"
    }
}
