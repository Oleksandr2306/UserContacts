//
//  ViewController.swift
//  UserContacts
//
//  Created by Oleksandr Melnyk on 04.10.2022.
//

import UIKit
import ContactsUI

final class MenuViewController: UITableViewController {
    
    private lazy var contactManager = ContactManager()
    private var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Контакты"
        
        let queue = DispatchQueue(label: "contacts")
        queue.async {
            self.contactManager.getContacts { [weak self] contacts in
                self?.contacts = contacts
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MenuTableViewCell
        cell.setCustomCellLabel(for: indexPath.row)
        
        switch indexPath.row {
        case 0:
            cell.setNumberLabel(number: contacts.count)
            
        case 1:
            //duplicates in names
            let duplicates = contactManager.getDuplicateNames(contacts: contacts)
            cell.setNumberLabel(number: duplicates.count)
            
        case 2:
            //duplicates in phone numbers
            let duplicates = contactManager.getDuplicateNumbers(contacts: contacts)
            cell.setNumberLabel(number: duplicates.count)

        case 3:
            //without name
            let results = contactManager.getItemsWithoutName(contacts: contacts)
            cell.setNumberLabel(number: results.count)
            
        case 4:
            //without phone number
            let results = contactManager.getItemsWithoutPhoneNumber(contacts: contacts)
            cell.setNumberLabel(number: results.count)
            
        case 5:
            //without email
            let results = contactManager.getItemsWithoutEmail(contacts: contacts)
            cell.setNumberLabel(number: results.count)
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            var items = [Contact]()
            switch tableView.indexPathForSelectedRow?.row {
            case 0:
                items = contacts
                destination.title = "Все контакты"
            case 1:
                items = contactManager.getDuplicateNames(contacts: contacts)
                destination.title = "Повторяющиеся имена"
                
            case 2:
                items = contactManager.getDuplicateNumbers(contacts: contacts)
                destination.title = "Дубликаты номеров"
                
            case 3:
                items = contactManager.getItemsWithoutName(contacts: contacts)
                destination.title = "Без имени"
                
            case 4:
                items = contactManager.getItemsWithoutPhoneNumber(contacts: contacts)
                destination.title = "Нет номера"
                
            case 5:
                items = contactManager.getItemsWithoutEmail(contacts: contacts)
                destination.title = "Нет электронной почты"
                
            default:
                break
            }
            destination.items = items
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
}



