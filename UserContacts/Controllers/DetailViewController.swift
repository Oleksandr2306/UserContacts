//
//  DetailViewController.swift
//  UserContacts
//
//  Created by Oleksandr Melnyk on 04.10.2022.
//

import UIKit
import ContactsUI

final class DetailViewController: UITableViewController {

    var items: [Contact]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRows = items?.count else { return 0 }
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = cell.defaultContentConfiguration()
        
        if let name = items?[indexPath.row].firstName {
            if name.isEmpty {
                config.text = "Имя не указано"
            } else {
                config.text = name
            }
        }
        
        cell.contentConfiguration = config
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedItem = items?[indexPath.row] else { return }
        
        let contact = CNMutableContact()
        contact.givenName = selectedItem.firstName ?? ""
        contact.familyName = selectedItem.lastName ?? ""
        contact.phoneNumbers.append(CNLabeledValue(label: "Mobile", value: CNPhoneNumber(stringValue: selectedItem.phone ?? "")))
        contact.emailAddresses.append(CNLabeledValue(label: "Email", value: NSString(string: selectedItem.email ?? "")))
        presentContactViewController(for: contact)
    }
    
    private func presentContactViewController(for contact: CNMutableContact) {
        let viewController = CNContactViewController(for: contact)
        viewController.allowsEditing = false
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.closeViewController(_ :)))
        
        present(UINavigationController(rootViewController: viewController), animated: true)
    }
    
    @objc private func closeViewController(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
