import UIKit
//import RxCocoa
//import RxSwift
//import SnapKit
//
//Observable<Int>
//    .interval(.milliseconds(500), scheduler: MainScheduler.instance)
//    .take(10)
//    .throttle(.seconds(2), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print("", $0)
//    })
//
//
//
//

var a = [Int]()




extension Array {
    subscript(g_safe index: Int) -> Element? {
        get {
            return indices ~= index ? self[index] : nil
        }
        set {
            guard let newValue = newValue, indices ~= index else { return }

            self[index] = newValue
        }
    }

    func g_last(_ count: Int) -> [Element] {
        return ((self.count - count)..<self.count).compactMap { self[g_safe: $0] }
    }
}


let result = a.g_last(3)

print(result)



struct Test {
    var index: Int
}


let b: [Test] = (0...10).map { Test(index: $0) }.shuffled()

print("b: ", b)

let max = b.max { $0.index < $1.index }

print("max: ", max)


