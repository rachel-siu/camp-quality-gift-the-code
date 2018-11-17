//
//  SearchViewController.swift
//  camp-quality-nurseApp-iOS
//
//  Created by Wiljay Flores on 2018-11-17.
//  Copyright © 2018 wiljay. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var camperTableView: UITableView!

    var isFiltering = false
    var campers: [Camper]?
    var filteredCampers: [Camper]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let camper1 = Camper(id: "1", name: "John Doe", allergies: ["peanut","advil"], cabin: "2B", image: UIImage(named: "c1")!)
        let camper2 = Camper(id: "2", name: "Jane Doe", allergies: ["acetaminophen"], cabin: "5G", image: UIImage(named: "c3")!)
        let camper3 = Camper(id: "3", name: "Johnny D", allergies: [""], cabin: "2B", image: UIImage(named: "c2")!)
        let camper4 = Camper(id: "4", name: "Janey D", allergies: [""], cabin: "5G", image: UIImage(named: "c4")!)
        
        self.campers = [camper1,camper2,camper3,camper4]
        self.filteredCampers = []
        
        searchBar.delegate = self
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return camperTableView.frame.height/6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return (self.filteredCampers?.count)!
        } else {
            return (self.campers?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "camperCell") as! CamperViewCell
        
        if isFiltering {
            cell.configureCell(camper: (filteredCampers?[indexPath.row])!)
        } else {
            cell.configureCell(camper: (campers?[indexPath.row])!)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCamperDetail" {
            let tableViewCell = sender as! CamperViewCell
            let viewController = segue.destination as! CamperDetailViewController
            viewController.camper = tableViewCell.camper
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isFiltering = false
        } else {
            isFiltering = true
            filteredCampers = campers!.filter({( camper : Camper) -> Bool in
                return camper.name.lowercased().contains(searchText.lowercased())
            })
        }
        
        camperTableView.reloadData()

    }
    

}