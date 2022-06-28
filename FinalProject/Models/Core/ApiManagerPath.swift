//
//  ApiManagerPath.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import Foundation

extension ApiManager {
    struct Path {
        static let baseURL: String = "https://spotify23.p.rapidapi.com"

        // example

        static let networkPath: String = baseURL + "/playlist_tracks/?id=37i9dQZF1DX4Wsb4d7NKfP&offset=0&limit=100"
    }
}
