//
//  AlarmListTableViewController.swift
//  Alarm2
//
//  Created by Carson Buckley on 3/11/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func alarmWasToggled(sender: SwitchTableViewCell)
}


class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate , AlarmScheduler {
    
    func alarmWasToggled(sender: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        AlarmController.sharedInstance.toggleEnabled(for: alarm)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Printe4d after save")
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.sharedInstance.alarms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell
        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        cell?.delegate = self
        cell?.alarm = alarm
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
            AlarmController.sharedInstance.deleteAlarm(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlarmVC"{
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
            let destinationVC = segue.destination as? AlarmDetailTableViewController
            destinationVC?.alarm = alarm
            
        }
    }
}
