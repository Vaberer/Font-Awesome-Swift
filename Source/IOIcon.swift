import Foundation
import UIKit


public extension UIBarButtonItem {
    
    /**
     To set an icon, use i.e. `barName.IOIcon = IOType.IOGithub`
     */
    func setIOIcon(icon: IOType, iconSize: CGFloat) {
        FontLoader.loadFontIfNeeded()
        let font = UIFont(name: IOStruct.FontName, size: iconSize)
        assert(font != nil, IOStruct.ErrorAnnounce)
        setTitleTextAttributes([NSFontAttributeName: font!], forState: .Normal)
        title = icon.text
    }
    
    
    /**
     To set an icon, use i.e. `barName.setIOIcon(IOType.IOGithub, iconSize: 35)`
     */
    var IOIcon: IOType? {
        set {
            FontLoader.loadFontIfNeeded()
            let font = UIFont(name: IOStruct.FontName, size: 23)
            assert(font != nil,IOStruct.ErrorAnnounce)
            setTitleTextAttributes([NSFontAttributeName: font!], forState: .Normal)
            title = newValue?.text
        }
        get {
            guard let title = title, index = IOIcons.indexOf(title) else { return nil }
            return IOType(rawValue: index)
        }
    }
    
    
    func setIOText(prefixText prefixText: String, icon: IOType?, postfixText: String, size: CGFloat) {
        FontLoader.loadFontIfNeeded()
        let font = UIFont(name: IOStruct.FontName, size: size)
        assert(font != nil, IOStruct.ErrorAnnounce)
        setTitleTextAttributes([NSFontAttributeName: font!], forState: .Normal)
        
        var text = prefixText
        if let iconText = icon?.text {
            text += iconText
        }
        text += postfixText
        title = text
    }
}

public extension UIButton {
    
    /**
     To set an icon, use i.e. `buttonName.setIOIcon(IOType.IOGithub, forState: .Normal)`
     */
    func setIOIcon(icon: IOType, forState state: UIControlState) {
        FontLoader.loadFontIfNeeded()
        guard let titleLabel = titleLabel else { return }
        setAttributedTitle(nil, forState: state)
        let font = UIFont(name: IOStruct.FontName, size: titleLabel.font.pointSize)
        assert(font != nil, IOStruct.ErrorAnnounce)
        titleLabel.font = font!
        setTitle(icon.text, forState: state)
    }
    
    
    /**
     To set an icon, use i.e. `buttonName.setIOIcon(IOType.IOGithub, iconSize: 35, forState: .Normal)`
     */
    func setIOIcon(icon: IOType, iconSize: CGFloat, forState state: UIControlState) {
        setIOIcon(icon, forState: state)
        guard let fontName = titleLabel?.font.fontName else { return }
        titleLabel?.font = UIFont(name: fontName, size: iconSize)
    }
    
    
    func setIOText(prefixText prefixText: String, icon: IOType?, postfixText: String, size: CGFloat?, forState state: UIControlState, iconSize: CGFloat? = nil) {
        setTitle(nil, forState: state)
        FontLoader.loadFontIfNeeded()
        guard let titleLabel = titleLabel else { return }
        let attributedText = attributedTitleForState(.Normal) ?? NSAttributedString()
        let  startFont =  attributedText.length == 0 ? nil : attributedText.attribute(NSFontAttributeName, atIndex: 0, effectiveRange: nil) as? UIFont
        let endFont = attributedText.length == 0 ? nil : attributedText.attribute(NSFontAttributeName, atIndex: attributedText.length - 1, effectiveRange: nil) as? UIFont
        var textFont = titleLabel.font
        if let f = startFont where f.fontName != IOStruct.FontName  {
            textFont = f
        } else if let f = endFont where f.fontName != IOStruct.FontName  {
            textFont = f
        }
        let textAttribute = [NSFontAttributeName:textFont]
        let prefixTextAttribured = NSMutableAttributedString(string: prefixText, attributes: textAttribute)
        
        if let iconText = icon?.text {
            let iconFont = UIFont(name: IOStruct.FontName, size: iconSize ?? size ?? titleLabel.font.pointSize)!
            let iconAttribute = [NSFontAttributeName:iconFont]
            
            let iconString = NSAttributedString(string: iconText, attributes: iconAttribute)
            prefixTextAttribured.appendAttributedString(iconString)
        }
        let postfixTextAttributed = NSAttributedString(string: postfixText, attributes: textAttribute)
        prefixTextAttribured.appendAttributedString(postfixTextAttributed)
        
        setAttributedTitle(prefixTextAttribured, forState: state)
    }
    
    
    func setIOTitleColor(color: UIColor, forState state: UIControlState = .Normal) {
        FontLoader.loadFontIfNeeded()
 
        let attributedString = NSMutableAttributedString(attributedString: attributedTitleForState(state) ?? NSAttributedString())
        attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, attributedString.length))
       
        setAttributedTitle(attributedString, forState: state)
        setTitleColor(color, forState: state)
    }
}


public extension UILabel {
    
    /**
     To set an icon, use i.e. `labelName.IOIcon = IOType.IOGithub`
     */
    var IOIcon: IOType? {
        set {
            guard let newValue = newValue else { return }
                FontLoader.loadFontIfNeeded()
                let fontAwesome = UIFont(name: IOStruct.FontName, size: self.font.pointSize)
                assert(font != nil, IOStruct.ErrorAnnounce)
                font = fontAwesome!
                text = newValue.text
        }
        get {
            guard let text = text, index = IOIcons.indexOf(text) else { return nil }
            return IOType(rawValue: index)
        }
    }
    
    /**
     To set an icon, use i.e. `labelName.setIOIcon(IOType.IOGithub, iconSize: 35)`
     */
    func setIOIcon(icon: IOType, iconSize: CGFloat) {
        IOIcon = icon
        font = UIFont(name: font.fontName, size: iconSize)
    }
    
    
    func setIOColor(color: UIColor) {
        FontLoader.loadFontIfNeeded()
        let attributedString = NSMutableAttributedString(attributedString: attributedText ?? NSAttributedString())
        attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, attributedText!.length))
        textColor = color
    }
    
    
    func setIOText(prefixText prefixText: String, icon: IOType?, postfixText: String, size: CGFloat?, iconSize: CGFloat? = nil) {
        text = nil
        FontLoader.loadFontIfNeeded()
        
        let attrText = attributedText ?? NSAttributedString()
        let startFont = attrText.length == 0 ? nil : attrText.attribute(NSFontAttributeName, atIndex: 0, effectiveRange: nil) as? UIFont
        let endFont = attrText.length == 0 ? nil : attrText.attribute(NSFontAttributeName, atIndex: attrText.length - 1, effectiveRange: nil) as? UIFont
        var textFont = font
        if let f = startFont where f.fontName != IOStruct.FontName  {
            textFont = f
        } else if let f = endFont where f.fontName != IOStruct.FontName  {
            textFont = f
        }
        let textAttribute = [NSFontAttributeName : textFont]
        let prefixTextAttribured = NSMutableAttributedString(string: prefixText, attributes: textAttribute)
        
        if let iconText = icon?.text {
            let iconFont = UIFont(name: IOStruct.FontName, size: iconSize ?? size ?? font.pointSize)!
            let iconAttribute = [NSFontAttributeName : iconFont]
            
            let iconString = NSAttributedString(string: iconText, attributes: iconAttribute)
            prefixTextAttribured.appendAttributedString(iconString)
        }
        let postfixTextAttributed = NSAttributedString(string: postfixText, attributes: textAttribute)
        prefixTextAttribured.appendAttributedString(postfixTextAttributed)
        
        attributedText = prefixTextAttribured
    }
    
}


// Original idea from https://github.com/thii/FontAwesome.swift/blob/master/FontAwesome/FontAwesome.swift
public extension UIImageView {
    
    /**
     Create UIImage from IOType
     */
    public func setIOIconWithName(icon: IOType, textColor: UIColor, backgroundColor: UIColor = UIColor.clearColor()) {
        FontLoader.loadFontIfNeeded()
        self.image = UIImage(icon: icon, size: frame.size, textColor: textColor, backgroundColor: backgroundColor)
    }
}


public extension UITabBarItem {
    
    public func setIOIcon(icon: IOType) {
        FontLoader.loadFontIfNeeded()
        image = UIImage(icon: icon, size: CGSize(width: 30, height: 30))
    }
}


public extension UISegmentedControl {
    
    public func setIOIcon(icon: IOType, forSegmentAtIndex segment: Int) {
        FontLoader.loadFontIfNeeded()
        let font = UIFont(name: IOStruct.FontName, size: 23)
        assert(font != nil, IOStruct.ErrorAnnounce)
        setTitleTextAttributes([NSFontAttributeName: font!], forState: .Normal)
        setTitle(icon.text, forSegmentAtIndex: segment)
    }
}


public extension UIImage {
    
    public convenience init(icon: IOType, size: CGSize, textColor: UIColor = UIColor.blackColor(), backgroundColor: UIColor = UIColor.clearColor()) {
        FontLoader.loadFontIfNeeded()
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.Center
        
        let fontAspectRatio: CGFloat = 1.28571429
        let fontSize = min(size.width / fontAspectRatio, size.height)
        let font = UIFont(name: IOStruct.FontName, size: fontSize)
        assert(font != nil, IOStruct.ErrorAnnounce)
        let attributes = [NSFontAttributeName: font!, NSForegroundColorAttributeName: textColor, NSBackgroundColorAttributeName: backgroundColor, NSParagraphStyleAttributeName: paragraph]
        
        let attributedString = NSAttributedString(string: icon.text!, attributes: attributes)
        UIGraphicsBeginImageContextWithOptions(size, false , 0.0)
        attributedString.drawInRect(CGRectMake(0, (size.height - fontSize) / 2, size.width, fontSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = image {
            self.init(CGImage: image.CGImage!, scale: image.scale, orientation: image.imageOrientation)
        } else {
            self.init()
        }
    }
}


public extension UISlider {
    
    func setIOMaximumValueImage(icon: IOType, customSize: CGSize? = nil) {
        maximumValueImage = UIImage(icon: icon, size: customSize ?? CGSizeMake(25, 25))
    }
    
    
    func setIOMinimumValueImage(icon: IOType, customSize: CGSize? = nil) {
        minimumValueImage = UIImage(icon: icon, size: customSize ?? CGSizeMake(25, 25))
    }
}


public extension UIViewController {
    var IOTitle: IOType? {
        set {
            FontLoader.loadFontIfNeeded()
            let font = UIFont(name: IOStruct.FontName, size: 23)
            assert(font != nil,IOStruct.ErrorAnnounce)
            navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font!]
            title = newValue?.text
        }
        get {
            guard let title = title, index = IOIcons.indexOf(title) else { return nil }
            return IOType(rawValue: index)
        }
    }
}


private struct IOStruct {
    
    static let FontName = "ionicons"
    static let ErrorAnnounce = "****** ION ICON FONT SWIFT - IonIcons font not found in the bundle or not associated with Info.plist when manual installation was performed. ******"
}


private class FontLoader {
    
    struct Static {
        static var onceToken : dispatch_once_t = 0
    }
    
    static func loadFontIfNeeded() {
        if (UIFont.fontNamesForFamilyName(IOStruct.FontName).count == 0) {
            
            dispatch_once(&Static.onceToken) {
                let bundle = NSBundle(forClass: FontLoader.self)
                var fontURL = NSURL()
                let identifier = bundle.bundleIdentifier
                
                if identifier?.hasPrefix("org.cocoapods") == true {
                    
                    fontURL = bundle.URLForResource(IOStruct.FontName, withExtension: "ttf", subdirectory: "Font-Awesome-Swift.bundle")!
                } else {
                    
                    fontURL = bundle.URLForResource(IOStruct.FontName, withExtension: "ttf")!
                }
                let data = NSData(contentsOfURL: fontURL)!
                
                let provider = CGDataProviderCreateWithCFData(data)
                let font = CGFontCreateWithDataProvider(provider)!
                
                var error: Unmanaged<CFError>?
                if !CTFontManagerRegisterGraphicsFont(font, &error) {
                    
                    let errorDescription: CFStringRef = CFErrorCopyDescription(error!.takeUnretainedValue())
                    let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
                    NSException(name: NSInternalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
                }
            }
        }
    }
}


/**
 List of all icons in Font Awesome
 */
public enum IOType: Int {
    
    static var count: Int {
        
        return IOIcons.count
    }
    
    
    var text: String? {
        
        return IOIcons[rawValue]
    }
    
    case IOAlert, IOAlertCircled, IOAndroidAdd, IOAndroidAddCircle, IOAndroidAlarmClock, IOAndroidAlert, IOAndroidApps, IOAndroidArchive, IOAndroidArrowBack, IOAndroidArrowDown, IOAndroidArrowDropdown, IOAndroidArrowDropdownCircle, IOAndroidArrowDropleft, IOAndroidArrowDropleftCircle, IOAndroidArrowDropright, IOAndroidArrowDroprightCircle, IOAndroidArrowDropup, IOAndroidArrowDropupCircle, IOAndroidArrowForward, IOAndroidArrowUp, IOAndroidAttach, IOAndroidBar, IOAndroidBicycle, IOAndroidBoat, IOAndroidBookmark, IOAndroidBulb, IOAndroidBus, IOAndroidCalendar, IOAndroidCall, IOAndroidCamera, IOAndroidCancel, IOAndroidCar, IOAndroidCart, IOAndroidChat, IOAndroidCheckbox, IOAndroidCheckboxBlank, IOAndroidCheckboxOutline, IOAndroidCheckboxOutlineBlank, IOAndroidCheckmarkCircle, IOAndroidClipboard, IOAndroidClose, IOAndroidCloud, IOAndroidCloudCircle, IOAndroidCloudDone, IOAndroidCloudOutline, IOAndroidColorPalette, IOAndroidCompass, IOAndroidContact, IOAndroidContacts, IOAndroidContract, IOAndroidCreate, IOAndroidDelete, IOAndroidDesktop, IOAndroidDocument, IOAndroidDone, IOAndroidDoneAll, IOAndroidDownload, IOAndroidDrafts, IOAndroidExit, IOAndroidExpand, IOAndroidFavorite, IOAndroidFavoriteOutline, IOAndroidFilm, IOAndroidFolder, IOAndroidFolderOpen, IOAndroidFunnel, IOAndroidGlobe, IOAndroidHand, IOAndroidHangout, IOAndroidHappy, IOAndroidHome, IOAndroidImage, IOAndroidLaptop, IOAndroidList, IOAndroidLocate, IOAndroidLock, IOAndroidMail, IOAndroidMap, IOAndroidMenu, IOAndroidMicrophone, IOAndroidMicrophoneOff, IOAndroidMoreHorizontal, IOAndroidMoreVertical, IOAndroidNavigate, IOAndroidNotifications, IOAndroidNotificationsNone, IOAndroidNotificationsOff, IOAndroidOpen, IOAndroidOptions, IOAndroidPeople, IOAndroidPerson, IOAndroidPersonAdd, IOAndroidPhoneLandscape, IOAndroidPhonePortrait, IOAndroidPin, IOAndroidPlane, IOAndroidPlaystore, IOAndroidPrint, IOAndroidRadioButtonOff, IOAndroidRadioButtonOn, IOAndroidRefresh, IOAndroidRemove, IOAndroidRemoveCircle, IOAndroidRestaurant, IOAndroidSad, IOAndroidSearch, IOAndroidSend, IOAndroidSettings, IOAndroidShare, IOAndroidShareAlt, IOAndroidStar, IOAndroidStarHalf, IOAndroidStarOutline, IOAndroidStopwatch, IOAndroidSubway, IOAndroidSunny, IOAndroidSync, IOAndroidTextsms, IOAndroidTime, IOAndroidTrain, IOAndroidUnlock, IOAndroidUpload, IOAndroidVolumeDown, IOAndroidVolumeMute, IOAndroidVolumeOff, IOAndroidVolumeUp, IOAndroidWalk, IOAndroidWarning, IOAndroidWatch, IOAndroidWifi, IOAperture, IOArchive, IOArrowDownA, IOArrowDownB, IOArrowDownC, IOArrowExpand, IOArrowGraphDownLeft, IOArrowGraphDownRight, IOArrowGraphUpLeft, IOArrowGraphUpRight, IOArrowLeftA, IOArrowLeftB, IOArrowLeftC, IOArrowMove, IOArrowResize, IOArrowReturnLeft, IOArrowReturnRight, IOArrowRightA, IOArrowRightB, IOArrowRightC, IOArrowShrink, IOArrowSwap, IOArrowUpA, IOArrowUpB, IOArrowUpC, IOAsterisk, IOAt, IOBackspace, IOBackspaceOutline, IOBag, IOBatteryCharging, IOBatteryEmpty, IOBatteryFull, IOBatteryHalf, IOBatteryLow, IOBeaker, IOBeer, IOBluetooth, IOBonfire, IOBookmark, IOBowtie, IOBriefcase, IOBug, IOCalculator, IOCalendar, IOCamera, IOCard, IOCash, IOChatbox, IOChatboxWorking, IOChatboxes, IOChatbubble, IOChatbubbleWorking, IOChatbubbles, IOCheckmark, IOCheckmarkCircled, IOCheckmarkRound, IOChevronDown, IOChevronLeft, IOChevronRight, IOChevronUp, IOClipboard, IOClock, IOClose, IOCloseCircled, IOCloseRound, IOClosedCaptioning, IOCloud, IOCode, IOCodeDownload, IOCodeWorking, IOCoffee, IOCompass, IOCompose, IOConnectionBars, IOContrast, IOCrop, IOCube, IODisc, IODocument, IODocumentText, IODrag, IOEarth, IOEasel, IOEdit, IOEgg, IOEject, IOEmail, IOEmailUnread, IOErlenmeyerFlask, IOErlenmeyerFlaskBubbles, IOEye, IOEyeDisabled, IOFemale, IOFiling, IOFilmMarker, IOFireball, IOFlag, IOFlame, IOFlash, IOFlashOff, IOFolder, IOFork, IOForkRepo, IOForward, IOFunnel, IOGearA, IOGearB, IOGrid, IOHammer, IOHappy, IOHappyOutline, IOHeadphone, IOHeart, IOHeartBroken, IOHelp, IOHelpBuoy, IOHelpCircled, IOHome, IOIcecream, IOImage, IOImages, IOInformation, IOInformationCircled, IOIonic, IOiOSAlarm, IOiOSAlarmOutline, IOiOSAlbums, IOiOSAlbumsOutline, IOiOSAmericanfootball, IOiOSAmericanfootballOutline, IOiOSAnalytics, IOiOSAnalyticsOutline, IOiOSArrowBack, IOiOSArrowDown, IOiOSArrowForward, IOiOSArrowLeft, IOiOSArrowRight, IOiOSArrowThinDown, IOiOSArrowThinLeft, IOiOSArrowThinRight, IOiOSArrowThinUp, IOiOSArrowUp, IOiOSAt, IOiOSAtOutline, IOiOSBarcode, IOiOSBarcodeOutline, IOiOSBaseball, IOiOSBaseballOutline, IOiOSBasketball, IOiOSBasketballOutline, IOiOSBell, IOiOSBellOutline, IOiOSBody, IOiOSBodyOutline, IOiOSBolt, IOiOSBoltOutline, IOiOSBook, IOiOSBookOutline, IOiOSBookmarks, IOiOSBookmarksOutline, IOiOSBox, IOiOSBoxOutline, IOiOSBriefcase, IOiOSBriefcaseOutline, IOiOSBrowsers, IOiOSBrowsersOutline, IOiOSCalculator, IOiOSCalculatorOutline, IOiOSCalendar, IOiOSCalendarOutline, IOiOSCamera, IOiOSCameraOutline, IOiOSCart, IOiOSCartOutline, IOiOSChatboxes, IOiOSChatboxesOutline, IOiOSChatbubble, IOiOSChatbubbleOutline, IOiOSCheckmark, IOiOSCheckmarkEmpty, IOiOSCheckmarkOutline, IOiOSCircleFilled, IOiOSCircleOutline, IOiOSClock, IOiOSClockOutline, IOiOSClose, IOiOSCloseEmpty, IOiOSCloseOutline, IOiOSCloud, IOiOSCloudDownload, IOiOSCloudDownloadOutline, IOiOSCloudOutline, IOiOSCloudUpload, IOiOSCloudUploadOutline, IOiOSCloudy, IOiOSCloudyNight, IOiOSCloudyNightOutline, IOiOSCloudyOutline, IOiOSCog, IOiOSCogOutline, IOiOSColorFilter, IOiOSColorFilterOutline, IOiOSColorWand, IOiOSColorWandOutline, IOiOSCompose, IOiOSComposeOutline, IOiOSContact, IOiOSContactOutline, IOiOSCopy, IOiOSCopyOutline, IOiOSCrop, IOiOSCropStrong, IOiOSDownload, IOiOSDownloadOutline, IOiOSDrag, IOiOSEmail, IOiOSEmailOutline, IOiOSEye, IOiOSEyeOutline, IOiOSFastforward, IOiOSFastforwardOutline, IOiOSFiling, IOiOSFilingOutline, IOiOSFilm, IOiOSFilmOutline, IOiOSFlag, IOiOSFlagOutline, IOiOSFlame, IOiOSFlameOutline, IOiOSFlask, IOiOSFlaskOutline, IOiOSFlower, IOiOSFlowerOutline, IOiOSFolder, IOiOSFolderOutline, IOiOSFootball, IOiOSFootballOutline, IOiOSGameControllerA, IOiOSGameControllerAOutline, IOiOSGameControllerB, IOiOSGameControllerBOutline, IOiOSGear, IOiOSGearOutline, IOiOSGlasses, IOiOSGlassesOutline, IOiOSGridView, IOiOSGridViewOutline, IOiOSHeart, IOiOSHeartOutline, IOiOSHelp, IOiOSHelpEmpty, IOiOSHelpOutline, IOiOSHome, IOiOSHomeOutline, IOiOSInfinite, IOiOSInfiniteOutline, IOiOSInformation, IOiOSInformationEmpty, IOiOSInformationOutline, IOiOSIonicOutline, IOiOSKeypad, IOiOSKeypadOutline, IOiOSLightbulb, IOiOSLightbulbOutline, IOiOSList, IOiOSListOutline, IOiOSLocation, IOiOSLocationOutline, IOiOSLocked, IOiOSLockedOutline, IOiOSLoop, IOiOSLoopStrong, IOiOSMedical, IOiOSMedicalOutline, IOiOSMedkit, IOiOSMedkitOutline, IOiOSMic, IOiOSMicOff, IOiOSMicOutline, IOiOSMinus, IOiOSMinusEmpty, IOiOSMinusOutline, IOiOSMonitor, IOiOSMonitorOutline, IOiOSMoon, IOiOSMoonOutline, IOiOSMore, IOiOSMoreOutline, IOiOSMusicalNote, IOiOSMusicalNotes, IOiOSNavigate, IOiOSNavigateOutline, IOiOSNutrition, IOiOSNutritionOutline, IOiOSPaper, IOiOSPaperOutline, IOiOSPaperplane, IOiOSPaperplaneOutline, IOiOSPartlysunny, IOiOSPartlysunnyOutline, IOiOSPause, IOiOSPauseOutline, IOiOSPaw, IOiOSPawOutline, IOiOSPeople, IOiOSPeopleOutline, IOiOSPerson, IOiOSPersonOutline, IOiOSPersonadd, IOiOSPersonaddOutline, IOiOSPhotos, IOiOSPhotosOutline, IOiOSPie, IOiOSPieOutline, IOiOSPint, IOiOSPintOutline, IOiOSPlay, IOiOSPlayOutline, IOiOSPlus, IOiOSPlusEmpty, IOiOSPlusOutline, IOiOSPricetag, IOiOSPricetagOutline, IOiOSPricetags, IOiOSPricetagsOutline, IOiOSPrinter, IOiOSPrinterOutline, IOiOSPulse, IOiOSPulseStrong, IOiOSRainy, IOiOSRainyOutline, IOiOSRecording, IOiOSRecordingOutline, IOiOSRedo, IOiOSRedoOutline, IOiOSRefresh, IOiOSRefreshEmpty, IOiOSRefreshOutline, IOiOSReload, IOiOSReverseCamera, IOiOSReverseCameraOutline, IOiOSRewind, IOiOSRewindOutline, IOiOSRose, IOiOSRoseOutline, IOiOSSearch, IOiOSSearchStrong, IOiOSSettings, IOiOSSettingsStrong, IOiOSShuffle, IOiOSShuffleStrong, IOiOSSkipbackward, IOiOSSkipbackwardOutline, IOiOSSkipforward, IOiOSSkipforwardOutline, IOiOSSnowy, IOiOSSpeedometer, IOiOSSpeedometerOutline, IOiOSStar, IOiOSStarHalf, IOiOSStarOutline, IOiOSStopwatch, IOiOSStopwatchOutline, IOiOSSunny, IOiOSSunnyOutline, IOiOSTelephone, IOiOSTelephoneOutline, IOiOSTennisball, IOiOSTennisballOutline, IOiOSThunderstorm, IOiOSThunderstormOutline, IOiOSTime, IOiOSTimeOutline, IOiOSTimer, IOiOSTimerOutline, IOiOSToggle, IOiOSToggleOutline, IOiOSTrash, IOiOSTrashOutline, IOiOSUndo, IOiOSUndoOutline, IOiOSUnlocked, IOiOSUnlockedOutline, IOiOSUpload, IOiOSUploadOutline, IOiOSVideocam, IOiOSVideocamOutline, IOiOSVolumeHigh, IOiOSVolumeLow, IOiOSWineglass, IOiOSWineglassOutline, IOiOSWorld, IOiOSWorldOutline, IOIpad, IOIphone, IOIpod, IOJet, IOKey, IOKnife, IOLaptop, IOLeaf, IOLevels, IOLightbulb, IOLink, IOLoadA, IOLoadB, IOLoadC, IOLoadD, IOLocation, IOLockCombination, IOLocked, IOLogIn, IOLogOut, IOLoop, IOMagnet, IOMale, IOMan, IOMap, IOMedkit, IOMerge, IOMicA, IOMicB, IOMicC, IOMinus, IOMinusCircled, IOMinusRound, IOModelS, IOMonitor, IOMore, IOMouse, IOMusicNote, IONavicon, IONaviconRound, IONavigate, IONetwork, IONoSmoking, IONuclear, IOOutlet, IOPaintbrush, IOPaintbucket, IOPaperAirplane, IOPaperclip, IOPause, IOPerson, IOPersonAdd, IOPersonStalker, IOPieGraph, IOPin, IOPinpoint, IOPizza, IOPlane, IOPlanet, IOPlay, IOPlaystation, IOPlus, IOPlusCircled, IOPlusRound, IOPodium, IOPound, IOPower, IOPricetag, IOPricetags, IOPrinter, IOPullRequest, IOQrScanner, IOQuote, IORadioWaves, IORecord, IORefresh, IOReply, IOReplyAll, IORibbonA, IORibbonB, IOSad, IOSadOutline, IOScissors, IOSearch, IOSettings, IOShare, IOShuffle, IOSkipBackward, IOSkipForward, IOSocialAndroid, IOSocialAndroidOutline, IOSocialAngular, IOSocialAngularOutline, IOSocialApple, IOSocialAppleOutline, IOSocialBitcoin, IOSocialBitcoinOutline, IOSocialBuffer, IOSocialBufferOutline, IOSocialChrome, IOSocialChromeOutline, IOSocialCodepen, IOSocialCodepenOutline, IOSocialCss3, IOSocialCss3Outline, IOSocialDesignernews, IOSocialDesignernewsOutline, IOSocialDribbble, IOSocialDribbbleOutline, IOSocialDropbox, IOSocialDropboxOutline, IOSocialEuro, IOSocialEuroOutline, IOSocialFacebook, IOSocialFacebookOutline, IOSocialFoursquare, IOSocialFoursquareOutline, IOSocialFreebsdDevil, IOSocialGithub, IOSocialGithubOutline, IOSocialGoogle, IOSocialGoogleOutline, IOSocialGoogleplus, IOSocialGoogleplusOutline, IOSocialHackernews, IOSocialHackernewsOutline, IOSocialHtml5, IOSocialHtml5Outline, IOSocialInstagram, IOSocialInstagramOutline, IOSocialJavascript, IOSocialJavascriptOutline, IOSocialLinkedin, IOSocialLinkedinOutline, IOSocialMarkdown, IOSocialNodejs, IOSocialOctocat, IOSocialPinterest, IOSocialPinterestOutline, IOSocialPython, IOSocialReddit, IOSocialRedditOutline, IOSocialRss, IOSocialRssOutline, IOSocialSass, IOSocialSkype, IOSocialSkypeOutline, IOSocialSnapchat, IOSocialSnapchatOutline, IOSocialTumblr, IOSocialTumblrOutline, IOSocialTux, IOSocialTwitch, IOSocialTwitchOutline, IOSocialTwitter, IOSocialTwitterOutline, IOSocialUsd, IOSocialUsdOutline, IOSocialVimeo, IOSocialVimeoOutline, IOSocialWhatsapp, IOSocialWhatsappOutline, IOSocialWindows, IOSocialWindowsOutline, IOSocialWordpress, IOSocialWordpressOutline, IOSocialYahoo, IOSocialYahooOutline, IOSocialYen, IOSocialYenOutline, IOSocialYoutube, IOSocialYoutubeOutline, IOSoupCan, IOSoupCanOutline, IOSpeakerphone, IOSpeedometer, IOSpoon, IOStar, IOStatsBars, IOSteam, IOStop, IOThermometer, IOThumbsdown, IOThumbsup, IOToggle, IOToggleFilled, IOTransgender, IOTrashA, IOTrashB, IOTrophy, IOTshirt, IOTshirtOutline, IOUmbrella, IOUniversity, IOUnlocked, IOUpload, IOUsb, IOVideocamera, IOVolumeHigh, IOVolumeLow, IOVolumeMedium, IOVolumeMute, IOWand, IOWaterdrop, IOWifi, IOWineglass, IOWoman, IOWrench, IOXbox
    
}

private let IOIcons = ["\u{f101}", "\u{f100}", "\u{f2c7}", "\u{f359}", "\u{f35a}", "\u{f35b}", "\u{f35c}", "\u{f2c9}", "\u{f2ca}", "\u{f35d}", "\u{f35f}", "\u{f35e}", "\u{f361}", "\u{f360}", "\u{f363}", "\u{f362}", "\u{f365}", "\u{f364}", "\u{f30f}", "\u{f366}", "\u{f367}", "\u{f368}", "\u{f369}", "\u{f36a}", "\u{f36b}", "\u{f36c}", "\u{f36d}", "\u{f2d1}", "\u{f2d2}", "\u{f2d3}", "\u{f36e}", "\u{f36f}", "\u{f370}", "\u{f2d4}", "\u{f374}", "\u{f371}", "\u{f373}", "\u{f372}", "\u{f375}", "\u{f376}", "\u{f2d7}", "\u{f37a}", "\u{f377}", "\u{f378}", "\u{f379}", "\u{f37b}", "\u{f37c}", "\u{f2d8}", "\u{f2d9}", "\u{f37d}", "\u{f37e}", "\u{f37f}", "\u{f380}", "\u{f381}", "\u{f383}", "\u{f382}", "\u{f2dd}", "\u{f384}", "\u{f385}", "\u{f386}", "\u{f388}", "\u{f387}", "\u{f389}", "\u{f2e0}", "\u{f38a}", "\u{f38b}", "\u{f38c}", "\u{f2e3}", "\u{f38d}", "\u{f38e}", "\u{f38f}", "\u{f2e4}", "\u{f390}", "\u{f391}", "\u{f2e9}", "\u{f392}", "\u{f2eb}", "\u{f393}", "\u{f394}", "\u{f2ec}", "\u{f395}", "\u{f396}", "\u{f397}", "\u{f398}", "\u{f39b}", "\u{f399}", "\u{f39a}", "\u{f39c}", "\u{f39d}", "\u{f39e}", "\u{f3a0}", "\u{f39f}", "\u{f3a1}", "\u{f3a2}", "\u{f3a3}", "\u{f3a4}", "\u{f2f0}", "\u{f3a5}", "\u{f3a6}", "\u{f3a7}", "\u{f3a8}", "\u{f2f4}", "\u{f3a9}", "\u{f3aa}", "\u{f3ab}", "\u{f2f5}", "\u{f2f6}", "\u{f2f7}", "\u{f2f8}", "\u{f3ac}", "\u{f2fc}", "\u{f3ad}", "\u{f3ae}", "\u{f2fd}", "\u{f3af}", "\u{f3b0}", "\u{f3b1}", "\u{f3b2}", "\u{f3b3}", "\u{f3b4}", "\u{f3b5}", "\u{f3b6}", "\u{f3b7}", "\u{f3b8}", "\u{f3b9}", "\u{f3ba}", "\u{f3bb}", "\u{f3bc}", "\u{f3bd}", "\u{f305}", "\u{f313}", "\u{f102}", "\u{f103}", "\u{f104}", "\u{f105}", "\u{f25e}", "\u{f25f}", "\u{f260}", "\u{f261}", "\u{f262}", "\u{f106}", "\u{f107}", "\u{f108}", "\u{f263}", "\u{f264}", "\u{f265}", "\u{f266}", "\u{f109}", "\u{f10a}", "\u{f10b}", "\u{f267}", "\u{f268}", "\u{f10c}", "\u{f10d}", "\u{f10e}", "\u{f314}", "\u{f10f}", "\u{f3bf}", "\u{f3be}", "\u{f110}", "\u{f111}", "\u{f112}", "\u{f113}", "\u{f114}", "\u{f115}", "\u{f269}", "\u{f26a}", "\u{f116}", "\u{f315}", "\u{f26b}", "\u{f3c0}", "\u{f26c}", "\u{f2be}", "\u{f26d}", "\u{f117}", "\u{f118}", "\u{f119}", "\u{f316}", "\u{f11b}", "\u{f11a}", "\u{f11c}", "\u{f11e}", "\u{f11d}", "\u{f11f}", "\u{f122}", "\u{f120}", "\u{f121}", "\u{f123}", "\u{f124}", "\u{f125}", "\u{f126}", "\u{f127}", "\u{f26e}", "\u{f12a}", "\u{f128}", "\u{f129}", "\u{f317}", "\u{f12b}", "\u{f271}", "\u{f26f}", "\u{f270}", "\u{f272}", "\u{f273}", "\u{f12c}", "\u{f274}", "\u{f275}", "\u{f3c1}", "\u{f318}", "\u{f12d}", "\u{f12f}", "\u{f12e}", "\u{f130}", "\u{f276}", "\u{f3c2}", "\u{f2bf}", "\u{f277}", "\u{f131}", "\u{f132}", "\u{f3c3}", "\u{f3c5}", "\u{f3c4}", "\u{f133}", "\u{f306}", "\u{f278}", "\u{f134}", "\u{f135}", "\u{f319}", "\u{f279}", "\u{f31a}", "\u{f137}", "\u{f136}", "\u{f139}", "\u{f27a}", "\u{f2c0}", "\u{f13a}", "\u{f31b}", "\u{f13d}", "\u{f13e}", "\u{f13f}", "\u{f27b}", "\u{f31c}", "\u{f3c6}", "\u{f140}", "\u{f141}", "\u{f31d}", "\u{f143}", "\u{f27c}", "\u{f142}", "\u{f144}", "\u{f27d}", "\u{f147}", "\u{f148}", "\u{f14a}", "\u{f149}", "\u{f14b}", "\u{f3c8}", "\u{f3c7}", "\u{f3ca}", "\u{f3c9}", "\u{f3cc}", "\u{f3cb}", "\u{f3ce}", "\u{f3cd}", "\u{f3cf}", "\u{f3d0}", "\u{f3d1}", "\u{f3d2}", "\u{f3d3}", "\u{f3d4}", "\u{f3d5}", "\u{f3d6}", "\u{f3d7}", "\u{f3d8}", "\u{f3da}", "\u{f3d9}", "\u{f3dc}", "\u{f3db}", "\u{f3de}", "\u{f3dd}", "\u{f3e0}", "\u{f3df}", "\u{f3e2}", "\u{f3e1}", "\u{f3e4}", "\u{f3e3}", "\u{f3e6}", "\u{f3e5}", "\u{f3e8}", "\u{f3e7}", "\u{f3ea}", "\u{f3e9}", "\u{f3ec}", "\u{f3eb}", "\u{f3ee}", "\u{f3ed}", "\u{f3f0}", "\u{f3ef}", "\u{f3f2}", "\u{f3f1}", "\u{f3f4}", "\u{f3f3}", "\u{f3f6}", "\u{f3f5}", "\u{f3f8}", "\u{f3f7}", "\u{f3fa}", "\u{f3f9}", "\u{f3fc}", "\u{f3fb}", "\u{f3ff}", "\u{f3fd}", "\u{f3fe}", "\u{f400}", "\u{f401}", "\u{f403}", "\u{f402}", "\u{f406}", "\u{f404}", "\u{f405}", "\u{f40c}", "\u{f408}", "\u{f407}", "\u{f409}", "\u{f40b}", "\u{f40a}", "\u{f410}", "\u{f40e}", "\u{f40d}", "\u{f40f}", "\u{f412}", "\u{f411}", "\u{f414}", "\u{f413}", "\u{f416}", "\u{f415}", "\u{f418}", "\u{f417}", "\u{f41a}", "\u{f419}", "\u{f41c}", "\u{f41b}", "\u{f41e}", "\u{f41d}", "\u{f420}", "\u{f41f}", "\u{f421}", "\u{f423}", "\u{f422}", "\u{f425}", "\u{f424}", "\u{f427}", "\u{f426}", "\u{f429}", "\u{f428}", "\u{f42b}", "\u{f42a}", "\u{f42d}", "\u{f42c}", "\u{f42f}", "\u{f42e}", "\u{f431}", "\u{f430}", "\u{f433}", "\u{f432}", "\u{f435}", "\u{f434}", "\u{f437}", "\u{f436}", "\u{f439}", "\u{f438}", "\u{f43b}", "\u{f43a}", "\u{f43d}", "\u{f43c}", "\u{f43f}", "\u{f43e}", "\u{f441}", "\u{f440}", "\u{f443}", "\u{f442}", "\u{f446}", "\u{f444}", "\u{f445}", "\u{f448}", "\u{f447}", "\u{f44a}", "\u{f449}", "\u{f44d}", "\u{f44b}", "\u{f44c}", "\u{f44e}", "\u{f450}", "\u{f44f}", "\u{f452}", "\u{f451}", "\u{f454}", "\u{f453}", "\u{f456}", "\u{f455}", "\u{f458}", "\u{f457}", "\u{f45a}", "\u{f459}", "\u{f45c}", "\u{f45b}", "\u{f45e}", "\u{f45d}", "\u{f461}", "\u{f45f}", "\u{f460}", "\u{f464}", "\u{f462}", "\u{f463}", "\u{f466}", "\u{f465}", "\u{f468}", "\u{f467}", "\u{f46a}", "\u{f469}", "\u{f46b}", "\u{f46c}", "\u{f46e}", "\u{f46d}", "\u{f470}", "\u{f46f}", "\u{f472}", "\u{f471}", "\u{f474}", "\u{f473}", "\u{f476}", "\u{f475}", "\u{f478}", "\u{f477}", "\u{f47a}", "\u{f479}", "\u{f47c}", "\u{f47b}", "\u{f47e}", "\u{f47d}", "\u{f480}", "\u{f47f}", "\u{f482}", "\u{f481}", "\u{f484}", "\u{f483}", "\u{f486}", "\u{f485}", "\u{f488}", "\u{f487}", "\u{f48b}", "\u{f489}", "\u{f48a}", "\u{f48d}", "\u{f48c}", "\u{f48f}", "\u{f48e}", "\u{f491}", "\u{f490}", "\u{f493}", "\u{f492}", "\u{f495}", "\u{f494}", "\u{f497}", "\u{f496}", "\u{f499}", "\u{f498}", "\u{f49c}", "\u{f49a}", "\u{f49b}", "\u{f49d}", "\u{f49f}", "\u{f49e}", "\u{f4a1}", "\u{f4a0}", "\u{f4a3}", "\u{f4a2}", "\u{f4a5}", "\u{f4a4}", "\u{f4a7}", "\u{f4a6}", "\u{f4a9}", "\u{f4a8}", "\u{f4ab}", "\u{f4aa}", "\u{f4ad}", "\u{f4ac}", "\u{f4ae}", "\u{f4b0}", "\u{f4af}", "\u{f4b3}", "\u{f4b1}", "\u{f4b2}", "\u{f4b5}", "\u{f4b4}", "\u{f4b7}", "\u{f4b6}", "\u{f4b9}", "\u{f4b8}", "\u{f4bb}", "\u{f4ba}", "\u{f4bd}", "\u{f4bc}", "\u{f4bf}", "\u{f4be}", "\u{f4c1}", "\u{f4c0}", "\u{f4c3}", "\u{f4c2}", "\u{f4c5}", "\u{f4c4}", "\u{f4c7}", "\u{f4c6}", "\u{f4c9}", "\u{f4c8}", "\u{f4cb}", "\u{f4ca}", "\u{f4cd}", "\u{f4cc}", "\u{f4ce}", "\u{f4cf}", "\u{f4d1}", "\u{f4d0}", "\u{f4d3}", "\u{f4d2}", "\u{f1f9}", "\u{f1fa}", "\u{f1fb}", "\u{f295}", "\u{f296}", "\u{f297}", "\u{f1fc}", "\u{f1fd}", "\u{f298}", "\u{f299}", "\u{f1fe}", "\u{f29a}", "\u{f29b}", "\u{f29c}", "\u{f29d}", "\u{f1ff}", "\u{f4d4}", "\u{f200}", "\u{f29e}", "\u{f29f}", "\u{f201}", "\u{f2a0}", "\u{f2a1}", "\u{f202}", "\u{f203}", "\u{f2a2}", "\u{f33f}", "\u{f204}", "\u{f205}", "\u{f206}", "\u{f209}", "\u{f207}", "\u{f208}", "\u{f2c1}", "\u{f20a}", "\u{f20b}", "\u{f340}", "\u{f20c}", "\u{f20e}", "\u{f20d}", "\u{f2a3}", "\u{f341}", "\u{f2c2}", "\u{f2a4}", "\u{f342}", "\u{f4d5}", "\u{f4d6}", "\u{f2c3}", "\u{f20f}", "\u{f210}", "\u{f213}", "\u{f211}", "\u{f212}", "\u{f2a5}", "\u{f2a6}", "\u{f2a7}", "\u{f2a8}", "\u{f214}", "\u{f343}", "\u{f215}", "\u{f30a}", "\u{f218}", "\u{f216}", "\u{f217}", "\u{f344}", "\u{f219}", "\u{f2a9}", "\u{f2aa}", "\u{f2ab}", "\u{f21a}", "\u{f345}", "\u{f346}", "\u{f347}", "\u{f2ac}", "\u{f21b}", "\u{f21c}", "\u{f21e}", "\u{f21d}", "\u{f348}", "\u{f349}", "\u{f34a}", "\u{f4d7}", "\u{f34b}", "\u{f21f}", "\u{f2ad}", "\u{f220}", "\u{f221}", "\u{f222}", "\u{f223}", "\u{f225}", "\u{f224}", "\u{f4d9}", "\u{f4d8}", "\u{f227}", "\u{f226}", "\u{f2af}", "\u{f2ae}", "\u{f229}", "\u{f228}", "\u{f4db}", "\u{f4da}", "\u{f4dd}", "\u{f4dc}", "\u{f4df}", "\u{f4de}", "\u{f22b}", "\u{f22a}", "\u{f22d}", "\u{f22c}", "\u{f22f}", "\u{f22e}", "\u{f4e1}", "\u{f4e0}", "\u{f231}", "\u{f230}", "\u{f34d}", "\u{f34c}", "\u{f2c4}", "\u{f233}", "\u{f232}", "\u{f34f}", "\u{f34e}", "\u{f235}", "\u{f234}", "\u{f237}", "\u{f236}", "\u{f4e3}", "\u{f4e2}", "\u{f351}", "\u{f350}", "\u{f4e5}", "\u{f4e4}", "\u{f239}", "\u{f238}", "\u{f4e6}", "\u{f4e7}", "\u{f4e8}", "\u{f2b1}", "\u{f2b0}", "\u{f4e9}", "\u{f23b}", "\u{f23a}", "\u{f23d}", "\u{f23c}", "\u{f4ea}", "\u{f23f}", "\u{f23e}", "\u{f4ec}", "\u{f4eb}", "\u{f241}", "\u{f240}", "\u{f2c5}", "\u{f4ee}", "\u{f4ed}", "\u{f243}", "\u{f242}", "\u{f353}", "\u{f352}", "\u{f245}", "\u{f244}", "\u{f4f0}", "\u{f4ef}", "\u{f247}", "\u{f246}", "\u{f249}", "\u{f248}", "\u{f24b}", "\u{f24a}", "\u{f4f2}", "\u{f4f1}", "\u{f24d}", "\u{f24c}", "\u{f4f4}", "\u{f4f3}", "\u{f2b2}", "\u{f2b3}", "\u{f2b4}", "\u{f24e}", "\u{f2b5}", "\u{f30b}", "\u{f24f}", "\u{f2b6}", "\u{f250}", "\u{f251}", "\u{f355}", "\u{f354}", "\u{f4f5}", "\u{f252}", "\u{f253}", "\u{f356}", "\u{f4f7}", "\u{f4f6}", "\u{f2b7}", "\u{f357}", "\u{f254}", "\u{f255}", "\u{f2b8}", "\u{f256}", "\u{f257}", "\u{f258}", "\u{f259}", "\u{f25a}", "\u{f358}", "\u{f25b}", "\u{f25c}", "\u{f2b9}", "\u{f25d}", "\u{f2ba}", "\u{f30c}"]