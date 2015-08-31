//
//  PhotoDetailsViewController.swift
//  
//
//  Created by Hoan Le on 8/31/15.
//
//

import UIKit

class PhotoDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var selectedData: NSDictionary = [:]
    var comments: NSDictionary!
    var data: [NSDictionary] = []
    @IBOutlet weak var photoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comments = selectedData["comments"] as! NSDictionary
        data = comments["data"] as! [NSDictionary]
        print(data.count)
        
        self.photoTableView.dataSource = self
        self.photoTableView.delegate = self
        
        self.photoTableView.reloadData()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return data.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Photo Cell", forIndexPath: indexPath) as! PhotoCell
        
        let dataRow = data[indexPath.row]
        let from = dataRow["from"] as! NSDictionary
        let profile_picture = from["profile_picture"] as! String
        cell.photoImageView.setImageWithURL(NSURL(string: profile_picture)!)
        print(profile_picture)
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
