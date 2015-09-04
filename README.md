# PeriscopyPullToRefresh for iOS

Pull-To-Refresh view inspired by Periscope application (written in Swift). It works with UIScrollView and its subclasses.

![](https://raw.github.com/anaglik/PeriscopyPullToRefresh/master/example-pull.gif)

## Usage

Simply create and assign object of PeriscopyTitleView's class as titleView of your current UINavigationItem. 
You can customize font/color of labels presented in that view. Title string is taken directly from UINavigationItem but you can also assign it directly. 

When you "activate" mechanism, refreshAction block is called.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
	let titleView = PeriscopyTitleView(frame: CGRect(x: 0.0, y: 0.0, width: 140.0, height: CGRectGetHeight((self.navigationController?.navigationBar.frame)!)),
	  					  attachToScrollView: tableView, refreshAction: { 
	  					  //your 'refreshing' code 
	})

	//customization
	titleView.titleLabel.textColor = .whiteColor()
	titleView.releaseLabel.textColor = .whiteColor()
	titleView.releaseLabel.highlightedTextColor = UIColor(red:207/255.0, green:240/255, blue:158/255, alpha:1.0)
	titleView.releaseLabel.text = "Release to reload"

	self.navigationItem.titleView = titleView
}

```
If you would like to use loading animation on UINavigationBar, please use methods from PeriscopyNavBarExtension.swift file.
You don't need to add any png file to your asset catalog, 'stripes' are drawn using CoreGraphics.
Example:

```swift
let view = self.navigationController!.navigationBar.startLoadingAnimation()
//keep reference of 'animating' view
//..
self.navigationController?.navigationBar.stopLoadingAnimationWithView(view)  
```    

Demo app is also included.

## Requirements

Swift 2

## Installation

Just drop PeriscopyTitleView.swift file in your project. If you want to use loading animation on UINavigationBar, please add PeriscopyNavBarExtension.swift file as well.
Support for CocoaPods will be added later.

## Author

Andrzej Naglik, dev.an@icloud.com

## License

PeriscopyPullToRefresh is available under the MIT license. See the LICENSE file for more info.
