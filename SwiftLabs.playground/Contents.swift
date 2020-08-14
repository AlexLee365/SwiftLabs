import UIKit


let numberFormatter = NumberFormatter()
numberFormatter.numberStyle = .decimal
let price = 10005000
let result = numberFormatter.string(from: NSNumber(value:price))
print(result) // "10,005,000"


