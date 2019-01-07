//
//  MuseumTableViewController.swift
//  GraduateProject
//
//  Created by 유주원 on 07/11/2018.
//  Copyright © 2018 유주원. All rights reserved.
//

import UIKit

class MuseumTableViewController: UITableViewController{
    
    var museums = [Museum]()
    var tableArray = ["London", "Paris", "Spain", "Italy", "Louvre", "Guggenheim", "Vatican"]
    var segueIdentifiers = ["BritishAR"] //추후에 Louvre, Guggenheim, Vatican Segue 추가해야함
    var sections = ["영국", "프랑스", "이탈리아", "스페인"] //추후 나누기
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ArtCloud"
     
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        self.navigationItem.backBarButtonItem = backItem
        
        
        loadSampleMuseums()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //return self.sections.count
        return 1
    }
    //table section title
//    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return self.sections[section]
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return museums.count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MuseumTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)as? MuseumTableViewCell else{
            fatalError("The dequeued cell is not an instance of MuseumTableViewCell.")
        }
        let museum = museums[indexPath.row]
        cell.nameLabel.text = museum.name
        cell.photoImageView.image = museum.photo
        cell.placeLabel.text = museum.place

        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: segueIdentifiers[indexPath.row], sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: Private Methods
    private func loadSampleMuseums(){
        let photo1 = UIImage(named: "london")
        let photo2 = UIImage(named: "paris")
        let photo3 = UIImage(named: "spain")
        let photo4 = UIImage(named: "italy")
        let photo5 = UIImage(named: "louvre")
        let photo6 = UIImage(named: "guggenheim")
        let photo7 = UIImage(named: "vatican")
        
        guard let museum1 = Museum(name: "The National Museum", photo: photo1!, place:"런던") else{
            fatalError("Unable to instantiate museum1")
        }
        guard let museum2 = Museum(name: "Musée de l'Orangerie", photo: photo2!, place:"파리") else{
            fatalError("Unable to instantiate museum2")
        }
        guard let museum3 = Museum(name: "Louvre Museum", photo: photo5!, place: "파리" ) else{
            fatalError("Unable to instantiate museum3")
        }
        guard let museum4 = Museum(name: "Museo Nacional Thyssen-Bornemisza", photo: photo3!, place:"마드리드") else{
            fatalError("Unable to instantiate museum4")
        }
        guard let museum5 = Museum(name: "Uffizi Gallery", photo: photo4!, place:"피렌체") else{
            fatalError("Unable to instantiate museum5")
        }
        guard let museum6 = Museum(name: "Guggenheim Museum", photo: photo6!, place:"빌바오") else{
            fatalError("Unable to instantiate museum5")
        }
        guard let museum7 = Museum(name: "Vatican Museums", photo: photo7!, place:"로마") else{
            fatalError("Unable to instantiate museum5")
        }
        
        museums += [museum1, museum2, museum3, museum4, museum5, museum6, museum7]


        
    }

}
