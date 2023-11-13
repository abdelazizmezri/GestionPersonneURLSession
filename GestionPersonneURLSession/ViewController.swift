//
//  ViewController.swift
//  GestionPersonneURLSession
//
//  Created by Abdelaziz Mezri on 13/11/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tvPersonnes: UITableView!
    
    var personnes : [Personne] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        personnes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        let lblNom = contentView?.viewWithTag(1) as! UILabel
        let lblPrenom = contentView?.viewWithTag(2) as! UILabel
        lblNom.text = personnes[indexPath.row].nom
        lblPrenom.text = personnes[indexPath.row].prenom
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getAll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAll()
    }

    func getAll(){
        // Define the URL you want to make a GET request to
        let url = URL(string: "http://localhost:9090/personne/")!

        // Create a URLSession
        let session = URLSession.shared

        // Create a data task to perform the GET request
        let task = session.dataTask(with: url) { (data, response, error) in
            // Check for errors
            if let error = error {
                print("Error: \(error)")
                return
            }

            // Check if a response was received
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No HTTP response")
                return
            }

            // Check if the response status code indicates success (e.g., 200 OK)
            if httpResponse.statusCode == 200 {
                // Check if data was returned
                if let data = data {
                    // Convert the data to a string (or perform any other desired processing)
                    if let stringData = String(data: data, encoding: .utf8) {
                        print("Response data: \(stringData)")
                        do{
                            self.personnes = try JSONDecoder().decode([Personne].self, from: data)
                            self.tvPersonnes.reloadData()
                        }catch{
                            print("Error: \(error)")
                        }
                        
                    }
                }
            } else {
                print("HTTP response status code: \(httpResponse.statusCode)")
            }
        }

        // Start the data task to initiate the request
        task.resume()
    }

}

