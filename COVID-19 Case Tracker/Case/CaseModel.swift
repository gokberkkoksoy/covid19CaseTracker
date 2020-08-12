//
//  CaseModel.swift
//  COVID-19 Case Tracker
//
//  Created by Gökberk Köksoy on 13.05.2020.
//  Copyright © 2020 Gökberk Köksoy. All rights reserved.
//

import Foundation
struct CaseModel {
    let totalCases: Int
    let totalDeath: Int
    let totalRecovered: Int
    let dailyCases: Int
    let dailyDeath: Int
    let dailyRecovered: Int
    let caseManager = CaseManager()
}
