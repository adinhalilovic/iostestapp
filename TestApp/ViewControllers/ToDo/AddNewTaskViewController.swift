//
//  AddNewTaskViewController.swift
//  TestApp
//
//  Created by Mahmutović Edin on 26/10/2018.
//  Copyright © 2018 Adin Halilovic. All rights reserved.
//

import UIKit
import CoreData

class AddNewTaskViewController: UIViewController {

    enum PickerType {
        case Date
        case Time
    }
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var btnAddDate: UIButton!
    @IBOutlet weak var btnAddTime: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    private var datePickerContainer: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    func commonInit() {
        lblDate.isHidden = true
        lblTime.isHidden = true        
    }
    
    // MARK: Private funcs
    private func AddDateTimePicker(type:PickerType) {
        let datePicker : UIDatePicker = UIDatePicker()
        datePickerContainer = UIView()
        
        datePickerContainer.frame = CGRect(x: 0.0,y: 2*Constants.Device.height/3.0,width: 320.0,height: 300.0)
        datePickerContainer.backgroundColor = UIColor.white
        
        let pickerSize : CGSize = datePicker.sizeThatFits(CGSize(width:Constants.Device.width, height: 2*Constants.Device.height/3.0))
        datePicker.frame = CGRect(x: 0.0,y: 20,width: pickerSize.width,height: pickerSize.height)
        if type == .Date {
           datePicker.datePickerMode = UIDatePicker.Mode.date
        } else {
            datePicker.datePickerMode = UIDatePicker.Mode.time
        }
        datePicker.addTarget(self, action: #selector(handleDateTimePicker(sender:)), for: UIControl.Event.valueChanged)
        datePickerContainer.addSubview(datePicker)
        
        let doneButton = UIButton()
        doneButton.setTitle("Done", for: UIControl.State.normal)
        doneButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        doneButton.addTarget(self, action: #selector(dismissPicker(sender:)), for: UIControl.Event.touchUpInside)
        doneButton.frame = CGRect(x: 250.0,y: 5.0,width: 70.0,height: 37.0)
        
        datePickerContainer.addSubview(doneButton)
        
        self.view.addSubview(datePickerContainer)
    }
    
    @objc func handleDateTimePicker(sender: UIDatePicker) {
        if sender.datePickerMode == .date {
            btnAddDate.isHidden = true
            lblDate.isHidden = false
            lblDate.text = sender.date.formatted
        } else {
            btnAddTime.isHidden = true
            lblTime.isHidden = false
            lblTime.text = sender.date.formatTime
        }
        
    }
    
    @objc func dismissPicker(sender: UIDatePicker) {
        datePickerContainer.removeFromSuperview()
    }
    
    // MARK: Actions
    @IBAction func btnSavePressed(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let tasksEntity = NSEntityDescription.entity(forEntityName: "Tasks", in: managedContext)!
        let task = NSManagedObject(entity: tasksEntity, insertInto: managedContext)
        
        task.setValue(txtTitle.text, forKeyPath: "title")
        task.setValue(txtDescription.text, forKey: "task_desc")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        guard let d = lblDate.text else { return }
        let date = formatter.date(from: d)
        task.setValue(date, forKey: "task_date")
        
        guard let t = lblTime.text else { return }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let time = timeFormatter.date(from: t)
        task.setValue(time, forKey: "task_time")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save.")
        }
        
    }
    
    @IBAction func btnCancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAddDatePressed(_ sender: Any) {
        AddDateTimePicker(type: .Date)
    }
    
    @IBAction func btnAddTimePressed(_ sender: Any) {
        AddDateTimePicker(type: .Time)
    }
}
