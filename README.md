# Font Awesome Swift
![Font Awesome Swift](https://github.com/Vaberer/Font-Awesome-Swift/blob/master/resources/opensource_matters.png)

Follow me: [@vaberer](https://twitter.com/vaberer)

I like &#9733;. Do not forget to &#9733; this super convenient library.

#Updated to Font Awesome 4.4 - Added 66 new icons!


Font Awesome swift library for iOS. No image icons any more. Using Font Awesome Swift library is very easy to use. Look at the demo app which shows all icons and their names or just visit [FontAwesome](http://fortawesome.github.io/Font-Awesome/icons/).


<p align="center">
  <img height="480" src="https://github.com/Vaberer/Font-Awesome-Swift/blob/master/resources/image1.png"/>
</p>

## Requirements

- iOS 8.0+ 
- Xcode 6.3

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

pod 'Font-Awesome-Swift', '~> 1.1.0'
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


### UILabel
```Swift
    labelName.FAIcon = FAType.FAGithub
    
    //or if you want to set an icon size, use:
    labelName.setFAIcon(FAType.FAGithub, iconSize: 35)
    
    labelName.textColor = UIColor.redColor()
```

### UIButton
```Swift
    buttonName.setFAIcon(FAType.FAGithub, forState: .Normal)
    
    //or if you want to set an icon size, use:
    buttonName.setFAIcon(FAType.FAGithub, iconSize: 35, forState: .Normal)
    
    buttonName.setTitleColor(UIColor.redColor(), forState: .Normal)
```

### UIBarButtonItem
```Swift
    //Standard font size
    barName.FAIcon = FAType.FAGithub
  
    //Custom font size
    barName.setFAIcon(FAType.FAGithub, iconSize: 35)
    
    barName.tintColor = UIColor.redColor()
```




## Author

Patrik Vaberer, patrik.vaberer@gmail.com

- [LinkedIn](https://sk.linkedin.com/in/vaberer)
- [@vaberer](https://twitter.com/vaberer)
- [Blog](http://vaberer.me)

### Licence

Font Awesome Swift is available under the MIT license. See the LICENSE file for more info.

