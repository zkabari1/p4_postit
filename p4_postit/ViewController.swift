//
//  ViewController.swift
//  p4_postit
//
//  Created by Zimpleprakashb Kabariya on 3/4/19.
//  Copyright © 2019 SUNY Binghamton. All rights reserved.
//

import UIKit
//class ViewController:UIViewController{
class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

   @IBOutlet var table: UITableView!
    
    @IBOutlet var enterpost: UITextField!
    @IBOutlet var new: UIButton!
    
   var items: [String] = ["We", "Heart", "Swift"]
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=self.table.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text=self.items[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
        
    }
  /* func textFieldShouldReturn(textFeild: UITextField) -> Bool {
        
        textFeild.resignFirstResponder()
        //or
        //self.view.endEditing(true)
        return true
    }*/
  
    @IBAction func newpost(_ sender: Any) {
        let new = enterpost.text
        let myurl = NSURL(string:"https://cs.binghamton.edu/~zkabari1/server.php");
        let request = NSMutableURLRequest(url : myurl! as URL);
        request.httpMethod="POST"
        //let poststring = "firstName=James&lastName=Bond";
        request.httpBody = new?.data(using: String.Encoding.utf8)
        
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
                    let firstName = parseJSON["firstName"] as? String
                    print("firstname:\(firstName)")
                }
                
            }catch{
                print(error)
            }
            
        }
        task.resume()
        //items.append(new!)
    }
   func touchesBegan(_touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

