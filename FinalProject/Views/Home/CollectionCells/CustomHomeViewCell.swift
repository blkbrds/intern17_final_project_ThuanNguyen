//
//  CustomHomeViewCell.swift
//  FinalProject
//
//  Created by thuan.nguyen on 21/06/2022.
//

import UIKit

class CustomHomeViewCell: UICollectionViewCell {

    var contentModel: CustomHomeViewCellModell? {
        didSet {
            updateView()
        }
    }

    // MARK: Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameSongLabel: UILabel!
    @IBOutlet weak var nameSingLabel: UILabel!

    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - private functions
    private func updateView() {
        guard let contentModel = contentModel else { return }
        nameSongLabel.text = contentModel.nameSong
        nameSingLabel.text = contentModel.nameSing
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.downloaded(from: contentModel.image ?? "", contentMode: .scaleToFill)
    }
}
