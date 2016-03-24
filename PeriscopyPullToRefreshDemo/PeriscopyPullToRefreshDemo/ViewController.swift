//
//  ViewController.swift
//  PeriscopyPullToRefresh
//
//  Created by Andrzej Naglik on 28.08.2015.
//  Copyright © 2015 Andrzej Naglik. All rights reserved.
//

import UIKit

let cellIdentifier = "cellIdentifier"

class ViewController: UIViewController {
  
  lazy var tableView: UITableView = {
    var tableView = UITableView(frame: CGRectZero, style: .Plain)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    return tableView
    }()
  
  override func loadView() {
    view = UIView(frame: UIScreen.mainScreen().bounds)
    view.backgroundColor = .whiteColor()
    
    view.addSubview(tableView)
    setupConstraints()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let navigationController = self.navigationController else { return }
    
    navigationController.navigationBar.translucent = false
    navigationController.navigationBar.barTintColor = UIColor(red: 121/255.0, green: 189/255.0, blue: 168/255.0, alpha: 1.0)
    
    self.title = "List of elements"
    let titleView = PeriscopyTitleView(frame: CGRect(x: 0.0, y: 0.0, width: 160.0, height: navigationController.navigationBar.frame.height),
      attachToScrollView: tableView, refreshAction: { [unowned navigationController] in
        
        let view = navigationController.navigationBar.startLoadingAnimation()
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(4 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            navigationController.navigationBar.stopLoadingAnimationWithView(view)
        }
    })
    
    titleView.titleLabel.textColor = .whiteColor()
    titleView.releaseLabel.textColor = .whiteColor()
    titleView.releaseLabel.highlightedTextColor = UIColor(red:207/255.0, green:240/255, blue:158/255, alpha:1.0)

    self.navigationItem.titleView = titleView
  }
  
  func setupConstraints(){
    tableView.translatesAutoresizingMaskIntoConstraints = false
    let myViews = ["tableView" : tableView]
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0),
      metrics: nil, views: myViews))
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0),
      metrics: nil, views: myViews))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK : table view data source

extension ViewController : UITableViewDataSource{
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20;
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
      cell.textLabel?.text = "Text \(indexPath.row+1)"
    return cell
  }
}

// MARK : table view delegate methods

extension ViewController : UITableViewDelegate{
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) -> Void{
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
}

