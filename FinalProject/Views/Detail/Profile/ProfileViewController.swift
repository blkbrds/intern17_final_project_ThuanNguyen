//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by thuan.nguyen on 16/06/2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - private funtions
    private func setupNavigation() {
        title = "Tài khoản cá nhân"
        let settingButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic-settings"), style: .plain, target: self, action: #selector(settingsAction))
        navigationItem.rightBarButtonItem = settingButton
    }

    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func setupUI() {
        setupNavigation()
        configTableView()
    }

    // MARK: - Actions
    @objc private func settingsAction() {

    }
}

// MARK: - UITableView
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Name\(indexPath.row + 1)"
        return cell
    }
}
