//
//  ViewController.swift
//  p4_postit
//
//  Created by Zimpleprakashb Kabariya on 3/4/19.
//  Copyright © 2019 SUNY Binghamton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let myurl = NSURL(string:"https://github.com/zkabari1/p4_postit/blob/master/server.php");
        let request = NSMutableURLRequest(url : myurl! as URL);
        request.httpMethod="POST"
        let poststring = "firstName=James&lastName=Bond";
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

