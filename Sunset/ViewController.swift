//
//  ViewController.swift
//  Sunset
//
//  Created by elfakharany on 10/20/18.
//  Copyright © 2018 elfakharany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var LaCity: UITextField!
    
    @IBOutlet weak var LaResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func LoudURL(url:String){
        
        DispatchQueue.global().async {
    
        do {
            
            let AppURL=URL(string: url)!
            let data = try Data(contentsOf: AppURL )
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            let query = json["query"] as! [String:Any]
            let results = query["results"] as! [String:Any]
            let channel = results["channel"] as! [String:Any]
            let astronomy = channel["astronomy"] as! [String:Any]
            
            DispatchQueue.global().async {
                
            self.LaResult.text="Sunset is: \(astronomy["sunset"]!)"
            }
 
        }
        catch{
            print("can't loud from server")
            }
            
        }
        
        
        
    }
    
    
    @IBAction func BuGetResult(_ sender: Any) {
        
        let url="https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(LaCity.text!)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        LoudURL(url: url)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    

}

