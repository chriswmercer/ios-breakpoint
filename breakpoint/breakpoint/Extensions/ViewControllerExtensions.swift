//
//  ViewControllerExtensions.swift
//  breakpoint
//
//  Created by Chris Mercer on 25/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let animation = CATransition()
        animation.duration = 0.3
        animation.type = CATransitionType.push
        animation.subtype = .fromRight
        self.view.window?.layer.add(animation, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetail() {
        let animation = CATransition()
        animation.duration = 0.3
        animation.type = CATransitionType.push
        animation.subtype = .fromLeft
        self.view.window?.layer.add(animation, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
}
