//
//  MenuTableViewCell.swift
//  UserContacts
//
//  Created by Oleksandr Melnyk on 04.10.2022.
//

import UIKit

final class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var numberOfItemsLabel: UILabel!
    @IBOutlet var iconImage: UIImageView!
    private let menuOptions = ["Контакты",
                               "Повторяющиеся имена",
                               "Дубликаты номеров",
                               "Без имени",
                               "Нет номера",
                               "Нет электронной почты"
    ]
    
    private let menu: [String: UIImage] = ["Контакты": UIImage(systemName: "person.circle")!,
                                           "Повторяющиеся имена": UIImage(systemName: "person.3")!,
                                           "Дубликаты номеров": UIImage(systemName: "phone")!,
                                           "Без имени": UIImage(systemName: "person.crop.circle.badge.questionmark")!,
                                           "Нет номера": UIImage(systemName: "iphone.slash")!,
                                           "Нет электронной почты": UIImage(systemName: "envelope")!]

    func setCustomCellLabel(for index: Int) {
        titleLabel.text = menuOptions[index]
        iconImage.image = menu[menuOptions[index]]
    }
    
    func setNumberLabel(number: Int) {
        numberOfItemsLabel.text = String(number)
    }
    
}
