//
//  CustomHeaderView.swift
//  FinalProject
//
//  Created by thuan.nguyen on 21/06/2022.
//

import UIKit

class CustomHeaderView: UICollectionViewCell {

    var headerModel: CustomHeaderViewModell? {
        didSet {
            updateView()
        }
    }

    // MARK: Outlet
    @IBOutlet weak var imageView: UIImageView!

    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - private functions
    private func updateView() {
        guard let viewModel = headerModel, let imageUrl = viewModel.image else { return }
        imageView.loadImageInPlaylistTrack(from: imageUrl, contentMode: .scaleToFill)
        imageView.clipsToBounds = true
    }

}
