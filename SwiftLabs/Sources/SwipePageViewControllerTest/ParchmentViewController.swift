//
//  ParchmentViewController.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/04/29.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import Parchment
import UIKit

protocol PageControlProtocol: UIViewController {
    var pageTableView: UITableView { get }
    var isHeaderViewFixed: Bool { get set }
}

extension PageControlProtocol {
    func linkDestinationsPage(withStartPageOffsetY offsetY: CGFloat, startPageHeaderFixed: Bool) {
        print("---------------------------[]---------------------------")
        print("destination's content y: ", self.pageTableView.contentOffset.y)

        if !startPageHeaderFixed {
            print("헤더가 조정되고있으므로 현재 포인트로 통일시킵니다.")
            let offset = min(-50, offsetY)
            self.pageTableView.contentOffset.y = offset
            self.isHeaderViewFixed = false

        } else if self.isHeaderViewFixed != startPageHeaderFixed {
            print("헤더가 고정된 상태인데, 다음 테이블뷰는 고정되지않았으므로 고정된 포인트로 통일시킵니다.")
            let offset = min(-50, offsetY)
            self.pageTableView.contentOffset.y = offset
            self.isHeaderViewFixed = true
        }

        print("destination isHeaderViewSet: ", self.isHeaderViewFixed)
    }
}

class ParchmentViewController: UIViewController {
    let array: [PageControlProtocol] = [TableViewController(), TableViewController(), TableViewController()]
    private weak var pagingViewController: CustomPagingViewController!

    var currentIndex = 0
    var currentYOffset: CGFloat = -350
    var isHeaderViewSet = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setTableVC()
    }

    private func setupViews() {
        self.title = "취미로 방송함"
        view.backgroundColor = .black

        let pagingViewController = CustomPagingViewController()
        pagingViewController.delegate = self
        pagingViewController.dataSource = self
        pagingViewController.menuItemSize = PagingMenuItemSize.fixed(width: UIScreen.width / 3, height: 50)
        pagingViewController.indicatorOptions = .visible(height: 2, zIndex: 0,
                                                         spacing: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
                                                         insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        pagingViewController.borderOptions = .visible(height: 1, zIndex: 0, insets: UIEdgeInsets(top: 0, left: 0, bottom: 1.5, right: 0))
        pagingViewController.borderColor = UIColor.lightGray.withAlphaComponent(0.3)
        pagingViewController.indicatorColor = .systemPink
        pagingViewController.menuBackgroundColor = .black
        pagingViewController.textColor = .white
        pagingViewController.selectedTextColor = .systemPink

        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)

        pagingViewController.view.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(0)
        }

        self.pagingViewController = pagingViewController
    }

    private func setTableVC() {
        let height = pagingViewController.options.menuHeight + CustomPagingView.HeaderHeight
        print("⭐️ height: ", height)
        let insets = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        array.forEach {
            $0.pageTableView.contentInset = insets
            $0.pageTableView.scrollIndicatorInsets = insets
            $0.pageTableView.delegate = self

        }
    }
}

extension ParchmentViewController: PagingViewControllerDataSource {
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return array.count
    }

    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        return array[index]
    }

    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        return PagingIndexItem(index: index, title: "Title \(index)")
    }
}

extension ParchmentViewController: PagingViewControllerDelegate {
    func pagingViewController(_ pagingViewController: PagingViewController, didScrollToItem pagingItem: PagingItem, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
        currentIndex = pagingViewController.visibleItems.indexPath(for: pagingItem)?.row ?? 0
        print("current Index: ", currentIndex)

    }

    func pagingViewController(_: PagingViewController, willScrollToItem pagingItem: PagingItem, startingViewController: UIViewController, destinationViewController: UIViewController) {
        guard let startingViewController = startingViewController as? PageControlProtocol,
              let destinationViewController = destinationViewController as? PageControlProtocol else {
                return
        }

        destinationViewController.linkDestinationsPage(withStartPageOffsetY: currentYOffset,
                                                       startPageHeaderFixed: startingViewController.isHeaderViewFixed)

//        print("---------------------------[]---------------------------")
//        print("destination's content y: ", destinationViewController.pageTableView.contentOffset.y)
//
//        if !startingViewController.isHeaderViewFixed {
//            print("헤더가 조정되고있으므로 현재 포인트로 통일시킵니다.")
//            let offset = min(-50, currentYOffset)
//            destinationViewController.pageTableView.contentOffset.y = offset
//            destinationViewController.isHeaderViewFixed = false
//
//        } else if destinationViewController.isHeaderViewFixed != startingViewController.isHeaderViewFixed {
//            print("헤더가 고정된 상태인데, 다음 테이블뷰는 고정되지않았으므로 고정된 포인트로 통일시킵니다.")
//            let offset = min(-50, currentYOffset)
//            destinationViewController.pageTableView.contentOffset.y = offset
//            destinationViewController.isHeaderViewFixed = true
//        }
//
//        print("destination isHeaderViewSet: ", destinationViewController.isHeaderViewFixed)
//    }
    }
}

extension ParchmentViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -50 {
            array[currentIndex].isHeaderViewFixed = false
        } else {
            array[currentIndex].isHeaderViewFixed = true
        }

        guard scrollView.contentOffset.y < 0 else {
            return
        }

        print("⭐️ offset: ", scrollView.contentOffset.y)

        if let customPageView = pagingViewController.view as? CustomPagingView {
            let topInset = pagingViewController.options.menuHeight + CustomPagingView.HeaderHeight
            let headerViewOffset = -min(CustomPagingView.HeaderHeight, scrollView.contentOffset.y + topInset)
            currentYOffset = scrollView.contentOffset.y

            print("topInset: ", topInset)
            print("headerViewOffset: ", headerViewOffset)

            customPageView.headerViewTopConstraint.update(offset: headerViewOffset)
        }
    }
}
