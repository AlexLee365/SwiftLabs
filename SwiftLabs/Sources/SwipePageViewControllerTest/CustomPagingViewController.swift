//
//  CustomPagingViewController.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/04/29.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import SnapKit
import Parchment
import UIKit

class CustomPagingViewController: PagingViewController {
    override func loadView() {
        view = CustomPagingView(options: options,
                                collectionView: collectionView,
                                pageView: pageViewController.view)
    }
}

class CustomPagingView: PagingView {
    static let HeaderHeight: CGFloat = 300

    var headerHeightConstraint: NSLayoutConstraint?
    weak var headerViewTopConstraint: Constraint!

    lazy var headerView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "headerSample"))
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .brown
        return view
    }()

    override func setupConstraints() {
        addSubview(headerView)

        collectionView.isScrollEnabled = false
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self)
            $0.height.equalTo(options.menuHeight)
            $0.top.equalTo(headerView.snp.bottom)
        }

        headerView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self)
            $0.height.equalTo(type(of: self).HeaderHeight)
            self.headerViewTopConstraint = $0.top.equalTo(self).constraint
        }

//        headerView.addGestureRecognizer(tapGesture)

        pageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
}
