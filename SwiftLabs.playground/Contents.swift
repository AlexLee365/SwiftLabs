import UIKit
import Foundation

//let numberFormatter = NumberFormatter()
//numberFormatter.numberStyle = .decimal
//let price = 10005000
//let result = numberFormatter.string(from: NSNumber(value:price))
//print(result) // "10,005,000"





//let dateString = "2017-05-04 13:46:36.0"
let dateString = "safewa;lwiej 00:01 PM 00:00:02 skdjfewlaf 50:30"
//let dateString = "asdfdsaf 00:02:02"




//let a: NSTextCheckingResult.CheckingType = .regularExpression


var result = [NSTextCheckingResult]()

let pattern = "[0-9]*:[0-9]*:[0-9]*|[0-9]*:[0-9]*"
//let pattern = "[0-9]*:[0-9]*"
let regularExpression = try! NSRegularExpression(pattern: pattern, options: .allowCommentsAndWhitespace)
//let regularExpression2 = try! NSRegularExpression(pattern: "\\[0-9]*:[0-9]*:[0-9]*", options: .allowCommentsAndWhitespace)

//let result = regularExpression.matches(in: dateString, options: .anchored, range: NSMakeRange(0, dateString.count))
let test1 = regularExpression.matches(in: dateString, range: NSMakeRange(0, dateString.count))
//let test2 = regularExpression2.matches(in: dateString, options: .anchored, range: NSMakeRange(0, dateString.count))

result = test1

result.forEach {
//    print($0.range)
    print((dateString as NSString).substring(with: $0.range))
}

//print(result)


// ==================================================== ====================================================

//let pattern = "[0-9]*:[0-9]*"
//let regex = try! NSRegularExpression(pattern: pattern)
//let testString = "ㄴㅁㅇ맂더ㅑ; 2:02"
//let stringRange = NSRange(location: 0, length: testString.utf16.count)
//let matches = regex.matches(in: testString, range: stringRange)
//var result: [[String]] = []
//for match in matches {
//    var groups: [String] = []
//    for rangeIndex in 1 ..< match.numberOfRanges {
//        groups.append((testString as NSString).substring(with: match.range(at: rangeIndex)))
//    }
//    if !groups.isEmpty {
//        result.append(groups)
//    }
//}
//print(result)
