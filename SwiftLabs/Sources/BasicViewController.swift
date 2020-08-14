//
//  BasicViewController.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/05/27.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//
import RxCocoa
import RxSwift
import UIKit

class BasicViewController: UIViewController {
    private weak var label: UILabel!
    private weak var textFieldself: UITextField!

    private let textSubject =  PublishSubject<String?>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

//        textFieldDecimalTest()
        textFieldWithLabelTest()

    }
}



extension BasicViewController: UITextFieldDelegate {
    func textFieldWithLabelTest() {
        let textField = CustomTextField()
//        textField.delegate = self
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.textColor = .clear
//        textField.textColor = .init(white: 0, alpha: 0.2)
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
        textField.font = .systemFont(ofSize: 15, weight: .bold)
        self.textFieldself = textField

        view.addSubview(textField)

        textField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(100)
        }

        let outputLabel = UILabel()
        outputLabel.textAlignment = .center
        outputLabel.isUserInteractionEnabled = false
        outputLabel.textColor = .black
        outputLabel.font = .systemFont(ofSize: 15, weight: .bold)
        self.label = outputLabel
        view.addSubview(outputLabel)

        outputLabel.snp.makeConstraints {
//            $0.edges.equalTo(textField)
            $0.center.equalTo(textField)
//            $0.width.equalTo(textField)
        }

//        _ = textField.rx.controlEvent(.editingChanged)
//            .map { [weak self] _ -> String? in
//                guard let text = textField.text, !text.isEmpty else { return nil }
//
//                return text + "원"
//            }
//            .subscribe(outputLabel.rx.text)



        let textSub = textSubject
            .do(onNext: { [weak self] in
                textField.text = $0
            })

//            .do(onNext: [] )
        _ = Observable.merge(textField.rx.text.asObservable(), textSub)
//        _ = textField.rx.text
            .map { text -> String? in
                guard let text = text, !text.isEmpty else { return nil }

                return text + "원"

//                let formatter = NumberFormatter()
//                formatter.numberStyle = .decimal // 1,000,000
//                formatter.locale = Locale.current
//                formatter.maximumFractionDigits = 0 // 허용하는 소숫점 자리수
//
//                return (formatter.string(from: NSNumber(value: Int(text) ?? 0)) ?? "") + "원"

            }
            .subscribe(outputLabel.rx.text)
    }

    func textFieldDecimalTest() {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.textAlignment = .center
        view.addSubview(textField)

        textField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(100)
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // 1,000,000
//        formatter.locale = Locale.current
//        formatter.maximumFractionDigits = 0 // 허용하는 소숫점 자리수


        if let stringRemovedSeprator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: "") {
            var onlyNumberString = stringRemovedSeprator + string

            if formatter.number(from: string) != nil {  // 숫자인지 검사
                if let formattedNumber = formatter.number(from: onlyNumberString), let formattedString = formatter.string(from: formattedNumber){
                    textSubject.onNext(formattedString)

//                    textField.text = formattedString
//                    self.textFieldself.text = formattedString
//                    label.text = formattedString + "원"

                    print("textField text:", formattedString)

                    return false
                }
            } else { // 숫자가 아닐 때
                if string == "" { // 백스페이스일때
                    print("delete")
                    let lastIndex = onlyNumberString.index(onlyNumberString.endIndex, offsetBy: -1)
                    onlyNumberString = String(onlyNumberString[..<lastIndex])
                    if let formattedNumber = formatter.number(from: onlyNumberString), let formattedString = formatter.string(from: formattedNumber){
                        textSubject.onNext(formattedString)

//                        textField.text = formattedString
//                        self.textFieldself.text = formattedString
//                        label.text = formattedString + "원"

                        return false
                    }
                }else{ // 문자일 때
                    return false
                }
            }

        }

//        label.text = nil
        return true
    }

}



// ==================================================== ====================================================
//class CurrencyField: UITextField {
//    var decimal: Decimal { string.decimal / pow(10, Formatter.currency.maximumFractionDigits) }
//    var maximum: Decimal = 999_999_999.99
//    private var lastValue: String?
//    var locale: Locale = .current {
//        didSet {
//            Formatter.currency.locale = locale
//            sendActions(for: .editingChanged)
//        }
//    }
//    override func willMove(toSuperview newSuperview: UIView?) {
//        // you can make it a fixed locale currency if needed
//        // self.locale = Locale(identifier: "pt_BR") // or "en_US", "fr_FR", etc
//        Formatter.currency.locale = locale
//        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
//        keyboardType = .numberPad
//        textAlignment = .right
//        sendActions(for: .editingChanged)
//    }
//    override func deleteBackward() {
//        text = string.digits.dropLast().string
//        // manually send the editingChanged event
//        sendActions(for: .editingChanged)
//    }
//    @objc func editingChanged() {
//        guard decimal <= maximum else {
//            text = lastValue
//            return
//        }
//        text = decimal.currency
//        lastValue = text
//    }
//}

//
//extension String {
//
//    // formatting text for currency textField
//    func currencyInputFormatting() -> String {
//
//        var number: NSNumber!
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currencyAccounting
//        formatter.currencySymbol = "원"
////        formatter.symbol
//
//        formatter.maximumFractionDigits = 2
//        formatter.minimumFractionDigits = 2
//
//        var amountWithPrefix = self
//
//        // remove from String: "$", ".", ","
//        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
//        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
//
//        let double = (amountWithPrefix as NSString).doubleValue
//        number = NSNumber(value: (double / 100))
//
//        // if first number is 0 or all numbers were deleted
//        guard number != 0 as NSNumber else {
//            return ""
//        }
//
//        return formatter.string(from: number)!
//    }
//}


class CustomTextField: UITextField {
//    let font
//    let insetX: CGFloat = "원".
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        guard text?.isEmpty == false else { return bounds }

        return bounds.inset(by: UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 0))
    }
}
