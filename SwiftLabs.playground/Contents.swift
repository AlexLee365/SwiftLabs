import UIKit
import RxCocoa
import RxSwift
import SnapKit

Observable<Int>
    .interval(.milliseconds(500), scheduler: MainScheduler.instance)
    .take(10)
    .throttle(.seconds(2), scheduler: MainScheduler.instance)
    .subscribe(onNext: {
        print("", $0)
    })




