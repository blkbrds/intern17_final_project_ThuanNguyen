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
    @IBOutlet private weak var freeLabel: UILabel!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - private funtions
    private func setupNavigation() {
        title = "Tài khoản cá nhân"
        let settingButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic-settings"), style: .plain, target: self, action: #selector(settingsAction))
        navigationItem.rightBarButtonItem = settingButton
        let backButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic-backnavi").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton
    }

    private func setupLabel() {
        freeLabel.layer.borderWidth = 2.0
        freeLabel.layer.borderColor = UIColor.white.cgColor
        freeLabel.layer.cornerRadius = 8
    }

    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func setupUI() {
        setupNavigation()
        configTableView()
        setupLabel()
    }

    // MARK: - Actions
    @objc private func settingsAction() {

    }

    @objc private func backAction() {

    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Danh sách quan tâm "
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {

}

