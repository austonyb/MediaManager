//
//  MediaItemTableViewController.swift
//  MediaManager
//
//  Created by Auston Youngblood on 12/13/22.
//

import UIKit

class MediaItemTableViewController: UITableViewController {

    var items: [MediaItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mediaItemCell", for: indexPath)

        let item = items[indexPath.row]

        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = String(item.rating)
        
        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMediaItemDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let destination = segue.destination as! MediaItemDetailViewController
            destination.delegate = self
            destination.mediaItem = items[indexPath.row]
        }
    }
}

extension MediaItemTableViewController: DeleteItemDelegate {
    func deleteItem(mediaItem: MediaItem) {
        guard let index = items.firstIndex(of: mediaItem) else { return }
        items.remove(at: index)
        tableView.reloadData()
    }
}
