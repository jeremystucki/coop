//
//  MenuDetailViewController.swift
//  Coop
//
//  Created by Jeremy Stucki on 16.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit


class MenuDetailViewController: UIViewController {

    private let menu: Menu
    private let dishesLabel = UILabel()

    init(forMenu menu: Menu) {
        self.menu = menu
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        var topSpacing = UIApplication.shared.statusBarFrame.size.height

        topSpacing += navigationController!.navigationBar.bounds.size.height
        dishesLabel.frame = CGRect(x: 20, y: topSpacing + 20, width: 0, height: 0)
        dishesLabel.text = menu.dishes.joined(separator: "\n")
        dishesLabel.numberOfLines = menu.dishes.count
        dishesLabel.sizeToFit()

        view.addSubview(dishesLabel)
        view.backgroundColor = .groupTableViewBackground
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
