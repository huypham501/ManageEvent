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
    
    let titleLable : UILabel = {
        let lable:UILabel = UILabel()
        lable.font = UIFont.systemFont(ofSize: 18)
        lable.textColor = UIColor.black
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let endTimeLable : UILabel = {
        let lable:UILabel = UILabel()
        lable.font = UIFont.systemFont(ofSize: 10)
        lable.textColor = UIColor.gray
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(titleLable)
        contentView.addSubview(endTimeLable)
        print("HERE1")
    }
    
    public func configure(event:EKEvent) {
        titleLable.text = event.title
        
        print(event.endDate)
        print(event.startDate)
        
        endTimeLable.text = String(Calendar.current.component(Calendar.Component.hour, from: event.startDate))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 10
        
        titleLable.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLable.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleLable.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        endTimeLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor).isActive = true
        endTimeLable.bottomAnchor.constraint(equalTo: endTimeLable.topAnchor, constant: 10).isActive = true
        endTimeLable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        endTimeLable.rightAnchor.constraint(equalTo: endTimeLable.leftAnchor, constant: 40).isActive = true
        
        
    }
}

