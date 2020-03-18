//
//  GlowingAnimationTestViewController.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/03/18.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import CoreGraphics
import SnapKit
import UIKit

class GlowingAnimationTestViewController: UIViewController {
    let squareView = MyView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(squareView)
        squareView.backgroundColor = UIColor.red
        squareView.snp.makeConstraints {
            //            $0.center.equalToSuperview()
            $0.leading.equalTo(50)
            $0.top.equalTo(100)
            $0.size.equalTo(100)
        }

//        centerView.doGlowAnimation(withColor: .red)

//        centerView.doGlowAnimation(withColor: .red, withEffect: .big)
//        UIView.animate(withDuration: 2, delay: 0, options: [.repeat], animations: {
//            self.centerView.doGlowAnimation(withColor: .white)
//        }) { (_) in
//
//        }
//        squareView.moveWithPath()
        let tap = UITapGestureRecognizer()
        squareView.addGestureRecognizer(tap)
        squareView.isUserInteractionEnabled = true
        tap.addTarget(self, action: #selector(tapAction))
    }

    let progress: CGFloat = 0.44

    @objc func tapAction() {
        squareView.g_animationGlowing(withColor: .red, withEffect: .big, duration: 1, forceProgress: progress)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.squareView.g_animationGlowing(withColor: .red, withEffect: .big, duration: 1, forceProgress: self.progress)
        }
    }


}


extension UIView {
    enum GlowEffect: Float {
        case small = 0.4, normal = 2, big = 15
    }

    func doGlowAnimation(withColor color: UIColor, withEffect effect: GlowEffect = .normal) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero

        let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        glowAnimation.fromValue = 0
        glowAnimation.toValue = effect.rawValue
        glowAnimation.beginTime = CACurrentMediaTime()
        glowAnimation.duration = CFTimeInterval(1)
        glowAnimation.fillMode = .removed
        glowAnimation.autoreverses = true
        glowAnimation.repeatCount = 1
        layer.add(glowAnimation, forKey: "shadowGlowingAnimation")
    }

    func g_animationGlowing(withColor color: UIColor = .white,
                            withEffect effect: GlowEffect = .normal,
                            duration: Double = 1,
                            forceProgress: CGFloat) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero

        if forceProgress < 0.5 {
            layer.shadowRadius = 0

            let firstPlayDuration = duration - duration * Double(forceProgress)
            let fromValue = CGFloat(effect.rawValue) * forceProgress
            let toValue = effect.rawValue

            let firstGlowAnimation = CABasicAnimation(keyPath: "shadowRadius")
            firstGlowAnimation.fromValue = fromValue
            firstGlowAnimation.toValue = toValue
            firstGlowAnimation.beginTime = CACurrentMediaTime()
            firstGlowAnimation.duration = CFTimeInterval(firstPlayDuration)
            firstGlowAnimation.fillMode = .forwards
            firstGlowAnimation.autoreverses = false
            firstGlowAnimation.isRemovedOnCompletion = false

            layer.add(firstGlowAnimation, forKey: "firstGlowAnimation")

            DispatchQueue.main.asyncAfter(deadline: .now() + firstPlayDuration) { [weak self] in
                self?.layer.shadowRadius = CGFloat(effect.rawValue)

                let secondGlowAnimation = CABasicAnimation(keyPath: "shadowRadius")
                secondGlowAnimation.fromValue = toValue
                secondGlowAnimation.toValue = 0
                secondGlowAnimation.beginTime = CACurrentMediaTime()
                secondGlowAnimation.duration = CFTimeInterval(duration)
                secondGlowAnimation.fillMode = .forwards
                secondGlowAnimation.autoreverses = false
                secondGlowAnimation.isRemovedOnCompletion = false
                secondGlowAnimation.repeatCount = 0

                self?.layer.add(secondGlowAnimation, forKey: "secondGlowAnimation")
            }
        } else {
            let forceProgress = (forceProgress - 0.5) * 2
            let fromValue = CGFloat(effect.rawValue) - CGFloat(effect.rawValue) * forceProgress

            layer.shadowRadius = fromValue

            let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
            glowAnimation.fromValue = fromValue
            glowAnimation.toValue = 0
            glowAnimation.beginTime = CACurrentMediaTime() + 0
            glowAnimation.duration = CFTimeInterval(duration)
            glowAnimation.fillMode = .forwards
            glowAnimation.autoreverses = false
            glowAnimation.isRemovedOnCompletion = false
            glowAnimation.repeatCount = 0

            layer.add(glowAnimation, forKey: "shadowGlowingAnimation")
        }
    }

    func moveWithPath() {
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 2

        let bezierPath = UIBezierPath()

        let center = self.center


        bezierPath.addQuadCurve(to: CGPoint(x: center.x + 200,
                                            y: center.y + 400),
                                controlPoint: CGPoint(x: center.x + 100,
                                                      y: center.y))

        // Your new shape here
        animation.toValue = bezierPath.cgPath
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        // The next two line preserves the final shape of animation,
        // if you remove it the shape will return to the original shape after the animation finished
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false

        layer.add(animation, forKey: "abc")
    }
}

class MyView: UIView {

    let shapeLayer = CAShapeLayer()
    let maskLayer = CAShapeLayer()
    var rectanglePath = UIBezierPath()

    func start() {
        prepareForEditing(editing: true)

        backgroundColor = UIColor.clear

        // initial shape of the view
        rectanglePath = UIBezierPath(rect: bounds)

        // Create initial shape of the view
        shapeLayer.path = rectanglePath.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayer)

        //mask layer
        maskLayer.path = shapeLayer.path
        maskLayer.position =  shapeLayer.position
        layer.mask = maskLayer
    }

    func prepareForEditing(editing:Bool){

        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 2

        //    a.point

        // Your new shape here
        animation.toValue = UIBezierPath(ovalIn: bounds).cgPath
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        // The next two line preserves the final shape of animation,
        // if you remove it the shape will return to the original shape after the animation finished
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false

        shapeLayer.add(animation, forKey: nil)
        maskLayer.add(animation, forKey: nil)
    }

    func animation(){
        CATransaction.begin()

        let layer : CAShapeLayer = CAShapeLayer()
        layer.strokeColor = UIColor.purple.cgColor
        layer.lineWidth = 3.0
        layer.fillColor = UIColor.clear.cgColor

        let path : UIBezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 100, height: 100), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 100, height: 0.0))
        layer.path = path.cgPath

        let animation : CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0

        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = 1

        CATransaction.setCompletionBlock{
            print("Animation completed")
        }

        layer.add(animation, forKey: "myStroke")
        CATransaction.commit()
        self.layer.addSublayer(layer)
    }

    func positionAnimation() {
        let duration: CFTimeInterval = 0.6
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            //            self?.alpha = 0
        }

        let downAni = CAKeyframeAnimation(keyPath: "position")
        downAni.calculationMode = .paced
        downAni.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        downAni.fillMode = .forwards
        downAni.isRemovedOnCompletion = false
        downAni.duration = duration

        let fromPoint = self.center
        let midPoint = CGPoint(x: fromPoint.x + 100, y: fromPoint.y + 50)
        let endPoint = CGPoint(x: fromPoint.x + 120, y: fromPoint.y + 400)

        let curvedPath = CGMutablePath()
        curvedPath.move(to: fromPoint)
        curvedPath.addQuadCurve(to: endPoint, control: midPoint)

        downAni.path = curvedPath

        let opacityAni = CABasicAnimation(keyPath: "opacity")
        opacityAni.fromValue = 1
        opacityAni.toValue = 0
        //        opacityAni.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAni.duration = duration
        opacityAni.fillMode = .forwards
        opacityAni.isRemovedOnCompletion = false

        layer.add(opacityAni, forKey: nil)
        layer.add(downAni, forKey: nil)

        CATransaction.commit()


    }

}
