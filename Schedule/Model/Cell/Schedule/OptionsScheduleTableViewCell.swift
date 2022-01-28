//
//  OptionsScheduleTableViewCell.swift
//  Schedule
//
//  Created by justSmK on 28.01.2022.
//

import UIKit

class OptionsScheduleTableViewCell: UITableViewCell {
    
    let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameCellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repeateSwitch: UISwitch = {
        let repeateSwitch = UISwitch()
        repeateSwitch.isOn = true
        repeateSwitch.isHidden = true
        repeateSwitch.onTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        repeateSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeateSwitch
    }()
    
    let cellNameArray = [["Date", "Time"],
                         ["Name", "Type", "Building", "Audience"],
                         ["Teacher Name"],
                         [""],
                         ["Repeate every week"]]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none //выделение ячейки
        self.backgroundColor = .clear
        
        repeateSwitch.addTarget(self, action: #selector(switchChange(paramTarget:)), for: .valueChanged)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfigure(indexPath: IndexPath) {
        nameCellLabel.text = cellNameArray[indexPath.section][indexPath.row]
        
        if indexPath == [3, 0] {
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
        
        if indexPath == [4, 0] {
            repeateSwitch.isHidden = false
        }
    }
    
    @objc func switchChange(paramTarget: UISwitch) {
        if paramTarget.isOn {
            print("ON")
        } else {
            print("OFF")
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
        
        self.addSubview(nameCellLabel)
        NSLayoutConstraint.activate([
            nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 15)
        ])
        
        self.contentView.addSubview(repeateSwitch)
        NSLayoutConstraint.activate([
            repeateSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            repeateSwitch.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -20)
        ])
    }
}
