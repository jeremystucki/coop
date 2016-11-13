//
//  NetworkRouter.swift
//  Coop
//
//  Created by Jeremy Stucki on 17.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


protocol NetworkRouterOutput: ConnectionErrorRouterOutput {

}


protocol NetworkRouter: ConnectionErrorRouterOutput {

    var viewController: UIViewController { get }
    var presenter: NetworkRouterOutput { get }

}


extension NetworkRouter {

    func retryPressed() {
        presenter.retryPressed()
    }

    func showConnectionError() {
        viewController.present(ConnectionErrorRouter(output: presenter).viewController, animated: true)
    }

}
