# Font Awesome Swift
![Font Awesome Swift](https://github.com/Vaberer/Font-Awesome-Swift/blob/master/resources/opensource_matters.png)

Follow me: [@vaberer](https://twitter.com/vaberer)

I like &#9733;. Do not forget to &#9733; this super convenient library.

#There is also a very popular [Google Design Material Icons](https://github.com/Vaberer/Google-Material-Design-Icons-Swift) library which you will love!


##Added ```UISegmentedControl``` & ```UITabbarItem``` & ```UISlider``` support!


###Updated to Font Awesome 4.6.3 - Added 30 new icons!


Font Awesome swift library for iOS. No image icons any more. Using Font Awesome Swift library is very easy to use. Look at the demo app which shows all icons and their names or just visit [FontAwesome](http://fortawesome.github.io/Font-Awesome/icons/).


<p align="center">
  <img height="480" src="https://github.com/Vaberer/Font-Awesome-Swift/blob/master/resources/image1.png"/>
</p>

## Requirements

- iOS 8.0+ 
- Xcode 7

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Font Awesome Swift into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'Font-Awesome-Swift', '~> 1.4.8'
```

Then, run the following command:

```bash
$ pod install
```
Do not forget to import to your swift files where you want to use this library:
```swift
import Font_Awesome_Swift
```

### Manually

1. Copy `FAIcon.swift` and `FontAwesome.ttf` files into your project
2. Check to import `FontAwesome.ttf` in project, "Project" > "Target" > "Copy Bundle Resources"


## Usage

Super easy way how to add an icon.
<p align="center">
  <img height="200" src="https://github.com/Vaberer/Font-Awesome-Swift/blob/master/resources/helper.png"/>
</p>


### UIImage
```Swift
    imageView.setFAIconWithName(FAType.FATwitter, textColor: UIColor.blueColor(), backgroundColor: UIColor.grayColor())
    
    imageView.setFAIconWithName(FAType.FATwitter, textColor: UIColor.blueColor())
```



### UILabel
```Swift
    labelName.FAIcon = FAType.FAGithub
    
    labelName.setFAIcon(FAType.FAGithub, iconSize: 35)
    
    labelName.setFAText(prefixText: "follow me on ", icon: FAType.FATwitter, postfixText: ". Thanks!", size: 25)
    
    // bigger icon: 
    labelName.setFAText(prefixText: "follow me on  ", icon: FAType.FATwitter, postfixText: ". Thanks!", size: 25, iconSize: 30)
    
    labelName.setFAColor(UIColor.redColor())
        
```

### UIButton
```Swift
    buttonName.setFAIcon(FAType.FAGithub, forState: .Normal)
    
    // set an icon size
    buttonName.setFAIcon(FAType.FAGithub, iconSize: 35, forState: .Normal)
  
    buttonName.setFAText(prefixText: "follow me on ", icon: FAType.FATwitter, postfixText: ". Thanks!", size: 25, forState: .Normal)
    
    // bigger icon 
    buttonName.setFAText(prefixText: "follow me on ", icon: FAType.FATwitter, postfixText: ". Thanks!", size: 25, forState: .Normal, iconSize: 30)
    
    
    // change a color:
    buttonName.setFATitleColor(UIColor.redColor(), forState: .Normal))
```

### UIBarButtonItem
```Swift
    // Standard font size
    barName.FAIcon = FAType.FAGithub
  
    // Custom font size
    barName.setFAIcon(FAType.FAGithub, iconSize: 35)
    
    barName.setFAText(prefixText: "follow me on ", icon: FAType.FATwitter, postfixText: ". Thanks!", size: 25)
    
    
    barName.tintColor = UIColor.redColor()

```
### UISegmentedControl
```Swift

  segmentedControl.setFAIcon(FAType.FATwitter, forSegmentAtIndex: 0)
```

### UITabbarItem
```Swift
  tabBarController?.tabBar.items?.first?.setFAIcon(FAType.FATwitter)
```

### UISlider
```Swift
  // change minimum or maximum value image
  slider.setFAMinimumValueImage(.FABellSlashO)
  slider.setFAMaximumValueImage(.FABellO)

  // change minimum or maximum value image with a specific size
  slider.setFAMinimumValueImage(.FABellSlashO, customSize:  CGSizeMake(35, 35))
  slider.setFAMaximumValueImage(.FABellO, customSize:  CGSizeMake(35, 35))
```

### UIViewController
```Swift
  // change navigation title
  FATitle = FAType.FATwitter
```


## Author

Patrik Vaberer, patrik@toptal.com

- [LinkedIn](https://sk.linkedin.com/in/vaberer)
- [@vaberer](https://twitter.com/vaberer)
- [Blog](http://vaberer.me)

### Licence

Font Awesome Swift is available under the MIT license. See the LICENSE file for more info.

