//
//  RxTestViewController.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/07/15.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class RxTestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        throttleLatestTest()
    }
}

private extension RxTestViewController {
    func throttleLatestTest() {
        let s = MainScheduler.instance
        let first = Observable<Int>.interval(.seconds(2), scheduler: s).take(2).map { _ in "first" }
        let second = Observable<Int>.just(0).delay(.seconds(14), scheduler: s).map { _ in "second" }

        _ = Observable.merge(first, second)
            .throttle(.seconds(10), latest: true, scheduler: s)
            .subscribe(onNext: { tag in
                print("Tag: ", tag)
            })
    }

    func concatMapTest() {
        let first = Driver.just("First")
        let second = Driver.just("Second").delay(.milliseconds(100))

        _ = Driver.merge(first, second).asObservable()
            .concatMap { tag -> Driver<(String, Int)> in
                var temp = [(String, Int)]()
                for i in 0...50000 {
                    temp.append((tag, i))
                }

                return Driver.from(temp)
            }
            .do(onNext: { print($0) })
            .asDriver(onErrorJustReturn: ("", 0))
            .drive()


        //        let a = [1...10000]
        //        let b = [10001...30000]
        //
        //        _ = Observable.merge(Observable.just(a), Observable.just(b))
        //            .concatMap { array -> Observable<Int?>  in
        //                let a =  Observable.from(array)
        //                    .map{ $0 as? Int }
        //                return a
        //            }
        //            .do(onNext: { print($0) })
        //            .subscribe()
    }
}
