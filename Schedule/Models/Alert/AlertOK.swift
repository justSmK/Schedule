//
//  AlertOK.swift
//  Schedule
//
//  Created by justSmK on 02.02.2022.
//

import UIKit

extension UIViewController {
    
    func alertOK(title: String) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)

        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}
