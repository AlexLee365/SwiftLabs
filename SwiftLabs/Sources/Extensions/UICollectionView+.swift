//
//  UICollectionView+.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/04/29.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import UIKit

extension UICollectionView {
    func g_registerCellNib(cellType: UICollectionViewCell.Type) {
        let cellName = "\(cellType)"
        register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
    }

    func g_registerCellClass(cellType: UICollectionViewCell.Type) {
        register(cellType, forCellWithReuseIdentifier: "\(cellType)")
    }

    func g_registerHeaderClass(viewType: UICollectionReusableView.Type) {
        register(viewType, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(viewType)")
    }

    func g_registerFooterClass(viewType: UICollectionReusableView.Type) {
        register(viewType, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(viewType)")
    }

    func g_dequeueReusableCell<T: UICollectionViewCell>(cellType: T.Type = T.self, reuseIdentifier: String? = nil, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: reuseIdentifier ?? "\(cellType)", for: indexPath) as! T
    }

    func g_dequeueHeader<T: UICollectionReusableView>(viewType: T.Type = T.self, indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(viewType)", for: indexPath) as! T
    }

    func g_dequeueFooter<T: UICollectionReusableView>(viewType: T.Type = T.self, indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(viewType)", for: indexPath) as! T
    }
}

