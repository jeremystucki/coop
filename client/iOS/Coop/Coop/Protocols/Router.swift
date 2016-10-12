//
//  Router.swift
//  Coop
//
//  Created by Jeremy Stucki on 12.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


protocol Router {

    associatedtype AvailableView

    var viewController: UIViewController { get }

    func display(view: AvailableView)

}
