//
//  ResultTableViewController.swift
//  MathQuiz
//
//  Created by Rimma on 2022-04-12.
//

import UIKit

class ResultTableViewController: UITableViewController {
    
    
    @IBAction func menuButton(_ sender: Any) {
        let newVC = storyboard?.instantiateViewController(withIdentifier: "menu")
        present(newVC!, animated: true, completion: nil)
    }
    
    @IBAction func newGameButton(_ sender: Any) {
        let newVC = storyboard?.instantiateViewController(withIdentifier: "newGame")
        present(newVC!, animated: true, completion: nil)
    }
    
    
    var results: [Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(results)
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        let result = results[indexPath.row]
        
        cell.textLabel?.text = "Question is: " + result.yourQuestion
        
        cell.detailTextLabel?.text = "Your answer is: " + result.yourAnswer + "   " + result.rightOrWrong
        
        return cell
    }   
}
