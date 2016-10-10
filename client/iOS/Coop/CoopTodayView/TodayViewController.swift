//
//  TodayViewController.swift
//  CoopTodayView
//
//  Created by Jeremy Stucki on 04.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit
import NotificationCenter

@objc(TodayViewController)

class TodayViewController: UIViewController, NCWidgetProviding {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.

        preferredContentSize = view.frame.size
    }

    override func loadView() {
        view = InitialView(context: extensionContext!)
    }

    private func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.newData)
    }

}
