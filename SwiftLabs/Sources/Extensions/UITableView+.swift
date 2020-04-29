//
//  UITableView+.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/04/29.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import UIKit

extension UITableView {
    func g_registerCellNib(cellType: UITableViewCell.Type) {
        let cellName = "\(cellType)"
        register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }

    func g_registerCellClass(cellType: UITableViewCell.Type) {
        register(cellType, forCellReuseIdentifier: "\(cellType)")
    }

    func g_registerHeaderFooterNib(headerFooterType: UITableViewHeaderFooterView.Type) {
        let headerFooterName = "\(headerFooterType)"
        register(UINib(nibName: headerFooterName, bundle: nil), forCellReuseIdentifier: headerFooterName)
    }

    func g_registerHeaderFooterClass(headerFooterType: UITableViewHeaderFooterView.Type) {
        register(headerFooterType, forHeaderFooterViewReuseIdentifier: "\(headerFooterType)")
    }

    func g_dequeueReusableCell<T: UITableViewCell>(cellType: T.Type = T.self, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(cellType)", for: indexPath) as! T
    }

    func g_dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(headerFooterType: T.Type = T.self) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: "\(headerFooterType)") as! T
    }
}

public extension IndexPath {
    static func g_makeList(indexFrom from: Int, to: Int, inSection: Int = 0) -> [Self] {
        guard from >= 0, to >= 0, from <= to else { return [] }

        return (from...to).map { IndexPath(row: $0, section: inSection) }
    }
}
