//
//  SwitchTableViewCell.swift
//  Alarm2
//
//  Created by Carson Buckley on 3/11/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func updateViews() {
        guard let alarm = alarm else {return}
        
        nameLabel.text = alarm.name
        timeLabel.text = alarm.fireTimeAsString
        alarmSwitch.isOn = alarm.enabled
        
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        delegate?.alarmWasToggled(sender: self)

    }
    
}
