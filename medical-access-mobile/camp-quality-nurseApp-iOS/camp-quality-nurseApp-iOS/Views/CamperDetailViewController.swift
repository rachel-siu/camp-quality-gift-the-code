//
//  CamperDetailViewController.swift
//  camp-quality-nurseApp-iOS
//
//  Created by Wiljay Flores on 2018-11-17.
//  Copyright © 2018 wiljay. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CamperDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var camper: Camper?

    @IBOutlet weak var showMedicationButton: UIButton!
    @IBOutlet weak var camperimageView: UIImageView!
    @IBOutlet weak var camperNameLabel: UILabel!
    @IBOutlet weak var showMedicationContainerConstraint: NSLayoutConstraint!

    @IBOutlet weak var camperInfoContainer: UIView!


    @IBOutlet weak var treatmentsTableView: UITableView!
    @IBOutlet weak var allergiesLabel: UILabel!
    @IBOutlet weak var diagnosisLabel: UILabel!
    @IBOutlet weak var otcLabel: UILabel!
    
    var showMedication = false
    var popupHeight: CGFloat?
    
    var treatments = [Treatment]()
    let database = DatabaseReference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  self.treatments = []
        configureDatabase()
        camperimageView.image = camper?.image
        camperNameLabel.text = camper?.name
        diagnosisLabel.text = "Diagnosis: " + (camper?.primaryDiagnosis)!
        allergiesLabel.text = "Allergies: " + (camper?.allergies)!
        
        if (camper?.otcPermitted)! {
            otcLabel.text = "Over The Counter Medication Allow"
        } else {
            otcLabel.text = "No Over The Counter Medication"
        }
        
        camperimageView.layer.masksToBounds = false
        camperimageView.layer.cornerRadius = camperimageView.frame.size.width / 2
        camperimageView.clipsToBounds = true
        camperimageView.contentMode = .scaleToFill
        popupHeight = camperInfoContainer.frame.height
        
        
    }
    
    @IBAction func medicationButtonPressed(_ sender: UIButton) {
        if showMedication {
            showMedication = false
            showMedicationContainerConstraint.constant = 0
            showMedicationButton.setTitle("Show Schedule", for: .normal)
        } else {
            showMedication = true
            showMedicationContainerConstraint.constant -= popupHeight!
            showMedicationButton.setTitle("Hide Schedule", for: .normal)
        }
    }
    
    func configureDatabase() {
        let database = Database.database().reference()
        let id = camper?.id
        
        database.child("treatment/" + (id ?? "")).observe(.childAdded) { (DataSnapshot) in
            let dict = DataSnapshot.value as! NSDictionary
            let id = DataSnapshot.key
            self.createTreatment(treatment: dict, id: id)
        }
        
        database.child("treatment/" + (id ?? "")).observe(.childChanged) { (DataSnapshot) in
            let dict = DataSnapshot.value as! NSDictionary
            let id = DataSnapshot.key
            self.updateTreatment(treatment: dict, id: id)
            
        }
        
    }
    
    func createTreatment(treatment: NSDictionary, id: String) {
        let medication = treatment["medication"] as! String
        let notes = treatment["notes"] as! String
        let date = treatment["date"] as! String
        let time = treatment["time"] as! String
        let details = treatment["details"] as! String
        let beenAdministered = treatment["beenAdministered"] as! Bool
        let dosage = treatment["dosage"] as! String
        
        self.treatments.append(Treatment(sessionID: id, medication: medication, time: time, date: date, beenAdministered: beenAdministered, details: details, notes: notes, dosage: dosage))
        
        treatmentsTableView.reloadData()
        
    }
    
    func updateTreatment(treatment: NSDictionary, id: String) {
        let medication = treatment["medication"] as! String
        let notes = treatment["notes"] as! String
        let date = treatment["date"] as! String
        let time = treatment["time"] as! String
        let details = treatment["details"] as! String
        let beenAdministered = treatment["beenAdministered"] as! Bool
        let dosage = treatment["dosage"] as! String
        
        let update = Treatment(sessionID: id, medication: medication, time: time, date: date, beenAdministered: beenAdministered, details: details, notes: notes, dosage: dosage)
        
        for i in 0..<treatments.count {
            if treatments[i].sessionID == update.sessionID {
                treatments[i] = update
            }
        }
        treatmentsTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treatments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "treatmentCell") as! TreatmentViewCell
        
        cell.configureCell(treatment: treatments[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return treatmentsTableView.frame.height/5
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTreatment" {
            let tableViewCell = sender as! TreatmentViewCell
            let viewController = segue.destination as! TreatmentDetailViewController
           viewController.treatment = tableViewCell.treatment
           viewController.camperID = camper?.id
     }
    }
    
}
