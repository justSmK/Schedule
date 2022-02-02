//
//  AlertOK.swift
//  Schedule
//
//  Created by justSmK on 02.02.2022.
//

import UIKit

extension UIViewController {
    
    func alertOK(title: String, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)

        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}
