import UIKit



// ==================================================== ====================================================

struct TimerCoupon: CustomStringConvertible {
    var a: Int
    var b: Int

    var description: String {
        return "TimerCoupon A: \(a) / B: \(b)"
    }
}

extension Array where Element == TimerCoupon {
    func g_verifyTimerCouponArray() -> [TimerCoupon] {
//        var verifiedArray = [TimerCoupon]()
//        let sortedArray = self.sorted { $0.absoluteTimeFromEntrance < $1.absoluteTimeFromEntrance }

//        var priorCoupon: TimerCoupon?
//        for coupon in sortedArray {
//            if priorCoupon?.absoluteTimeFromEntrance != coupon.absoluteTimeFromEntrance {
//                verifiedArray.append(coupon)
//            }
//
//            priorCoupon = coupon
//        }

        let duplicatesRemovedArray = self.reduce(into: [Element]()) { result, next in
            let notDuplicated = !result.contains { timerCoupon -> Bool in
                return next.a == timerCoupon.a || next.b == timerCoupon.b
            }

            if notDuplicated {
                result.append(next)
            }
        }

        return duplicatesRemovedArray.sorted { $0.a < $1.a }
    }
}

let testArray = [TimerCoupon(a: 1, b: 3),
                 TimerCoupon(a: 1, b: 3),
                 TimerCoupon(a: 2, b: 3),
                 TimerCoupon(a: 3, b: 1),
                 TimerCoupon(a: 1, b: 1),
                 TimerCoupon(a: 3, b: 1),
                 TimerCoupon(a: 4, b: 3),
                 TimerCoupon(a: 2, b: 1),
                 TimerCoupon(a: 1, b: 3),
                 TimerCoupon(a: 1, b: 2),
                 TimerCoupon(a: 1, b: 1),]

let r = testArray.g_verifyTimerCouponArray()

//print(r)


// ==================================================== ====================================================


func solution(_ key:[[Int]], _ lock:[[Int]]) -> Bool {
    var keyMap = key

    for _ in 0..<4 {
        if check(keyMap, lock) {
            return true
        }

        keyMap = rotate(keyMap)
    }

    return false
}

// 회전한 배열을 반환
func rotate(_ key:[[Int]]) -> [[Int]] {
    var temp = [[Int]](repeating: [Int](repeating: 0, count: key.count), count: key.count)

    for i in 0..<key.count {
        for j in 0..<key.count {
            temp[i][j] = key[key.count - j - 1][i]
        }
    }

    return temp
}
// 동, 서, 남, 북 으로 한칸씩 밀어낸 배열을 반환
func move(_ key: [[Int]], _ N: Int, _ row: Int, col: Int) -> [[Int]] {
    var temp = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)

    for i in 0..<key.count {
        for j in 0..<key.count where i + row >= 0 && i + row < N && j + col >= 0 && j + col < N {
            temp[i + row][j + col] = key[i][j]
        }
    }
    return temp
}

func isUnlock(_ key: [[Int]], _ lock: [[Int]]) -> Bool {
    for i in 0..<lock.count {
        for j in 0..<lock.count where key[i][j]^lock[i][j] == 0 {
            return false
        }
    }
    return true
}

func check(_ key: [[Int]], _ lock: [[Int]]) -> Bool {

    for i in 1-key.count..<lock.count {
        for j in 1-key.count..<lock.count {
            let moveMap = move(key, lock.count, i, col: j)
            if isUnlock(moveMap, lock) { return true }
        }
    }

    return false
}


let key = [[0, 0, 0], [1, 0, 0], [0, 1, 1]]
let lock = [[1, 1, 1], [1, 1, 0], [1, 0, 1]]

let result = solution(key, lock)

print(result)


let a = 3^4

print(a)
