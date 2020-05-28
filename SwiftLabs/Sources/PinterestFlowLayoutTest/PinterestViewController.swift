//
//  PinterestViewController.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/05/18.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
}

class PinterestViewController: UIViewController {

    private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayoutConstraints()
    }

    private func setupViews() {
//        let flowLayout = UICollectionViewFlowLayout()
        let flowLayout = PinterestLayout()
//        flowLayout.minimumInteritemSpacing = 0
//        flowLayout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.g_registerCellClass(cellType: PinterestCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }

    private func setupLayoutConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PinterestViewController: UICollectionViewDelegate {

}

extension PinterestViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.width / 2, height: 150)
//    }
}

extension PinterestViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.g_dequeueReusableCell(cellType: PinterestCollectionViewCell.self, indexPath: indexPath)

        return cell
    }


}
