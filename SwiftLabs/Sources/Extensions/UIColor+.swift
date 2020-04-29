//
//  UIColor+.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/04/29.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(_ red: Int, _ green: Int, _ blue: Int) {
        self.init(red, green, blue, 1)
    }

    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }

    static var g_random: UIColor {
        return UIColor(Int.random(in: 0...255), Int.random(in: 0...255), Int.random(in: 0...255))
    }
}
