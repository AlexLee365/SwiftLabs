//
//  ProgressViewTestViewController.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/03/18.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import UIKit

class ProgressViewTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let slider = UISlider()
//        let filledImage = UIImage.g_roundRect(fillColor: .red,
//                                              fillShadowColor: nil,
//                                              size: CGSize(width: 20, height: 10),
//                                              byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
//                                              radius: 5,
//                                              borderColor: nil,
//                                              borderShadowColor: nil,
//                                              lineWidth: 0,
//                                              resizable: true)
//
//        let defaultImage = UIImage.g_roundRect(fillColor: .lightGray,
//                                               fillShadowColor: nil,
//                                               size: CGSize(width: 20, height: 10),
//                                               byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
//                                               radius: 5,
//                                               borderColor: nil,
//                                               borderShadowColor: nil,
//                                               lineWidth: 0,
//                                               resizable: true)
//
//        slider.setThumbImage(UIImage(), for: .normal)
//        slider.setMinimumTrackImage(filledImage, for: .normal)
//        slider.setMaximumTrackImage(defaultImage, for: .normal)
//        slider.setValue(0.4, animated: true)
//
//        view.addSubview(slider)
//
//        slider.snp.makeConstraints {
//            $0.center.equalToSuperview()
//            $0.width.equalToSuperview().multipliedBy(0.8)
//            $0.height.equalTo(50)
//        }

        let progressView = UIProgressView()
        let progressHeight: CGFloat = 8
        progressView.progressImage = UIImage.g_roundRect(fillColor: .red,
                                                         fillShadowColor: nil,
                                                         size: CGSize(width: 12, height: progressHeight),
                                                         byRoundingCorners: [.allCorners],
                                                         radius: 5,
                                                         borderColor: nil,
                                                         borderShadowColor: nil,
                                                         lineWidth: 0,
                                                         resizable: true)

        progressView.trackImage = UIImage.g_roundRect(fillColor: .lightGray,
                                                      fillShadowColor: nil,
                                                      size: CGSize(width: 12, height: progressHeight),
                                                      byRoundingCorners: [.allCorners],
                                                      radius: 5,
                                                      borderColor: nil,
                                                      borderShadowColor: nil,
                                                      lineWidth: 0,
                                                      resizable: true)
        progressView.progress = 10
        view.addSubview(progressView)

        progressView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(progressHeight)
        }
    }
}


extension UIImage {
    static func g_roundRect(fillColor: UIColor? = nil, fillShadowColor: UIColor? = nil, size: CGSize, byRoundingCorners: UIRectCorner = .allCorners,
                            radius: CGFloat, borderColor: UIColor? = nil, borderShadowColor: UIColor? = nil, lineWidth: CGFloat = 0, resizable: Bool = false) -> UIImage {
        let sizeWithShadow = fillShadowColor == nil && borderShadowColor == nil ? size : CGSize(width: size.width, height: size.height + 2)
        UIGraphicsBeginImageContextWithOptions(sizeWithShadow, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }

        let rect = CGRect(origin: CGPoint(x: lineWidth / 2, y: lineWidth / 2), size: CGSize(width: size.width - lineWidth, height: size.height - lineWidth))
        let borderPath = UIBezierPath(roundedRect: rect, byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

        if let fillColor = fillColor {
            context.addPath(borderPath)
            context.setFillColor(fillColor.cgColor)
            context.setShadow(offset: CGSize(width: 0, height: 0.5), blur: 1, color: fillShadowColor?.cgColor)
            context.fillPath()
        }

        if let borderColor = borderColor {
            context.addPath(borderPath)
            context.setStrokeColor(borderColor.cgColor)
            context.setLineWidth(lineWidth)
            context.setShadow(offset: CGSize(width: 0, height: 0.5), blur: 1, color: borderShadowColor?.cgColor)
            context.strokePath()
        }

        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        if resizable {
            let horizontalInset = (size.width <= radius * 2) ? 0 : round(size.width / 2) - 1
            let verticalInset = (size.height <= radius * 2) ? 0 : round(size.height / 2) - 1
            let edgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
            return image.resizableImage(withCapInsets: edgeInsets)
        }

        return image
    }
}
