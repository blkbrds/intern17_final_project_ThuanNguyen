//
//  ImageExt.swift
//  FinalProject
//
//  Created by thuan.nguyen on 21/06/2022.
//

import UIKit

extension UIImageView {

    func loadImageInPlaylistTrack(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }

    func loadImageInPlaylistTrack(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        loadImageInPlaylistTrack(from: url, contentMode: mode)
    }
}
