//
//  OptionsContactsTableViewController.swift
//  Schedule
//
//  Created by justSmK on 31.01.2022.
//

import UIKit

class OptionsContactsTableViewController: UITableViewController {
    
    let idOptionsContactsCell = "idOptionsContactsCell"
    let idOptionsContactsHeader = "idOptionsContactsHeader"
    
    let headerNameArray = ["NAME",
                           "PHONE",
                           "MAIL",
                           "TYPE",
                           "CHOOSE IMAGE"]
    
    let cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsContactsCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsContactsHeader)
        
        title = "Option Schedule"
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsContactsCell, for: indexPath) as! OptionsTableViewCell
        cell.cellContactsConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 4 ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsContactsHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell

        switch indexPath.section {
        case 0: alertForCellName(label: cell.nameCellLabel, name: "Name Contact", placeHolder: "Enter name contact")
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Phone} Contact", placeHolder: "Enter phone contact")
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Mail Contact", placeHolder: "Enter mail contact")
        case 3: alertFriendOrTeacher(label: cell.nameCellLabel) { (type) in
            print(type)
        }
        case 4: alertPhotoOrCamera { (source) in
            self.chooseImagePicker(source: source)
        }
            
        default: print("Tap ContactsTableView")
        }
    }
    
    func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension OptionsContactsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let cell = tableView.cellForRow(at: [4, 0]) as! OptionsTableViewCell
        
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds = true
        dismiss(animated: true)
    }
}
