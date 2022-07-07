//
//  HomeViewController.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Oulets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - private functions
    private func setupView() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(imageLiteralResourceName: "background.jpeg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }

    private func setupNavigation() {
        title = "My Music"
        let profileButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "profile"), style: .plain, target: self, action: #selector(profileAction))
        navigationItem.leftBarButtonItem = profileButton
        let notifyButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic-bell"), style: .plain, target: self, action: #selector(notifyAction))
        let searchBar = UIBarButtonItem(systemItem: .search)
        searchBar.action = #selector(searchAction)
        navigationItem.rightBarButtonItems = [searchBar,notifyButton]
    }

    private func configTableView() {
        let nib1 = UINib(nibName: "HeaderViewCell", bundle: Bundle.main)
        let nib = UINib(nibName: "HomeViewCell", bundle: Bundle.main)
        tableView.register(nib1, forCellReuseIdentifier: "HeaderViewCell")
        tableView.register(nib, forCellReuseIdentifier: "HomeViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupUI() {
        setupView()
        setupNavigation()
        configTableView()
    }
    // MARK: - Actions for Navigation
    @objc private func profileAction() {

    }

    @objc private func notifyAction() {

    }

    @objc private func searchAction() {

    }
}
// MARK: - UICollectionView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderViewCell") as? HeaderViewCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell") as? HomeViewCell else { return UITableViewCell() }
            return cell2
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
