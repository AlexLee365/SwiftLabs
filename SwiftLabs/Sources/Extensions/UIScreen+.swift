//
//  UIScreen+.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/04/29.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import UIKit

extension UIScreen {
    static var width: CGFloat {
        return self.main.bounds.width
    }

    static var height: CGFloat {
        return self.main.bounds.height
    }
}
