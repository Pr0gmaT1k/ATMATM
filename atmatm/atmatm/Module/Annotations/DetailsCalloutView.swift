//
//  DetailsCalloutView.swift
//  atmatm
//
//  Created by azerty on 13/10/2018.
//  Copyright © 2018 azerty. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

/// Display detail about the shop
final class DetailsCalloutView: UIView, NibLoadable {
    // MARK:- IBtoulets
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK:- Properties
    private var days: Variable<[String: OpeningHoursByDay?]> = Variable([String: OpeningHoursByDay?]())
    private let disposeBag = DisposeBag()
    
    // MARK:- functions
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.register(cellType: OpeningHoursTableViewCell.self)
        self.tableView.rowHeight = 15
        
        days.asObservable()
            .bind(to: tableView.rx.items) { _, row, day in
                let cell = self.tableView.dequeueReusableCell(for: IndexPath(row: row, section: 0)) as OpeningHoursTableViewCell
                cell.fill(day: day.key, hours: day.value)
                return cell
            }.disposed(by: disposeBag)
    }
    
    func fill(atm: Atm) {
        self.addressLabel.text = atm.address?.formatted
        self.days.value = atm.openingHours?.days ?? [:]
    }
}
