//
//  BasicTableViewController.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/04/29.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, PageControlProtocol {
    private static let CellIdentifier = "CellIdentifier"

    lazy var pageTableView: UITableView = tableView
    var isHeaderViewFixed = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TableViewController.CellIdentifier)
        tableView.separatorColor = .lightGray
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 80
        tableView.indicatorStyle = .white

        print("🔸🔸🔸 viewDidLoad: ")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewController.CellIdentifier, for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = "Content \(indexPath.row)"
        cell.textLabel?.textColor = .white

        return cell
    }

}

// =================================== ===================================
//class AViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .black
//    }
//}
//
//class BViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .black
//    }
//}
//
//class CViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .black
//    }
//}
