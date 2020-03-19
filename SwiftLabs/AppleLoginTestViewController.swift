//
//  AppleLoginTestViewController.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/03/18.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import AuthenticationServices
import RxCocoa
import RxSwift
import UIKit

class AppleLoginTestViewController: UIViewController {

    private weak var loginButton: AppleLoginButton!

    private var disposeBag = DisposeBag()

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
            $0.width.equalTo(200)
            $0.height.equalTo(140)
        }
    }
}

class AppleLoginButton: UIButton {

    private var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setAppleLoginButton()

        self.rx.tap
            .subscribe(onNext: {
                print("기존 버튼 Working")
            })
            .disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setAppleLoginButton() {
        if #available(iOS 13, *) {
            let loginButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
            loginButton.cornerRadius  = 70
            self.addSubview(loginButton)

            loginButton.snp.makeConstraints {
                $0.center.equalToSuperview()
            }

            loginButton.rx.controlEvent(.touchUpInside)
                .subscribe(onNext: {
                    print("⭐️ loginButton Working ")
                    let request = ASAuthorizationAppleIDProvider().createRequest()
                    request.requestedScopes = [.fullName, .email]

                    let controller = ASAuthorizationController(authorizationRequests: [request])
                    controller.delegate = self
                    controller.presentationContextProvider = nil
                    controller.performRequests()
                })
                .disposed(by: disposeBag)
        } else {

        }
    }
}

extension AppleLoginButton: ASAuthorizationControllerDelegate {

    @available(iOS 13, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("‼️ Error: ", error, " / desc: ", error.localizedDescription)
    }

    @available(iOS 13, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            print("---------------------------[Success]---------------------------")
            print("credential : ", credential)
            print("token: ", credential.identityToken)
            print("authorizationCode: ", credential.authorizationCode)
            print("authorizedScopes: ", credential.authorizedScopes)
            print("realUserStatus: ", credential.realUserStatus.rawValue)
            print("state: ", credential.state)
            print("user: ", credential.user)
            print("email: ", credential.email ?? "")
        }
    }

//    @available(iOS 13, *)
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//
//    }


}
