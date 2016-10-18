//
//  ConnectionErrorRouter.swift
//  Coop
//
//  Created by Jeremy Stucki on 16.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


protocol ConnectionErrorRouterOutput {
    func retryPressed()
}


class ConnectionErrorRouter {

    let viewController: UIViewController
    let output: ConnectionErrorRouterOutput

    init(output: ConnectionErrorRouterOutput) {
        let alert = UIAlertController(
            title: NSLocalizedString("Connection error", comment: ""),
            message: NSLocalizedString("Make sure you are connected to the internet.", comment: ""),
            preferredStyle: .alert
        )

        self.output = output
        self.viewController = alert

        alert.addAction(UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: .default, handler: { (action) in self.output.retryPressed() } ))
    }

    func retryPressed() {
        output.retryPressed()
    }

}
