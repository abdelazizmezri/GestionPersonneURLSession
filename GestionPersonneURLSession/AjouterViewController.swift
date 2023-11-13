//
//  AjouterViewController.swift
//  GestionPersonneURLSession
//
//  Created by Abdelaziz Mezri on 13/11/2023.
//

import UIKit

class AjouterViewController: UIViewController {
    
    @IBOutlet weak var tfNom: UITextField!
    
    @IBOutlet weak var tfPrenom: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ajouterAction(_ sender: Any) {

        // Define the URL for the POST request
        let url = URL(string: "http://localhost:9090/personne/")!

        // Create an instance of the Person struct
        let newPerson = Personne(id: 0, nom: tfNom.text ?? "", prenom: tfPrenom.text ?? "")

        // Create a URLRequest with the specified URL
        var request = URLRequest(url: url)

        // Set the request method to POST
        request.httpMethod = "POST"

        // Set the request body to the JSON representation of the person
        do {
            let jsonEncoder = JSONEncoder()
            request.httpBody = try jsonEncoder.encode(newPerson)
            // Optionally, you can set the content type to JSON
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            print("Error encoding person: \(error)")
        }

        // Create a URLSession
        let session = URLSession.shared

        // Create a data task to perform the POST request
        let task = session.dataTask(with: request) { (data, response, error) in
            // Handle the response as before
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("No HTTP response")
                return
            }

            if httpResponse.statusCode == 200 {
                if let data = data {
                    if let stringData = String(data: data, encoding: .utf8) {
                        print("Response data: \(stringData)")
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
