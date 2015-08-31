//
//  PhotosViewController.swift
//  Instagram
//
//  Created by Hoan Le on 8/31/15.
//  Copyright (c) 2015 Hoan Le. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data: [NSDictionary]!
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 320
        
        //Load data
        refresh(nil)

        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        addRefreshControll()
        
        
    }
    
    func addRefreshControll(){
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl)
    }
    
    func refresh(sender: AnyObject?){
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=1d1c4edc695a467ca59b1da171c63711&limit=20")!
        
        var request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (reponse: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
            self.refreshControl.endRefreshing()
            if let responseDictionary = responseDictionary {
                self.data = responseDictionary["data"] as! [NSDictionary]
                self.tableView.reloadData()
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if data != nil{
            return data!.count
        }else{
            return 0
        }
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Data Cell", forIndexPath: indexPath) as! DataCell
        
        let dataRow = data[indexPath.row]
        let images = dataRow["images"] as! NSDictionary
        let standard_resolution = images["standard_resolution"] as! NSDictionary
        let url = standard_resolution["url"] as! String
        
        cell.dataImageView.setImageWithURL(NSURL(string: url)!)
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! PhotoDetailsViewController
        
        var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        
        vc.selectedData = self.data[indexPath!.row] as NSDictionary
    }


}
