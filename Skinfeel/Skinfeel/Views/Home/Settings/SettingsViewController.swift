//
//  SettingsViewController.swift
//  Skinfeel
//
//  Created by Gabriele Namie on 10/01/22.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var settingsTableView: UITableView!
    
    let cellAvatar = AvatarTableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)

        //tableView
        self.settingsTableView.delegate = self
        self.settingsTableView.dataSource = self
    }
}

//Formatação da tableView
extension SettingsViewController: UITableViewDelegate{
}

extension SettingsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell  = settingsTableView.dequeueReusableCell(withIdentifier: "name", for: indexPath) as! NameTableViewCell
            return cell
        }
        else if indexPath.row == 1 {
            let cell  = settingsTableView.dequeueReusableCell(withIdentifier: "avatar", for: indexPath) as! AvatarTableViewCell
            return cell
        }
        else if indexPath.row == 2 {
            let cell  = settingsTableView.dequeueReusableCell(withIdentifier: "day", for: indexPath) as! DayTableViewCell
            return cell
        }
        else if indexPath.row == 3 {
            let cell  = settingsTableView.dequeueReusableCell(withIdentifier: "switch", for: indexPath) as! SwitchDayTableViewCell
            cell.setup(notificationId: .Morning)
            return cell
        }
        else if indexPath.row == 4 {
            let cell  = settingsTableView.dequeueReusableCell(withIdentifier: "switch", for: indexPath) as! SwitchDayTableViewCell
            cell.setup(notificationId: .Afternoon)
            return cell
        }
        else {
            let cell  = settingsTableView.dequeueReusableCell(withIdentifier: "switch", for: indexPath) as! SwitchDayTableViewCell
            cell.setup(notificationId: .Night)
            return cell
            
        }
    }
}

