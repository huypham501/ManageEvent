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
        lable.textColor = UIColor.black
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
        print("HERE1")
    }
    
    public func configure(event:EKCalendar) {
        titleLable.text = event.title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLable.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLable.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLable.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLable.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

