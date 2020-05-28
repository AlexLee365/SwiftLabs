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
    override func viewDidLoad() {
        super.viewDidLoad()

        let first = Driver.just("First")
        let second = Driver.just("Second").delay(.milliseconds(100))

        _ = Driver.merge(first, second).asObservable()
//            .flatMapLatest { tag -> Driver<(String, Int)> in
            .concatMap { tag -> Driver<(String, Int)> in
                var temp = [(String, Int)]()
                for i in 0...30000 {
                    temp.append((tag, i))
                }

                return Driver.from(temp)
//                return Driver.just(temp)
            }
            .do(onNext: { print($0) })
            .asDriver(onErrorJustReturn: ("", 0))
            .drive()

    }
}
