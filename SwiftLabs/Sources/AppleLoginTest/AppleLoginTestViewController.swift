//
//  AppleLoginTestViewController.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/03/18.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import UIKit

class AppleLoginTestViewController: UIViewController {
    private weak var loginButton: AppleLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayoutConstraints()
    }

    private func setupViews() {
        view.backgroundColor = .white

        let loginButton = AppleLoginButton()
        loginButton.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        view.addSubview(loginButton)
        self.loginButton = loginButton
    }

    private func setupLayoutConstraints() {
        loginButton.snp.makeConstraints {
            $0.center.equalToSuperview()
//            $0.width.equalTo(200)
//            $0.height.equalTo(140)
        }
    }
}
