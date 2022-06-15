//
//  HomeViewController.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configTableView()
    }
    private func setupUI() {
        title = "My Music"
        /* background */
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(imageLiteralResourceName: "background.jpeg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        /* navigitionbar */
        let profileButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "profile"), style: .plain, target: self, action: #selector(profileAction))
        navigationItem.leftBarButtonItem = profileButton
        let notifyButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic-bell"), style: .plain, target: self, action: #selector(notifyAction))
        let searchBar = UIBarButtonItem(systemItem: .search)
        searchBar.action = #selector(searchAction)
        navigationItem.rightBarButtonItems = [searchBar,notifyButton]

    }
    private func configTableView() {
        let nib = UINib(nibName: "HomeViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "HomeViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    @objc private func profileAction() {

    }
    @objc private func notifyAction() {

    }
    @objc private func searchAction() {

    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Music"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell") as? HomeViewCell else { return UITableViewCell() }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}
