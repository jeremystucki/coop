//
//  InitialView.swift
//  Coop
//
//  Created by Jeremy Stucki on 05.10.16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit

class InitialView: UIView {
    
    let context: NSExtensionContext
    
    override func didMoveToSuperview() {
        if superview == nil {
            return
        }
        
        let chooseLocationButton = UIButton(type: .system)
        chooseLocationButton.setTitle("Choose location", for: .normal)
        chooseLocationButton.sizeToFit()
        chooseLocationButton.center = superview!.center
        chooseLocationButton.setTitleColor(.black, for: .normal)
        
        addSubview(chooseLocationButton)
        
        chooseLocationButton.addTarget(self, action: #selector(openApp(_:)), for: .touchUpInside)
    }
    
    @objc private func openApp(_ sender : UITapGestureRecognizer) {
        let url = URL(string: "coop-menuplan://settings")
        context.open(url!) { (success) in print(success) }
    }
    
    init(context: NSExtensionContext) {
        self.context = context
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 200))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
