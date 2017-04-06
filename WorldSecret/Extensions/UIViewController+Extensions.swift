//
//  UIViewController+Extensions.swift
//  WorldSecret
//
//  Created by JOSE ANTONIO MARTINEZ FERNANDEZ on 06/04/2017.
//  Copyright © 2017 joamafer. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(childViewController: UIViewController, toView: UIView? = nil) {
        addChildViewController(childViewController)
        let targetView = toView ?? view
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        targetView?.addSubview(childViewController.view)
        targetView?.topAnchor.constraint(equalTo: childViewController.view.topAnchor).isActive = true
        targetView?.leadingAnchor.constraint(equalTo: childViewController.view.leadingAnchor).isActive = true
        targetView?.trailingAnchor.constraint(equalTo: childViewController.view.trailingAnchor).isActive = true
        targetView?.bottomAnchor.constraint(equalTo: childViewController.view.bottomAnchor).isActive = true
        childViewController.didMove(toParentViewController: self)
    }
    
    func removeChildViewController() {
        willMove(toParentViewController: nil)
        view.removeFromSuperview()
        removeFromParentViewController()
    }
    
}
