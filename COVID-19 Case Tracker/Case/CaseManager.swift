//
//  CaseManager.swift
//  COVID-19 Case Tracker
//
//  Created by Gökberk Köksoy on 13.05.2020.
//  Copyright © 2020 Gökberk Köksoy. All rights reserved.
//

import Foundation
protocol CaseManagerDelegate {
    func didUpdateCases(stats: CaseModel)
    func didFailWithError(error: Error)
}
struct CaseManager {
    let globalDataURL = "https://api.covid19api.com"
    var delegate: CaseManagerDelegate?

    func getStatsOf(country countryName: String){
        let country = countryName.lowercased()
        let url = globalDataURL + "/summary"
        getStats4Country(with: url, for: country)
    }
    
    func getGlobalStats(){
        let url = globalDataURL + "/summary"
        getStats(with: url)
    }
    
    func getStats(with url: String) {
        let urlString = url
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
            
                if let safeData = data {
                    if let stats = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCases(stats: stats)
                    }
                }
            }
            task.resume()
        }
        print(urlString)
    }
    
    func parseJSON(_ caseData: Data) -> CaseModel? {
        let decoder = JSONDecoder()
        do {
         let decodedData = try decoder.decode(CaseData.self, from: caseData)
            let totalCases = decodedData.Global.TotalConfirmed
            let totalDeath = decodedData.Global.TotalDeaths
            let totalRecovered = decodedData.Global.TotalRecovered
            let dailyCases = decodedData.Global.NewConfirmed
            let dailyDeath = decodedData.Global.NewDeaths
            let dailyRecovered = decodedData.Global.NewRecovered
            print("total case: \(totalCases), daily case: \(dailyCases)")
            print("total death: \(totalDeath), daily death: \(dailyDeath)")
            print("total recovered: \(totalRecovered), daily recovered \(dailyRecovered)")
            let stats = CaseModel(totalCases: totalCases, totalDeath: totalDeath, totalRecovered: totalRecovered, dailyCases: dailyCases, dailyDeath: dailyDeath, dailyRecovered: dailyRecovered)
            return stats
        }  catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    func getStats4Country(with url: String, for countryName: String) {
        let urlString = url
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                //let dataString = String(data: data!, encoding: .utf8)
                //print(dataString!)
                if let safeData = data {
                    if let stats = self.parseJSON4Country(safeData, countryName) {
                        self.delegate?.didUpdateCases(stats: stats)
                    }
                }
            }
            task.resume()
        }
        print(urlString)
    }
    func parseJSON4Country(_ caseData: Data, _ countryName: String) -> CaseModel? {
        var counter = 0
        let country = countryName.lowercased()
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CaseData.self, from: caseData)
            for i in 0..<decodedData.Countries.count {
                counter+=1
                if country.elementsEqual(decodedData.Countries[i].Slug) {
                    let totalCases = decodedData.Countries[i].TotalConfirmed
                    let totalDeath = decodedData.Countries[i].TotalDeaths
                    let totalRecovered = decodedData.Countries[i].TotalRecovered
                    let dailyCases = decodedData.Countries[i].NewConfirmed
                    let dailyDeath = decodedData.Countries[i].NewDeaths
                    let dailyRecovered = decodedData.Countries[i].NewRecovered
                    print("total case: \(totalCases), daily case: \(dailyCases)")
                    print("total death: \(totalDeath), daily death: \(dailyDeath)")
                    print("total recovered: \(totalRecovered), daily recovered \(dailyRecovered)")
                    let stats = CaseModel(totalCases: totalCases, totalDeath: totalDeath, totalRecovered: totalRecovered, dailyCases: dailyCases, dailyDeath: dailyDeath, dailyRecovered: dailyRecovered)
                    print(counter)
                    return stats
                } /*else {
                    print("ERRORRR")
                    return nil
                } */
            }
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
     return nil
    }
}


