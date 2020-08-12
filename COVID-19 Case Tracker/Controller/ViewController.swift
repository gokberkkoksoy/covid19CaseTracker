//
//  ViewController.swift
//  COVID-19 Case Tracker
//
//  Created by Gökberk Köksoy on 13.05.2020.
//  Copyright © 2020 Gökberk Köksoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainTitle: UILabel!
    

    @IBOutlet weak var countrySearchBar: UISearchBar!
    
    
    @IBOutlet weak var totalCaseTitle: UILabel!
    @IBOutlet weak var totalCaseNum: UILabel!
    
    @IBOutlet weak var newCaseTitle: UILabel!
    @IBOutlet weak var newCaseNum: UILabel!
    
    @IBOutlet weak var newDeathTitle: UILabel!
    @IBOutlet weak var newDeathNum: UILabel!
    
    @IBOutlet weak var newRecoveredTitle: UILabel!
    @IBOutlet weak var newRecoveredNum: UILabel!
    
    @IBOutlet weak var totalDeathTitle: UILabel!
    @IBOutlet weak var totalDeathNum: UILabel!
    
    @IBOutlet weak var totalRecoveredTitle: UILabel!
    @IBOutlet weak var totalRecoveredNum: UILabel!
    
    @IBOutlet weak var countryTextField: UITextField!
    
    var caseManager = CaseManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caseManager.delegate = self
        //countryTextField.delegate = self
        countrySearchBar.delegate = self
        
        caseManager.getGlobalStats()

    }

}
//MARK: - CASE MANAGER DELEGATE
extension ViewController: CaseManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCases(stats: CaseModel) {
        DispatchQueue.main.async {
            self.totalCaseNum.text? = "\(stats.totalCases)"
            self.totalDeathNum.text? = "\(stats.totalDeath)"
            self.totalRecoveredNum.text? = "\(stats.totalRecovered)"
            self.newCaseNum.text? = "\(stats.dailyCases)"
            self.newDeathNum.text? = "\(stats.dailyDeath)"
            self.newRecoveredNum.text? = "\(stats.dailyRecovered)" 
        }
    }
}
//MARK: - TEXT FIELD DELEGATE
/*extension ViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if countryTextField.text != "" {
            return true
        } else {
            countryTextField.placeholder = "Enter a country"
            return false
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        countryTextField.endEditing(true)
//        print("\(countryTextField.text!) fdbmldfşb")
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let country = countryTextField.text {
            caseManager.getStatsOf(country: country)
            print(countryTextField.text!)
        }
        //countryTextField.text = ""
    }
}
*/

extension ViewController : UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if countrySearchBar.text != "" {
            return true
        } else {
            countrySearchBar.placeholder = "Enter a country"
            return false
        }
    }
    
    /*func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let country = countrySearchBar.text {
            caseManager.getStatsOf(country: country)
            print(countryTextField.text!)
        }
    }*/
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(countrySearchBar.text!)
        countrySearchBar.endEditing(true)
        if let country = countrySearchBar.text {
            caseManager.getStatsOf(country: country)
            print(countrySearchBar.text!)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        countrySearchBar.endEditing(true)
        countrySearchBar.text! = ""
        countrySearchBar.placeholder! = "Enter a country"
    }
}
