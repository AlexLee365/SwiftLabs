//
//  SharedSequence+.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/04/29.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import RxCocoa
import RxSwift

extension SharedSequenceConvertibleType {
    func g_unwrap<T>() -> SharedSequence<SharingStrategy, T> where Element == T? {
        return filter { $0 != nil }.map { $0! }
    }

    func g_wrap<T>() -> SharedSequence<SharingStrategy, T?> where Element == T {
        return map { $0 as T? }
    }

    /// 이전 값을 함께 주는 operator, 따라서 두번째 이벤트부터 시작됨
    func g_withPrevious() -> SharedSequence<SharingStrategy, (Element, Element)> {
        return self
            .scan([]) { array, newElement in
                return (array + [newElement]).suffix(2)
            }
            .filter { $0.count == 2 }
            .map { ($0[0], $0[1]) }
    }

    /// pauser가 true일때만 이벤트를 통과시키는 operator
    func g_pausable<P: SharedSequenceConvertibleType> (_ pauser: P) -> SharedSequence<SharingStrategy, Element> where P.SharingStrategy == SharingStrategy, P.Element == Bool {
        return withLatestFrom(pauser) { element, paused in
            return (element, paused)
        }
        .filter { _, paused in paused }
        .map { element, _ in element }
    }
}

