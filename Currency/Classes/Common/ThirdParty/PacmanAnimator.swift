//
//  PacmanAnimator.swift
//  Currency
//
//  Created by TriNgo on 8/31/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation
import Refresher
import QuartzCore
import UIKit

class PacmanAnimator: UIView, PullToRefreshViewDelegate {
    
    private let layerLoader = CAShapeLayer()
    private let layerSeperator = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layerLoader.lineWidth = 8
        layerLoader.strokeColor = UIColor(red: 0, green: 0.7, blue: 1, alpha: 1).cgColor
        layerLoader.strokeEnd = 0
        layerLoader.fillColor = UIColor.clear.cgColor
        
        layerSeperator.lineWidth = 8
        layerSeperator.strokeColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1).cgColor
        layerSeperator.fillColor = UIColor.clear.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pullToRefresh(_ view: PullToRefreshView, progressDidChange progress: CGFloat) {
        layerLoader.strokeEnd = progress
    }
    
    func pullToRefresh(_ view: PullToRefreshView, stateDidChange state: PullToRefreshViewState) {
        
    }
    
    func pullToRefreshAnimationDidEnd(_ view: PullToRefreshView) {
        layerLoader.removeAllAnimations()
    }
    
    func pullToRefreshAnimationDidStart(_ view: PullToRefreshView) {
        let pathAnimationEnd = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimationEnd.duration = 0.5
        pathAnimationEnd.repeatCount = 100
        pathAnimationEnd.autoreverses = true
        pathAnimationEnd.fromValue = 1
        pathAnimationEnd.toValue = 0.8
        layerLoader.add(pathAnimationEnd, forKey: "strokeEndAnimation")
        
        let pathAnimationStart = CABasicAnimation(keyPath: "strokeStart")
        pathAnimationStart.duration = 0.5
        pathAnimationStart.repeatCount = 100
        pathAnimationStart.autoreverses = true
        pathAnimationStart.fromValue = 0
        pathAnimationStart.toValue = 0.2
        layerSeperator.add(pathAnimationStart, forKey: "strokeStartAnimation")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let superView = superview {
            if layerSeperator.superlayer == nil {
                superView.layer.addSublayer(layerSeperator)
            }
            if layerLoader.superlayer == nil {
                superView.layer.addSublayer(layerLoader)
            }
            let center = CGPoint(x: superView.frame.size.width / 2, y: superView.frame.size.height / 2)
            let bezierPathLoader = UIBezierPath(arcCenter: center, radius: CGFloat(10), startAngle: CGFloat(0), endAngle: CGFloat(2 * M_PI), clockwise: true)
            let bezierPathSeperator = UIBezierPath()
            bezierPathSeperator.move(to: CGPoint(x: 0, y: superView.frame.height - 1))
            bezierPathSeperator.addLine(to: CGPoint(x: superView.frame.width, y: superView.frame.height - 1))
            
            layerLoader.path = bezierPathLoader.cgPath
            layerSeperator.path = bezierPathLoader.cgPath
        }
    }
}
