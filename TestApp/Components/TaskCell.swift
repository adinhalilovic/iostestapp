//
//  TaskCell.swift
//  TestApp
//
//  Created by Mahmutović Edin on 25/10/2018.
//  Copyright © 2018 Adin Halilovic. All rights reserved.
//

import UIKit

protocol TaskCellDelegate: AnyObject {
    func didClickOnCircle(cell:TaskCell)
}
class TaskCell: UITableViewCell {

    
    @IBOutlet weak var circleButton: UIButton!
    @IBOutlet weak var cellText: UILabel!
    @IBOutlet weak var cellImage: UIButton!
    
    weak var delegate: TaskCellDelegate?
    
    public var isCircleFilled: Bool?
    
    override func awakeFromNib() {
        commonInit()
    }
    
    func commonInit() {
        circleButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        circleButton.layer.cornerRadius = 0.5 * circleButton.bounds.size.width
        circleButton.clipsToBounds = true
        circleButton.layer.borderColor = UIColor.black.cgColor
        circleButton.layer.borderWidth = 1
        isCircleFilled = false
        
    }
    
    public func configureCell(data: Dictionary<String, Any>) {
        if let title = data["title"] as? String {
            cellText.text = title
        }
        
        if let isDone = data["done"] as? Bool {
            if isDone {
                self.isCircleFilled = true
                circleButton.backgroundColor = ColorHelper.color(from: "Green")
            } else {
                self.isCircleFilled = false
                circleButton.backgroundColor = UIColor.clear
            }
        }
    }
    
    func setSelectedCircle(selected:Bool) {
        if selected {
            self.isCircleFilled = true
            circleButton.backgroundColor = ColorHelper.color(from: "Green")
        } else {
            self.isCircleFilled = false
            circleButton.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func circleTapped(_ sender: Any) {
        guard let isCircleFilled = isCircleFilled else {
            return
        }
        if isCircleFilled {
            self.isCircleFilled = false
            circleButton.backgroundColor = UIColor.clear
        } else {
            self.isCircleFilled = true
            circleButton.backgroundColor = ColorHelper.color(from: "Green")
        }
        
        delegate?.didClickOnCircle(cell: self)
    }
}
