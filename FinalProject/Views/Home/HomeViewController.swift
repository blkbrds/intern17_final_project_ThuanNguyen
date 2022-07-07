//
//  HomeViewController.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import UIKit
final class HomeViewController: UIViewController {

    // MARK: - properties
    private var viewModel = HomeViewModel()
    private var timer = Timer()
    private var counter = 0
    private let numberOfImageHeader: Int = 6

    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageView: UIPageControl!
    @IBOutlet private weak var headerView: UIView!

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - private functions
    private func setupView() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(imageLiteralResourceName: "background.jpeg")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        }

    private func setupPageControl() {
        pageView.numberOfPages = numberOfImageHeader
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }

    private func setupNavigation() {
        title = "My Music"
        let profileButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "profile"), style: .plain, target: self, action: #selector(profileAction))
        navigationItem.leftBarButtonItem = profileButton
        let notifyButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic-bell"), style: .plain, target: self, action: #selector(notifyAction))
        let searchBar = UIBarButtonItem(systemItem: .search)
        searchBar.action = #selector(searchAction)
        navigationItem.rightBarButtonItems = [searchBar, notifyButton]
    }

    private func configTableView() {
        let nib = UINib(nibName: "HomeViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "HomeViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func configCollectionView() {
        let headerNib = UINib(nibName: "CustomHeaderView", bundle: .main)
        collectionView.register(headerNib, forCellWithReuseIdentifier: "CustomHeaderView")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func setupUI() {
        setupView()
        setupNavigation()
        configTableView()
        configCollectionView()
        loadAPIPlayListTrack()
    }

    // MARK: funtion loadAPI in PlayList Track
    private func loadAPIPlayListTrack() {
        viewModel.requestAPIInPlayListTrack { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.setupPageControl()
                this.tableView.reloadData()
                this.collectionView.reloadData()
            case .failure(let error):
                this.alert(title: "", message: error.localizedDescription)
            }
        }
    }

    // MARK: - Actions for Navigation
    @objc private func profileAction() {

    }

    @objc private func notifyAction() {

    }

    @objc private func searchAction() {

    }

    @objc private func changeImage() {
        if counter < numberOfImageHeader {
            let index = IndexPath(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
    }
}
// MARK: - UITableView Data Source
extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SectionType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell") as? HomeViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.contentModelForViewItem(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK: - UITableView Delegate
extension HomeViewController: UITableViewDelegate {

}

// MARK: UICollectionView
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.imageList.count == 0 {
            return 0
        } else {
            return Config.pickItems
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomHeaderView", for: indexPath) as? CustomHeaderView else { return UICollectionViewCell() }
        cell.headerModel = viewModel.viewModelForHeaderViewItem(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension HomeViewController {
    struct Config {
        static let pickItems: Int = 6
    }
}


