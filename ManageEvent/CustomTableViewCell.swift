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

//    let backView :UIView = {
//        let view :UIView = UIView(frame: CGRect(x: 0, y: 0, width: , height: 50))
//        return view
//    }()
    
    let titleLabel : UILabel = {
        let label:UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let endTimeLabel : UILabel = {
        let label:UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dotLabel : UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 8)
        label.text = "●"
//        label.backgroundColor = .blue
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
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        titleLabel.addSubview(endTimeLabel)
        titleLabel.addSubview(dotLabel)
//        print("HERE1")
    }
    
    public func configure(event:EKEvent) {
        titleLabel.text = event.title
        
        print(event.structuredLocation)
        
        let minute : String = calMinute(date: event.startDate)
        
        endTimeLabel.text = String(Calendar.current.component(Calendar.Component.hour, from: event.startDate)) + ":" + minute
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -12).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        
        endTimeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 12).isActive = true
        endTimeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        
        dotLabel.centerYAnchor.constraint(equalTo: endTimeLabel.centerYAnchor).isActive = true
        dotLabel.leadingAnchor.constraint(equalTo: endTimeLabel.trailingAnchor, constant: 2).isActive = true
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
    
    private func calMinute(date:Date) -> Int {
        return Calendar.current.component(Calendar.Component.minute, from: date)
    }
    
    private func calMinute(date:Date) -> String {
        let minute: Int = calMinute(date: date)
        
        if minute < 10 {
            return "0" + String(minute)
        }
        
        return String(minute)
    }
}

