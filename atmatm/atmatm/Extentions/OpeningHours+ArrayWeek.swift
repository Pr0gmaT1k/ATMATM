//
//  OpeningHours+ArrayWeek.swift
//  atmatm
//
//  Created by azerty on 13/10/2018.
//  Copyright © 2018 azerty. All rights reserved.
//

extension OpeningHours {
    var days: [String: OpeningHoursByDay?] {
        return [L10n.monday: monday,
                L10n.tuesday: tuesday,
                L10n.wednesday: wednesday,
                L10n.thursday: thursday,
                L10n.friday: friday,
                L10n.saturday: saturday,
                L10n.sunday: sunday]
    }
}
