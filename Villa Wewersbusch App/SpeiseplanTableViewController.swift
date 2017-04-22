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

    //var ref: FIRDatabaseReference!
    
    let cellId = "cellId"
    var menues = [Menue]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()funcch fetUser
        
        view.backgroundColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menü", style: .plain, target: self.revealViewController() , action: #selector(SWRevealViewController.revealToggle(_:)))
        
        
        //let image = UIImage(named: "MenuButton")
        //let smallImage = resizeImage(image: image!, targetSize: CGSize.init(width: 40, height: 38))
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: smallImage, style: .plain, target: self , action: nil)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //view.addSubview(menueTitleView)
        
        //setupMenueTitleView()
        //setupTableView()

        tableView.register(MenueCell.self, forCellReuseIdentifier: cellId)
        
        //tableView.contentInset = UIEdgeInsets(top: 100,left: 0,bottom: 0,right: 0)

        //tableView.tableHeaderView = menueTitleView
        
        fetchMenue()
    }
    
    func fetchMenue() {
    
        FIRDatabase.database().reference().child("speiseplan").observe(.childAdded, with: {(snapshot) in
        
            print(snapshot)
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                
                let menue = Menue()
                
                menue.setValuesForKeys(dictionary)
                
                self.menues.append(menue)
                
                //print(menue.tag)
                
                
                if let menueImageUrl = dictionary["menueImageUrl"] as? String {
                    menueImageView.loadImageUsingCacheWithUrlString(urlString: menueImageUrl)
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenueCell
        
        let menue = menues[indexPath.row]
        
        cell.dayLabel.text = menue.tag

        cell.menueLabel.text = menue.gericht
        
        //cell.menueLabel.text = "Dies ist ein Test mit einem sehr langen Text. Mal sehen was passiert."
        
        let menueImageView = UIImageView()
        menueImageView.translatesAutoresizingMaskIntoConstraints = false
        menueImageView.contentMode = .scaleAspectFill
        menueImageView.layer.cornerRadius = 20
        menueImageView.clipsToBounds = true
        
        if let menueImageUrl = menue.menueImageUrl{
            
            cell.imageView?.loadImageUsingCacheWithUrlString(urlString: menueImageUrl)
            
        }
        
        return cell
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    let menueTitleView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "speiseplan")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    /*func setupMenueTitleView(){
    menueTitleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
    menueTitleView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
    menueTitleView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive=true
    menueTitleView.heightAnchor.constraint(equalToConstant: 150).isActive=true
    }
    */
    

}

let menueImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 24
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
}()


class MenueCell: UITableViewCell{
    
    var dayLabel: UILabel = UILabel()
    var menueLabel: UILabel = UILabel()
    //var imageLable: UILabel = UILabel()
    
    override init (style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let textColor = UIColor(r: 49, g: 99, b: 180)
        
        dayLabel.textColor = textColor
        dayLabel.font = menueLabel.font.withSize(20)
        
        menueLabel.textColor = textColor
        menueLabel.font = menueLabel.font.withSize(12)
        menueLabel.numberOfLines = 4
        
        //dayLabel.backgroundColor = UIColor.blue
        //menueLabel.backgroundColor = UIColor.green
        
        self.contentView.addSubview(dayLabel)
        self.contentView.addSubview(menueLabel)
        //self.contentView.addSubview(imageLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("initCoder")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dayLabel.frame = CGRect(x: 20, y: 12, width: self.bounds.size.width/3, height: self.bounds.size.height-24)
        menueLabel.frame = CGRect(x: self.bounds.size.width/3+20, y: 12, width: self.bounds.size.width*2/3-40, height: self.bounds.size.height-24)
        //imageLabel = UILabel(frame: CGRectMake(0, 0, 0, 0))

    }
}


