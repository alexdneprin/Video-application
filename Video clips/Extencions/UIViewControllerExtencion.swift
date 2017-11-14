//
//  UIViewControllerExtencion.swift
//  Video clips
//
//  Created by Alexander Slobodjanjuk on 14.11.2017.
//  Copyright © 2017 Alexander Slobodjanjuk. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showMessage(message: String?, responce: String?){
        let alert = UIAlertController(title: message, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: responce, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
