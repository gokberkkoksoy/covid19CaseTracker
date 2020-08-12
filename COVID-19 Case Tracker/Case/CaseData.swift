//
//  CaseData.swift
//  COVID-19 Case Tracker
//
//  Created by Gökberk Köksoy on 13.05.2020.
//  Copyright © 2020 Gökberk Köksoy. All rights reserved.
//

import Foundation
// CHANGE THESE TOO
struct Global: Decodable {
    let TotalConfirmed: Int
    let TotalDeaths: Int
    let TotalRecovered: Int
    let NewConfirmed: Int
    let NewDeath: Int
    let NewRecovered: Int
}

struct AllData: Decodable {
    let caseInfo: [Global]
}
