//
//  PinterestCollectionViewCell.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/05/18.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import UIKit

class PinterestCollectionViewCell: UICollectionViewCell {
    private weak var randomColorView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        let randomColorView = UIView()
        randomColorView.backgroundColor = UIColor.g_random
        contentView.addSubview(randomColorView)
        self.randomColorView = randomColorView

        randomColorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
