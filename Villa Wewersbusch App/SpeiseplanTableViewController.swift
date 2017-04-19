//
//  SpeiseplanTableViewController.swift
//  Villa Wewersbusch App
//
//  Created by Felix Kolewe on 19.04.17.
//  Copyright © 2017 Felix Kolewe. All rights reserved.
//

import UIKit
import Firebase


class SpeiseplanTableViewController: UITableViewController {

    var ref: FIRDatabaseReference!
    
    let cellId = "cellId"
    var menues = [Menue]()
    
    let menueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()funcch fetUser
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Zurück", style: .plain, target: self, action: #selector(handleCancel))
        
        
        tableView.register(MenueCell.self, forCellReuseIdentifier: cellId)
        
        
        fetchMenue()
    }
    
    func fetchMenue() {
    
        FIRDatabase.database().reference().child("speiseplan").observe(.childAdded, with: {(snapshot) in
        
            print(snapshot)
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                
                let menue = Menue()
                
                menue.setValuesForKeys(dictionary)
                
                self.menues.append(menue)
                
                print(menue.tag)
                
                
                if let menueImageUrl = dictionary["menueImageUrl"] as? String {
                    self.menueImageView.loadImageUsingCacheWithUrlString(urlString: menueImageUrl)
                }
                
                DispatchQueue.main.async(execute: {
                     self.tableView.reloadData()
                })
               
            
            }
        
        })
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let menue = menues[indexPath.row]
        
        cell.textLabel?.text = menue.tag
        cell.detailTextLabel?.text = menue.gericht
        
 
         // let menueImageView = UIImageView()
        
        if let menueImageUrl = menue.menueImageUrl{
            cell.imageView?.loadImageUsingCacheWithUrlString(urlString: menueImageUrl)
        }
        
     
        
        return cell
    }
    
    
    
    


    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
 

}

class MenueCell: UITableViewCell{

    override init (style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
  
   /* let containerView = UIView()

    containerView.addSubview(menueImageView)
       
    menueImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
    menueImageView.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).isactive = true
    menueImageView.widthAnchor.constraintEqualToConstant(48).isactive = true
    menueImageView.heightAnchor.constraintEqualToConstant(48).isactive = true
    
        */
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("initCoder")
    }
}

