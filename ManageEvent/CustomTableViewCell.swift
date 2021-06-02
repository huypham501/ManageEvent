//
//  CustomTableViewCell.swift
//  ManageEvent
//
//  Created by Duong Tuong Vy on 30/05/2021.
//

import Foundation
import UIKit
import EventKit

class CustomTableViewCell :UITableViewCell {
    static let id = "CustomTableViewCell"

    enum DateCalculateType {
        case hour
        case minute
    }
    
    lazy var containerView : UIView = {
        let view : UIView = UIView()
//        view.backgroundColor = .brown
        return view
    }()
    
    let titleLabel : UILabel = {
        let label:UILabel = UILabel()
//        label.backgroundColor = .cyan
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let endTimeLabel : UILabel = {
        let label:UILabel = UILabel()
//        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let startTimeLabel : UILabel = {
        let label:UILabel = UILabel()
//        label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dotLabel : UILabel = {
        let label : UILabel = UILabel()
//        label.backgroundColor = .green
        label.font = UIFont.systemFont(ofSize: 8)
        label.text = "●"
        label.sizeToFit()
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(startTimeLabel)
        containerView.addSubview(endTimeLabel)
        containerView.addSubview(dotLabel)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: 80)
        
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.layer.cornerRadius = 10

        containerView.clipsToBounds = true
        
        titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -12).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true

        startTimeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 12).isActive = true
        startTimeLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true

        dotLabel.centerYAnchor.constraint(equalTo: startTimeLabel.centerYAnchor).isActive = true
        dotLabel.leadingAnchor.constraint(equalTo: startTimeLabel.trailingAnchor, constant: 2).isActive = true
        
        endTimeLabel.centerYAnchor.constraint(equalTo: dotLabel.centerYAnchor).isActive = true
        endTimeLabel.leadingAnchor.constraint(equalTo: dotLabel.trailingAnchor, constant: 2).isActive = true
    }
    
    public func configure(event:EKEvent) {
        titleLabel.text = event.title

        let startMinute : String = calMinute(date: event.startDate)
        let startHour : String = calHour(date: event.startDate)
        let endMinute : String = calMinute(date: event.endDate)
        let endHour : String = calHour(date: event.endDate)
        
        startTimeLabel.text = startHour + ":" + startMinute
        endTimeLabel.text = endHour + ":" + endMinute
        
    }
    
    public func getArraySubview() -> [UIView] {
        return self.subviews
    }
    
    public func calHeightSubview(arrayView:[UIView]) -> Int {
        var res = 0
        
        for view in arrayView {
            res += Int(view.frame.height)
        }
        
        return res
    }

    private func calHour(date:Date) -> String {
        let hour : Int = Calendar.current.component(Calendar.Component.hour, from: date)
        
        if hour == 0 {
            return "00"
        }
        
        return String(hour)
    }
    
    private func calMinute(date:Date) -> String {
        let minute: Int = Calendar.current.component(Calendar.Component.minute, from: date)
        
        if minute < 10 {
            return "0" + String(minute)
        }
        
        return String(minute)
    }
}

