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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let dishesLabel = UILabel()
        dishesLabel.numberOfLines = menu.dishes.count
        dishesLabel.text = menu.dishes.joined(separator: "\n")

        var topSpacing = UIApplication.shared.statusBarFrame.size.height

        if UIDevice.current.userInterfaceIdiom == .pad {
            let titleLabel = UILabel()
            titleLabel.font = titleLabel.font.withSize(30)
            titleLabel.text = menu.title
            titleLabel.frame = CGRect(x: 20, y: topSpacing + 20, width: 0, height: 0)
            titleLabel.sizeToFit()
            view.addSubview(titleLabel)

            dishesLabel.frame = CGRect(x: 20, y: titleLabel.frame.maxY + 10, width: 0, height: 0)
        }

        if UIDevice.current.userInterfaceIdiom == .phone {
            topSpacing += navigationController!.navigationBar.bounds.size.height
            dishesLabel.frame = CGRect(x: 20, y: topSpacing + 20, width: 0, height: 0)
        }

        dishesLabel.sizeToFit()
        view.addSubview(dishesLabel)
        view.backgroundColor = .groupTableViewBackground
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
