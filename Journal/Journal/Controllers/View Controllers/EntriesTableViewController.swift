//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Tobi Kuyoro on 27/01/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    let entryController = EntryController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryTableViewCell else { return UITableViewCell() }
        
        let entry = entryController.entries[indexPath.row]
        cell.entry = entry

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = entryController.entries[indexPath.row]
            entryController.delete(entry: entry)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateEntryShowSegue" {
            if let createEntryVC = segue.destination as? EntryDetailViewController {
                createEntryVC.entryController = entryController
            }
        }
        
        else if segue.identifier == "EntryDetailShowSegue" {
            if let entryDetailVC = segue.destination as? EntryDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                entryDetailVC.entry = entryController.entries[indexPath.row]
                entryDetailVC.entryController = entryController
            }
        }
    }
}
