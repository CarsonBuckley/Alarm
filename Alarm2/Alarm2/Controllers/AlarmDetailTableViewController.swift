//
//  AlarmDetailTableViewController.swift
//  Alarm2
//
//  Created by Carson Buckley on 3/11/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmTextField: UITextField!
    @IBOutlet weak var alarmButton: UIButton!
    
    var alarm: Alarm? {
        
        didSet {
            
            loadViewIfNeeded()
            self.updateViews()
            
        }
    }
    
    var alarmIsOn: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = alarmTextField.text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = alarmTextField.text
    }

    func updateViews() {
        
        guard let alarm = alarm else { return }
        alarmIsOn = alarm.enabled
        datePicker.date = alarm.fireDate
        alarmTextField.text = alarm.name
        setUpAlarmButton()
        
    }
    
    func setUpAlarmButton() {
        
        switch alarmIsOn {
        case true:
            alarmButton.backgroundColor = .blue
            alarmButton.setTitle("ARMED", for: .normal)
        case false:
            alarmButton.backgroundColor = .red
            alarmButton.setTitle("DISARMED", for: .normal)
        }
    }
    
    @IBAction func enableButtonTapped(_ sender: UIButton) {
        
        if let alarm = alarm {
            AlarmController.sharedInstance.toggleEnabled(for: alarm)
            alarmIsOn = alarm.enabled
        } else {
            alarmIsOn = !alarmIsOn
        }
        setUpAlarmButton()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = alarmTextField.text else {return}
        guard title != "" else { return }
        
        if let alarm = alarm {
            print("\(AlarmController.sharedInstance.alarms.count)")
            AlarmController.sharedInstance.updateAlarm(alarm: alarm, fireDate: datePicker.date, name: title, enabled: alarmIsOn)
        } else {
            print("\(AlarmController.sharedInstance.alarms.count)")
            AlarmController.sharedInstance.createAlarm(fireDate: datePicker.date, name: title, enabled: alarmIsOn)
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
