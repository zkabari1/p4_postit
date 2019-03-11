//
//  ViewController.swift
//  p4_postit
//
//  Created by Zimpleprakashb Kabariya on 3/4/19.
//  Copyright © 2019 SUNY Binghamton. All rights reserved.
//

import UIKit
//class ViewController:UIViewController{
class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{

   @IBOutlet var table: UITableView!
    
    @IBOutlet var enterpost: UITextField!
    @IBOutlet var new: UIButton!
    
   var items: [String] = ["We", "Heart", "Swiftttttttttttttttttttttttttttttttttttttttttttttt"]
    
  /*  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=self.table.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text=self.items[indexPath.row]
        cell.textLabel?.numberOfLines=0
        cell.textLabel?.textColor=UIColor .blue
        cell.textLabel?.font=UIFont (name: "BradleyHandITCTT-Bold", size: 20)
        cell.backgroundColor=UIColor .clear
        //cell.layer.borderWidth=10
        //cell.layer.borderColor=UIColor .groupTableViewBackground.cgColor
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.estimatedRowHeight=44
        table.rowHeight=UITableViewAutomaticDimension
        self.enterpost.delegate = self
        self.table.addSubview(self.refreshControl)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
  
    @IBAction func newpost(_ sender: Any) {
        let new = "newpost="+enterpost.text!
        let myurl = NSURL(string:"https://cs.binghamton.edu/~zkabari1/server.php");
        let request = NSMutableURLRequest(url : myurl! as URL);
        request.httpMethod="POST"
        request.httpBody = new.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil
            {
                print("error=\(error)")
                return
            }
            print("response = \(response)")
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json{
                    let newPost = parseJSON["newpost"] as? String
                    print("New Post:\(newPost)")
                    self.items.append(newPost!)
                }
                
            }catch{
                print(error)
            }
            
        }
        task.resume()
        //items.append(new!)
        
    }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        
        self.table.reloadData()
        refreshControl.endRefreshing()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

