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
    var tableView = UITableView(frame: CGRect.zero, style: .plain)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    return tableView
    }()
  
  override func loadView() {
    view = UIView(frame: UIScreen.main.bounds)
    view.backgroundColor = .white
    
    view.addSubview(tableView)
    setupConstraints()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let navigationController = self.navigationController else { return }
    
    navigationController.navigationBar.isTranslucent = false
    navigationController.navigationBar.barTintColor = UIColor(red: 121/255.0, green: 189/255.0, blue: 168/255.0, alpha: 1.0)
    
    self.title = "List of elements"
    let titleView = PeriscopyTitleView(frame: CGRect(x: 0.0, y: 0.0, width: 160.0, height: navigationController.navigationBar.frame.height),
      attachToScrollView: tableView, refreshAction: { [unowned navigationController] in
        
        let view = navigationController.navigationBar.startLoadingPeriscopyAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            navigationController.navigationBar.stopLoadingPeriscopyAnimationWithView(view)
        })
    })
    
    titleView.titleLabel.textColor = .white
    titleView.releaseLabel.textColor = .white
    titleView.releaseLabel.highlightedTextColor = UIColor(red:207/255.0, green:240/255, blue:158/255, alpha:1.0)

    self.navigationItem.titleView = titleView
  }
  
  func setupConstraints(){
    tableView.translatesAutoresizingMaskIntoConstraints = false
    let myViews = ["tableView" : tableView]
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0),
      metrics: nil, views: myViews))
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0),
      metrics: nil, views: myViews))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK : table view data source

extension ViewController : UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20;
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
      cell.textLabel?.text = "Text \(indexPath.row+1)"
    return cell
  }
}

// MARK : table view delegate methods

extension ViewController : UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void{
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}

