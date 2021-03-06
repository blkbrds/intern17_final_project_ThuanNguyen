//
//  HomeViewCell.swift
//  FinalProject
//
//  Created by thuan.nguyen on 15/06/2022.
//

import UIKit
protocol homeCellDelegate: AnyObject {
    func cell(cell: HomeViewCell, needsPerform action: HomeViewCell.Action)

}

final class HomeViewCell: UITableViewCell {

    var viewModel: HomeCellViewModel? {
        didSet {
            updateHeaderView()
            updateData()
        }
    }

    // MARK: - Protocol
    var delegate: homeCellDelegate?
    enum Action {
        case detail(data: Item?)
    }

    // MARK: Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seeButton: UIButton!

    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - private funtions
    private func configCollectionView() {
        let headerNib = UINib(nibName: "HeaderCollectionView", bundle: Bundle.main)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionView")
        let nib = UINib(nibName: "CustomHomeViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "CustomHomeViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func updateHeaderView() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.nameHeader
    }

    func updateData() {
        guard let viewModel = viewModel else { return }
        viewModel.items
        self.collectionView.reloadData()
    }
}
// MARK: - UICollectionView
extension HomeViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.items?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomHomeViewCell", for: indexPath) as? CustomHomeViewCell else { return UICollectionViewCell() }
        cell.contentModel = viewModel?.contentViewForViewCell(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewModel = viewModel {
            delegate?.cell(cell: self, needsPerform: .detail(data: viewModel.items?[indexPath.row]))
        }
        print("=========\(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}
