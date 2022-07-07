//
//  PlayViewController.swift
//  MyMusic
//
//  Created by thuan.nguyen on 13/06/2022.
//

import UIKit

final class PlayViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var imageView: UIImageView!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }

    // MARK: - private funtions
    private func setupNavigation() {
        title = "My Music"
        let rightButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic-reveal"), style: .plain, target: self, action: #selector(rightAction))
        let downloadButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic-heart"), style: .plain, target: self, action: #selector(downloadAction))
        let closeButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic-close"), style: .plain, target: self, action: #selector(closeAction))
        self.navigationItem.rightBarButtonItems = [rightButton, downloadButton]
        self.navigationItem.leftBarButtonItem = closeButton
    }

    // MARK: Actions
    @objc private func rightAction() {

    }

    @objc private func downloadAction() {

    }

    @objc private func closeAction() {

    }
}
