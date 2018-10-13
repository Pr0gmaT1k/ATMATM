//
//  OpeningHoursTableViewCell.swift
//  atmatm
//
//  Created by azerty on 13/10/2018.
//  Copyright © 2018 azerty. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift

final class OpeningHoursTableViewCell: UITableViewCell, NibReusable {
    // MARK:- IBOutlets
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var hourLabel: UILabel!
    
    // MARK:- Properties
    
    // MARK:- function
    func fill(day: String, hours: OpeningHoursByDay?) {
        self.dayLabel.text = day
        guard let open = hours?.close, let close = hours?.close else { return }
        if open == "00:00" && close == "00:00" {
            self.hourLabel.text = L10n.closed
        } else {
            
            self.hourLabel.text = "\(open) - \(close)"
        }
    }
    
}
