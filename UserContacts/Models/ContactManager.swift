//
//  ContactManager.swift
//  UserContacts
//
//  Created by Oleksandr Melnyk on 04.10.2022.
//

import Foundation
import ContactsUI

final class ContactManager {
    
    private lazy var store = CNContactStore()
    
    func getContacts(completion: @escaping ([Contact]) -> Void) {
        var contacts = [Contact]()
        let queue = DispatchQueue(label: "Fetching contacts")
        queue.async {
            do {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey] as [CNKeyDescriptor]
                let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
                try self.store.enumerateContacts(with: fetchRequest, usingBlock: { contact, result in
                    contacts.append(Contact(firstName: contact.givenName, lastName: contact.familyName, email: contact.emailAddresses.first?.value as? String, phone: contact.phoneNumbers.first?.value.stringValue))
                })
                DispatchQueue.main.async {
                    completion(contacts)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getDuplicateNames(contacts: [Contact]) -> [Contact] {
        let names = contacts.map { $0.firstName }
        let duplicates = contacts.filter({ (contact: Contact) in
            if names.filter({ $0 == contact.firstName && $0 != nil }).count > 1 {
                return true
            }
            return false
        })
        return duplicates
    }
    
    func getDuplicateNumbers(contacts: [Contact]) -> [Contact] {
        let phones = contacts.map { $0.phone }
        let duplicates = contacts.filter({ (contact: Contact) in
            if phones.filter({ $0 == contact.phone && $0 != nil }).count > 1 {
                return true
            }
            return false
        })
        return duplicates
    }
    
    func getItemsWithoutName(contacts: [Contact]) -> [Contact] {
        let results = contacts.filter({ (contact: Contact) in
            guard let name = contact.firstName else { return true }
            if name.isEmpty {
                return true
            }
            return false
        })
        return results
    }
    
    func getItemsWithoutPhoneNumber(contacts: [Contact]) -> [Contact] {
        let results = contacts.filter({ (contact: Contact) in
            guard contact.phone != nil else { return true }
            return false
        })
        return results
    }
    
    func getItemsWithoutEmail(contacts: [Contact]) -> [Contact] {
        let results = contacts.filter({ (contact: Contact) in
            guard contact.email != nil else { return true }
            return false
        })
        return results
    }
    
}
