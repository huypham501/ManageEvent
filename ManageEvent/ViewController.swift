//
//  ViewController.swift
//  ManageEvent
//
//  Created by TMA on 26/05/2021.
//

import UIKit
import EventKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let HEIGHT_TABLEVIEW_CELL : Int = 70
    let TEXT_LABLE : String = "Events"
    
    let eventManager : EventManager = EventManager()
    
    let tableView : UITableView = {
        let tableView : UITableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let label : UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.gray
        label.text = "Events"
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var listEvent : [EKEvent] = [EKEvent]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.id, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()
        }
        
        cell.configure(event: listEvent[indexPath.row])
        
        return cell
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(label)
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 40).isActive = true
        
        
        tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
        
        tableView.rowHeight = CGFloat(HEIGHT_TABLEVIEW_CELL)
        
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.id)
    }
    
    override func viewDidAppear(_ xanimated: Bool) {
        
        let authorStatus:Bool = self.eventManager.checkAuthorization()
        
        print("Status author (Checking): \(authorStatus)")
        
        // CHECK AUTHOR IF FALSE(.denied) -> ALERT
        if !authorStatus {
            // ALERT
            // CREATE ACTION
            var actions : [UIAlertAction] = []
            actions.append(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
            
            
            self.customAlert(title: "Calendar access denied", message: "null temp", preferredStyle: UIAlertController.Style.alert, alertActions: actions, animated: true, completion: nil)
        } else {
            let dateAWeekFromNow: Date = Calendar.current.date(byAdding: Calendar.Component.weekOfYear, value: 10, to: Date())!
            
            listEvent = eventManager.loadEvent(startDate: Date(), endDate: dateAWeekFromNow)
            tableView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func customAlert(title:String, message:String, preferredStyle:UIAlertController.Style, alertActions:[UIAlertAction], animated:BooleanLiteralType, completion:(() -> Void)?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in alertActions {
            alertController.addAction(action)
        }
        
        print("Present alert")
        present(alertController, animated: true, completion: completion)
    }
    
}
