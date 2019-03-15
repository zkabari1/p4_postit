//
//  ViewController.swift
//  p4_postit
//
//  Created by Zimpleprakashb Kabariya on 3/4/19.
//  Copyright © 2019 SUNY Binghamton. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{

   @IBOutlet var table: UITableView!
    
    @IBOutlet var enterpost: UITextField!
    @IBOutlet var new: UIButton!
    
   var items: [String] = ["Welcome to Post-Its", "To add new post - enter some text in the below textbox and click on + button", "To delete any post - swipe left to right on it and press delete","To refresh list- drag it down and release"]
    
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
        cell.backgroundColor=UIColor .white
        cell.layer.borderWidth=1
        cell.layer.borderColor=UIColor .black.cgColor
        cell.layer.cornerRadius=10
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor(patternImage: UIImage(named:"backgrnd.jpg")!)
        table.backgroundColor=UIColor.clear
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
                let alert = UIAlertController(title: "Hey There!", message:"You cannot enter empty post",preferredStyle: .alert)
                let action = UIAlertAction(title: "Close", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
          }
            
        }
                   task.resume()
     
    }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.table.reloadData()
        refreshControl.endRefreshing()
    }
    
   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexPath) in
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
       delete.backgroundColor=UIColor.red
        return [delete]
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

