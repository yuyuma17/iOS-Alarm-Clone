//
//  AddClockViewController.swift
//  ClockClone
//
//  Created by 黃士軒 on 2019/10/22.
//  Copyright © 2019 Lacie. All rights reserved.
//

import UIKit

class AddClockViewController: UIViewController {

    lazy var time = timePicker.date
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        revisePickerTextColorAndLineColor()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @IBAction func cancelAndBackToMainView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAndAddNewClock(_ sender: UIBarButtonItem) {
        
        if getPickerHour() >= 13 && getPickerHour() <= 23 {
            AlarmData.timePointArray.append("下午")
            AlarmData.hourArray.append(String(getPickerHour() - 12))
            AlarmData.minuteArray.append(getPickerMinute())
        } else if getPickerHour() == 0 {
            AlarmData.timePointArray.append("上午")
            AlarmData.hourArray.append(String(getPickerHour() + 12))
            AlarmData.minuteArray.append(getPickerMinute())
        } else if getPickerHour() == 12 {
            AlarmData.timePointArray.append("下午")
            AlarmData.hourArray.append(String(getPickerHour()))
            AlarmData.minuteArray.append(getPickerMinute())
        } else {
            AlarmData.timePointArray.append("上午")
            AlarmData.hourArray.append(String(getPickerHour()))
            AlarmData.minuteArray.append(getPickerMinute())
        }
        dismiss(animated: true, completion: nil)
    }
    
    func getPickerHour() -> Int {
        dateFormatter.dateFormat = "H"
        let hour = dateFormatter.string(from: time)
        return Int(hour)!
    }
    
    func getPickerMinute() -> String {
        dateFormatter.dateFormat = "mm"
        let minute = dateFormatter.string(from: time)
        return minute
    }
    
    func revisePickerTextColorAndLineColor() {
        
        if let pickerView = timePicker.subviews.first {
            
            for subView in pickerView.subviews {
                
                if subView.frame.height <= 5 {
                    subView.backgroundColor = UIColor.lightGray
                }
            }
            self.timePicker.setValue(UIColor.white, forKey: "textColor")
        }
    }
}
