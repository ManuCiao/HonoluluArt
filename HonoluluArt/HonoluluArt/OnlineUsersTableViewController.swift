//
//  AppDelegate.swift
//  HonoluluArt
//
//  Created by Manuela Sabatino on 12/17/16.
//  Copyright © 2016 Manuela Sabatino. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class OnlineUsersTableViewController: UITableViewController {

  // MARK: Constants
  let userCell = "UserCell"
  let usersRef = FIRDatabase.database().reference(withPath: "online")
  
  // MARK: Properties
  var currentUsers: [String] = []
  
  // MARK: UIViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    usersRef.observe(.childAdded, with: { snap in
      guard let email = snap.value as? String else { return }
      self.currentUsers.append(email)
      let row = self.currentUsers.count - 1
      let indexPath = IndexPath(row: row, section: 0)
      self.tableView.insertRows(at: [indexPath], with: .top)
    })
    
    usersRef.observe(.childRemoved, with: { snap in
      guard let emailToFind = snap.value as? String else { return }
      for (index, email) in self.currentUsers.enumerated() {
        if email == emailToFind {
          let indexPath = IndexPath(row: index, section: 0)
          self.currentUsers.remove(at: index)
          self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
      }
    })
    
  }

  // MARK: UITableView Delegate methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentUsers.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: userCell, for: indexPath)
    let onlineUserEmail = currentUsers[indexPath.row]
    cell.textLabel?.text = onlineUserEmail
    return cell
  }
  
  // MARK: Actions
  
  @IBAction func signoutButtonPressed(_ sender: AnyObject) {
    do {
      try FIRAuth.auth()!.signOut()
      dismiss(animated: true, completion: nil)
    } catch {
      
    }
  }
  
}
