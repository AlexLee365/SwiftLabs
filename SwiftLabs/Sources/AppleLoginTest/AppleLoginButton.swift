//
//  AppleLoginButton.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/05/18.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import AuthenticationServices
import RxCocoa
import RxSwift
import UIKit

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
//            let loginButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
            let loginButton = ASAuthorizationAppleIDButton(frame: .zero)
//            loginButton.backgroundColor = .blue
            loginButton.cornerRadius  = 30
            self.addSubview(loginButton)

            loginButton.snp.makeConstraints {
//                $0.center.equalToSuperview()
                $0.edges.equalToSuperview()
                $0.size.equalTo(60)
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
            print("token: ", credential.identityToken as Any)
            print("authorizationCode: ", credential.authorizationCode as Any)
            print("authorizedScopes: ", credential.authorizedScopes)
            print("realUserStatus: ", credential.realUserStatus.rawValue)
            print("state: ", credential.state as Any)
            print("user: ", credential.user)
            print("email: ", credential.email ?? "")
            print("fullName: ", credential.fullName ?? "")

            ASAuthorizationAppleIDProvider().getCredentialState(forUserID: credential.user) { (state, error) in
                print("state: ", state)
                print("state rawvalue: ", state.rawValue)
            }


            do {
//                let a = try JSONSerialization.jsonObject(with: credential.identityToken ?? Data(), options: [])
                let tokenString = String(data: credential.identityToken ?? Data(), encoding: .utf8)
                let codeString = String(data: credential.authorizationCode ?? Data(), encoding: .utf8)
                print("⭐️ tokenString: ", tokenString)
                print("⭐️ codeString: ", codeString)
//            } catch let error {
//                print("‼️ Error: ", error, " / ", error.localizedDescription)
            }
        }
    }

//    @available(iOS 13, *)
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//
//    }
}
