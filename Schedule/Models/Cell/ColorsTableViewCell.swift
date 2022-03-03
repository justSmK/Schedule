//
//  ColorsTableViewCel.swift
//  Schedule
//
//  Created by justSmK on 31.01.2022.
//

import UIKit

class ColorsTableViewCell: UITableViewCell {
    
    private let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none //выделение ячейки
        self.backgroundColor = .clear
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfigure(indexPath: IndexPath) {

        switch indexPath.section {
//        case 0: backgroundViewCell.backgroundColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0, alpha: 1)
        case 0: backgroundViewCell.backgroundColor = #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4196078431, alpha: 1)
        case 1: backgroundViewCell.backgroundColor = #colorLiteral(red: 1, green: 0.5725490196, blue: 0.168627451, alpha: 1)
        case 2: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.768627451, blue: 0.09803921569, alpha: 1)
        case 3: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.8117647059, blue: 0.4, alpha: 1)
        case 4: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.2, green: 0.6039215686, blue: 0.9411764706, alpha: 1)
        case 5: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.4862745098, blue: 0.9803921569, alpha: 1)
        case 6: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.5176470588, green: 0.368627451, blue: 0.968627451, alpha: 1)
        default:
            backgroundViewCell.backgroundColor = .white
        }
    }
    
    func setConstraints() {
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
        
    }
}

