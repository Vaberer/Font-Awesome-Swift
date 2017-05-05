# Font Awesome Swift
![Font Awesome Swift](https://github.com/Vaberer/Font-Awesome-Swift/blob/master/resources/opensource_matters.png)

Follow me: [@vaberer](https://twitter.com/vaberer)

I like &#9733;. Do not forget to &#9733; this super convenient library.

#There is also a very popular [Google Design Material Icons](https://github.com/Vaberer/Google-Material-Design-Icons-Swift) library which you will love!


##Added ```UISegmentedControl``` & ```UITabbarItem``` & ```UISlider``` & ```UIStepper``` & ```UITextField``` support!


###Updated to Font Awesome 4.7 - Added 41 new icons!


Font Awesome swift library for iOS. No image icons any more. Using Font Awesome Swift library is very easy to use. Look at the demo app which shows all icons and their names or just visit [FontAwesome](http://fortawesome.github.io/Font-Awesome/icons/).


<p align="center">
  <img height="480" src="https://github.com/Vaberer/Font-Awesome-Swift/blob/master/resources/image1.png"/>
</p>

## Requirements

- iOS 8.0+
- Xcode 8

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

pod 'Font-Awesome-Swift', '~> 1.6.2'
```

Then, run the following command:

```bash
$ pod install
```
Do not forget to import to your swift files where you want to use this library:
```swift
import Font_Awesome_Swift
```

Check branches `swift-2.2` and `swift-2.3`

### Manually

1. Copy `FAIcon.swift` and `FontAwesome.ttf` files into your project
2. Check to import `FontAwesome.ttf` in project, "Project" > "Target" > "Copy Bundle Resources"


## Usage

Super easy way how to add an icon.
<p align="center">
  <img height="200" src="https://github.com/Vaberer/Font-Awesome-Swift/blob/master/resources/helper.png"/>
</p>


### UIImage
For Stacked images, please refer [Stacked Icons](http://fontawesome.io/examples/#stacked)
```Swift
    UIImage.init(icon: .FATwitter, size: CGSize(width: 35, height: 35))
    
    // Change colors
    UIImage.init(icon: .FATwitter, size: CGSize(width: 35, height: 35), textColor: .red, backgroundColor: .black)
    
    // Stacked Images With Bigger Background
    UIImage.init(bgIcon: .FASquareO, bgTextColor: .white, topIcon: .FATwitter, topTextColor: .white, bgLarge: true)
    UIImage.init(bgIcon: .FACircle, bgTextColor: .black, topIcon: .FAFlag, topTextColor: .white, bgLarge: true)
    
    // Stacked Images With Smaller Background
    UIImage.init(bgIcon: .FACamera, bgTextColor: .black, topIcon: .FABan, topTextColor: .red, bgLarge: false)

    // Stacked Images With Bigger Background and Custom Size
    UIImage.init(bgIcon: .FASquare, bgTextColor: .black, topIcon: .FATerminal, topTextColor: .white, bgLarge: true, size: CGSize(width: 50, height: 50))

```


### UIImageView
```Swift
    imageView.setFAIconWithName(icon: .FATwitter, textColor: .blue, backgroundColor: .gray)

    imageView.setFAIconWithName(icon: .FATwitter, textColor: .blue)
    
```


### UILabel
```Swift
    labelName.FAIcon = .FAGithub

    labelName.setFAIcon(icon: .FAGithub, iconSize: 35)

    labelName.setFAText(prefixText: "follow me on ", icon: .FATwitter, postfixText: ". Thanks!", size: 25)

    // Bigger icon:
    labelName.setFAText(prefixText: "follow me on  ", icon: .FATwitter, postfixText: ". Thanks!", size: 25, iconSize: 30)

    labelName.setFAColor(.red)
    
```


### UIButton
```Swift
    buttonName.setFAIcon(icon: .FAGithub, forState: .normal)

    // Set icon size
    buttonName.setFAIcon(icon: .FAGithub, iconSize: 35, forState: .normal)

    buttonName.setFAText(prefixText: "follow me on ", icon: .FATwitter, postfixText: ". Thanks!", size: 25, forState: .normal)

    // Bigger icon
    buttonName.setFAText(prefixText: "follow me on ", icon: .FATwitter, postfixText: ". Thanks!", size: 25, forState: .normal, iconSize: 30)

    // Change color:
    buttonName.setFATitleColor(color: .red, forState: .normal))
    
```


### UIBarButtonItem
```Swift
    // Standard font size
    barName.FAIcon = .FAGithub

    // Custom font size
    barName.setFAIcon(icon: .FAGithub, iconSize: 35)

    barName.setFAText(prefixText: "follow me on ", icon: .FATwitter, postfixText: ". Thanks!", size: 25)

    barName.tintColor = .red

```


### UITextField
```Swift
    // Right View Icon
    textfield.setRightViewFAIcon(icon: .FASearch, rightViewMode: .always, textColor: .red, backgroundColor: .clear, size: nil)

    // Left View Icon
    textfield.setLeftViewFAIcon(icon: .FAPlus, leftViewMode: .always, textColor: .red, backgroundColor: .clear, size: nil)

```


### UISegmentedControl
```Swift
  segmentedControl.setFAIcon(icon: .FATwitter, forSegmentAtIndex: 0)
  
```


### UIStepper
```Swift
    stepper.setFABackgroundImage(icon: .FAGithub, forState: .normal)
    stepper.setFAIncrementImage(icon: .FABellO, forState: .normal)
    stepper.setFADecrementImage(icon: .FABellSlashO, forState: .normal)
    

```


### UITabbarItem
```Swift
  tabBarController?.tabBar.items?.first?.setFAIcon(.FATwitter)
  
  // Options to change selected and unselected color
  tabBarItem.setFAIcon(icon: .FATwitter, size: nil, textColor: .red, backgroundColor: .black, selectedTextColor: .yellow, selectedBackgroundColor: .white)
  
  // Options to change selected and unselected color with specific size
  tabBarItem.setFAIcon(icon: .FATwitter, size: CGSize(width: 35, height: 35), textColor: .red, backgroundColor: .black, selectedTextColor: .yellow, selectedBackgroundColor: .white)
  
```


### UISlider
```Swift
  // Change minimum or maximum value image
  slider.setFAMinimumValueImage(icon: .FABellSlashO)
  slider.setFAMaximumValueImage(icon: .FABellO)

  // change minimum or maximum value image with a specific size
  slider.setFAMinimumValueImage(icon: .FABellSlashO, customSize:  CGSize(width: 35, height: 35))
  slider.setFAMaximumValueImage(icon: .FABellO, customSize:  CGSize(width: 35, height: 35))
  
```


### UIViewController
```Swift
  // Change navigation title
  FATitle = .FATwitter
  
```


## Author

Patrik Vaberer, patrik@toptal.com

- [LinkedIn](https://sk.linkedin.com/in/vaberer)
- [@vaberer](https://twitter.com/vaberer)
- [Blog](http://vaberer.me)

### Licence

Font Awesome Swift is available under the MIT license. See the LICENSE file for more info.
