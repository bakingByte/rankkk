//
//  SFSwiftNotification.swift
//  SFSwiftNotification
//
//  Created by Simone Ferrini on 13/07/14.
//  Copyright (c) 2016 sferrini. All rights reserved.
//

import UIKit

enum AnimationType {
    case collision
    case bounce
}

enum AnimationDirection {
    case topToBottom
    case leftToRight
    case rightToLeft
}

struct AnimationSettings {
    var duration: TimeInterval = 0.5
    var delay: TimeInterval = 0
    var damping: CGFloat = 0.6
    var velocity: CGFloat = 0.9
    var elasticity: CGFloat = 0.3
}

//protocol SFSwiftNotificationProtocol {
//    func didNotifyFinishedAnimation(results: Bool)
//    func didTapNotification()
//}

class SFSwiftNotification: UIView {
    
    var label = UILabel()
    
    fileprivate var animationType: AnimationType?
    fileprivate var animationSettings = AnimationSettings()
    fileprivate var direction: AnimationDirection?
    fileprivate var dynamicAnimator = UIDynamicAnimator()
   // private var delegate: SFSwiftNotificationProtocol?
    fileprivate var canNotify = true
    fileprivate var offScreenFrame = CGRect()
    fileprivate var toFrame = CGRect()
    fileprivate var initialFrame = CGRect()
    fileprivate var delay = TimeInterval()
    
    init(frame: CGRect, title: String?, animationType: AnimationType, direction: AnimationDirection) {
        super.init(frame: frame)
        
        self.animationType = animationType
        self.direction = direction
       // self.delegate = delegate
        self.initialFrame = frame
        
        label = UILabel(frame: self.frame)
        label.text = title
        label.font = UIFont(name: "SanFranciscoDisplay-Regular", size: 17.0)
        label.textAlignment = NSTextAlignment.center
        self.backgroundColor = UIColor(red: 12.0/255.0, green: 189.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.label.textColor = UIColor.white
        self.addSubview(label)
        
        // Create gesture recognizer to detect notification touches
        let tapReconizer = UITapGestureRecognizer()
        tapReconizer.addTarget(self, action: #selector(SFSwiftNotification.invokeTapAction));
        
        // Add Touch recognizer to notification view
        self.addGestureRecognizer(tapReconizer)
        
        offScreen()
        let win:UIWindow = UIApplication.shared.delegate!.window!!
        win.addSubview(self)
    }
    
  

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate(_ delay: TimeInterval) {
        
        self.toFrame = self.frame
        self.delay = delay
        
        if canNotify {
            self.canNotify = false
            
            switch self.animationType! {
            case .collision:
                setupCollisionAnimation(self.initialFrame)
                
            case .bounce:
                setupBounceAnimation(self.initialFrame, delay: delay)
            }
        }
    }
    
    func invokeTapAction() {
        
     //   self.delegate!.didTapNotification()
        self.canNotify = true
    }
    
    fileprivate func offScreen() {
        
        self.offScreenFrame = self.frame
        
        switch direction! {
        case .topToBottom:
            self.offScreenFrame.origin.y = -self.frame.size.height
        case .leftToRight:
            self.offScreenFrame.origin.x = -self.frame.size.width
        case .rightToLeft:
            self.offScreenFrame.origin.x = +self.frame.size.width
        }
        
        self.frame = offScreenFrame
    }
    
    fileprivate func setupCollisionAnimation(_ toFrame: CGRect) {
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.superview!)
        self.dynamicAnimator.delegate = self
        
        let elasticityBehavior = UIDynamicItemBehavior(items: [self])
        elasticityBehavior.elasticity = animationSettings.elasticity;
        self.dynamicAnimator.addBehavior(elasticityBehavior)
        
        let gravityBehavior = UIGravityBehavior(items: [self])
        self.dynamicAnimator.addBehavior(gravityBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: [self])
        self.dynamicAnimator.addBehavior(collisionBehavior)
        
        collisionBehavior.addBoundary(withIdentifier: "BoundaryIdentifierBottom" as NSCopying, from: CGPoint(x: -self.frame.width, y: self.frame.height), to: CGPoint(x: self.frame.width*2, y: self.frame.height))
        
        switch self.direction! {
        case .topToBottom:
            break
        case .leftToRight:
            collisionBehavior.addBoundary(withIdentifier: "BoundaryIdentifierRight" as NSCopying, from: CGPoint(x: self.toFrame.width+1, y: 0), to: CGPoint(x: self.toFrame.width+2, y: self.toFrame.height))
            gravityBehavior.gravityDirection = CGVector(dx: 10, dy: 1)
        case .rightToLeft:
            collisionBehavior.addBoundary(withIdentifier: "BoundaryIdentifierLeft" as NSCopying, from: CGPoint(x: -1, y: 0), to: CGPoint(x: -2, y: self.toFrame.height))
            gravityBehavior.gravityDirection = CGVector(dx: -10, dy: 1)
        }
    }
    
    fileprivate func setupBounceAnimation(_ toFrame: CGRect , delay: TimeInterval) {
        
        UIView.animate(withDuration: animationSettings.duration,
            delay: animationSettings.delay,
            usingSpringWithDamping: animationSettings.damping,
            initialSpringVelocity: animationSettings.velocity,
            options: ([.beginFromCurrentState, .allowUserInteraction]),
            animations:{
                self.frame = toFrame
            }, completion: {
                (value: Bool) in
                self.hide(toFrame, delay: delay)
            }
        )
    }
    
    fileprivate func hide(_ toFrame: CGRect, delay: TimeInterval) {
        
        UIView.animate(withDuration: animationSettings.duration,
            delay: delay,
            usingSpringWithDamping: animationSettings.damping,
            initialSpringVelocity: animationSettings.velocity,
            options: ([.beginFromCurrentState, .allowUserInteraction]),
            animations:{
                self.frame = self.offScreenFrame
            }, completion: {
                (value: Bool) in
               // self.delegate!.didNotifyFinishedAnimation(true)
                self.canNotify = true
            }
        )
    }
}

extension SFSwiftNotification: UIDynamicAnimatorDelegate {
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        
        hide(self.toFrame, delay: self.delay)
    }
    
}
