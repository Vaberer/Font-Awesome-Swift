import Foundation
import UIKit

public extension UITextField {
    
    public func setRightViewFAIcon(icon: FAType, rightViewMode: UITextFieldViewMode = .always, orientation: UIImageOrientation = UIImageOrientation.down, textColor: UIColor = .black, backgroundColor: UIColor = .clear, size: CGSize? = nil) {
        FontLoader.loadFontIfNeeded()
        
        let image = UIImage(icon: icon, size: size ?? CGSize(width: 30, height: 30), orientation: orientation, textColor: textColor, backgroundColor: backgroundColor)
        let imageView = UIImageView.init(image: image)
        
        self.rightView = imageView
        self.rightViewMode = rightViewMode
    }
    
    public func setLeftViewFAIcon(icon: FAType, leftViewMode: UITextFieldViewMode = .always, orientation: UIImageOrientation = UIImageOrientation.down, textColor: UIColor = .black, backgroundColor: UIColor = .clear, size: CGSize? = nil) {
        FontLoader.loadFontIfNeeded()
        
        let image = UIImage(icon: icon, size: size ?? CGSize(width: 30, height: 30), orientation: orientation, textColor: textColor, backgroundColor: backgroundColor)
        let imageView = UIImageView.init(image: image)
        
        self.leftView = imageView
        self.leftViewMode = leftViewMode
    }
}

public extension UIBarButtonItem {
    
    /**
     To set an icon, use i.e. `barName.FAIcon = FAType.FAGithub`
     */
    func setFAIcon(icon: FAType, iconSize: CGFloat) {
        FontLoader.loadFontIfNeeded()
        let font = UIFont(name: FAStruct.FontName, size: iconSize)
        assert(font != nil, FAStruct.ErrorAnnounce)
        setTitleTextAttributes([NSFontAttributeName: font!], for: .normal)
        title = icon.text
    }
    
    
    /**
     To set an icon, use i.e. `barName.setFAIcon(FAType.FAGithub, iconSize: 35)`
     */
    var FAIcon: FAType? {
        set {
            FontLoader.loadFontIfNeeded()
            let font = UIFont(name: FAStruct.FontName, size: 23)
            assert(font != nil,FAStruct.ErrorAnnounce)
            setTitleTextAttributes([NSFontAttributeName: font!], for: .normal)
            title = newValue?.text
        }
        get {
            guard let title = title, let index = FAIcons.index(of: title) else { return nil }
            return FAType(rawValue: index)
        }
    }
    
    
    func setFAText(prefixText: String, icon: FAType?, postfixText: String, size: CGFloat) {
        FontLoader.loadFontIfNeeded()
        let font = UIFont(name: FAStruct.FontName, size: size)
        assert(font != nil, FAStruct.ErrorAnnounce)
        setTitleTextAttributes([NSFontAttributeName: font!], for: .normal)
        
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
     To set an icon, use i.e. `buttonName.setFAIcon(FAType.FAGithub, forState: .Normal)`
     */
    func setFAIcon(icon: FAType, forState state: UIControlState) {
        FontLoader.loadFontIfNeeded()
        guard let titleLabel = titleLabel else { return }
        setAttributedTitle(nil, for: state)
        let font = UIFont(name: FAStruct.FontName, size: titleLabel.font.pointSize)
        assert(font != nil, FAStruct.ErrorAnnounce)
        titleLabel.font = font!
        setTitle(icon.text, for: state)
    }
    
    
    /**
     To set an icon, use i.e. `buttonName.setFAIcon(FAType.FAGithub, iconSize: 35, forState: .Normal)`
     */
    func setFAIcon(icon: FAType, iconSize: CGFloat, forState state: UIControlState) {
        setFAIcon(icon: icon, forState: state)
        guard let fontName = titleLabel?.font.fontName else { return }
        titleLabel?.font = UIFont(name: fontName, size: iconSize)
    }
    
    
    func setFAText(prefixText: String, icon: FAType?, postfixText: String, size: CGFloat?, forState state: UIControlState, iconSize: CGFloat? = nil) {
        setTitle(nil, for: state)
        FontLoader.loadFontIfNeeded()
        guard let titleLabel = titleLabel else { return }
        let attributedText = attributedTitle(for: .normal) ?? NSAttributedString()
        let  startFont =  attributedText.length == 0 ? nil : attributedText.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as? UIFont
        let endFont = attributedText.length == 0 ? nil : attributedText.attribute(NSFontAttributeName, at: attributedText.length - 1, effectiveRange: nil) as? UIFont
        var textFont = titleLabel.font
        if let f = startFont , f.fontName != FAStruct.FontName  {
            textFont = f
        } else if let f = endFont , f.fontName != FAStruct.FontName  {
            textFont = f
        }
        
        var textColor: UIColor = .black
        attributedText.enumerateAttribute(NSForegroundColorAttributeName, in:NSMakeRange(0,attributedText.length), options:.longestEffectiveRangeNotRequired) {
            value, range, stop in
            if value != nil {
                textColor = value as! UIColor
            }
        }

        let textAttributes = [NSFontAttributeName: textFont!, NSForegroundColorAttributeName: textColor] as [String : Any]
        let prefixTextAttribured = NSMutableAttributedString(string: prefixText, attributes: textAttributes)
        
        if let iconText = icon?.text {
            let iconFont = UIFont(name: FAStruct.FontName, size: iconSize ?? size ?? titleLabel.font.pointSize)!
            let iconAttributes = [NSFontAttributeName: iconFont, NSForegroundColorAttributeName: textColor] as [String : Any]

            let iconString = NSAttributedString(string: iconText, attributes: iconAttributes)
            prefixTextAttribured.append(iconString)
        }
        let postfixTextAttributed = NSAttributedString(string: postfixText, attributes: textAttributes)
        prefixTextAttribured.append(postfixTextAttributed)
        
        setAttributedTitle(prefixTextAttribured, for: state)
    }
    
    
    func setFATitleColor(color: UIColor, forState state: UIControlState = .normal) {
        FontLoader.loadFontIfNeeded()
 
        let emptyString = " "
        let attributedString = NSMutableAttributedString(attributedString: attributedTitle(for: state) ?? NSAttributedString(string: emptyString))
        attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, attributedString.length))
       
        setAttributedTitle(attributedString, for: state)
        setTitleColor(color, for: state)
    }
}


public extension UILabel {
    
    /**
     To set an icon, use i.e. `labelName.FAIcon = FAType.FAGithub`
     */
    var FAIcon: FAType? {
        set {
            guard let newValue = newValue else { return }
                FontLoader.loadFontIfNeeded()
                let fontAwesome = UIFont(name: FAStruct.FontName, size: self.font.pointSize)
                assert(font != nil, FAStruct.ErrorAnnounce)
                font = fontAwesome!
                text = newValue.text
        }
        get {
            guard let text = text, let index = FAIcons.index(of: text) else { return nil }
            return FAType(rawValue: index)
        }
    }
    
    /**
     To set an icon, use i.e. `labelName.setFAIcon(FAType.FAGithub, iconSize: 35)`
     */
    func setFAIcon(icon: FAType, iconSize: CGFloat) {
        FAIcon = icon
        font = UIFont(name: font.fontName, size: iconSize)
    }
    
    
    func setFAColor(color: UIColor) {
        FontLoader.loadFontIfNeeded()
        let attributedString = NSMutableAttributedString(attributedString: attributedText ?? NSAttributedString())
        attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, attributedText!.length))
        textColor = color
    }
    
    
    func setFAText(prefixText: String, icon: FAType?, postfixText: String, size: CGFloat?, iconSize: CGFloat? = nil) {
        text = nil
        FontLoader.loadFontIfNeeded()
        
        let attrText = attributedText ?? NSAttributedString()
        let startFont = attrText.length == 0 ? nil : attrText.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as? UIFont
        let endFont = attrText.length == 0 ? nil : attrText.attribute(NSFontAttributeName, at: attrText.length - 1, effectiveRange: nil) as? UIFont
        var textFont = font
        if let f = startFont , f.fontName != FAStruct.FontName  {
            textFont = f
        } else if let f = endFont , f.fontName != FAStruct.FontName  {
            textFont = f
        }
        let textAttribute = [NSFontAttributeName : textFont!]
        let prefixTextAttribured = NSMutableAttributedString(string: prefixText, attributes: textAttribute)
        
        if let iconText = icon?.text {
            let iconFont = UIFont(name: FAStruct.FontName, size: iconSize ?? size ?? font.pointSize)!
            let iconAttribute = [NSFontAttributeName : iconFont]
            
            let iconString = NSAttributedString(string: iconText, attributes: iconAttribute)
            prefixTextAttribured.append(iconString)
        }
        let postfixTextAttributed = NSAttributedString(string: postfixText, attributes: textAttribute)
        prefixTextAttribured.append(postfixTextAttributed)
        
        attributedText = prefixTextAttribured
    }
}


// Original idea from https://github.com/thii/FontAwesome.swift/blob/master/FontAwesome/FontAwesome.swift
public extension UIImageView {
    
    /**
     Create UIImage from FAType
     */
    public func setFAIconWithName(icon: FAType, textColor: UIColor, orientation: UIImageOrientation = UIImageOrientation.down, backgroundColor: UIColor = UIColor.clear, size: CGSize? = nil) {
        FontLoader.loadFontIfNeeded()
        self.image = UIImage(icon: icon, size: size ?? frame.size, orientation: orientation, textColor: textColor, backgroundColor: backgroundColor)
    }
}


public extension UITabBarItem {
    
    public func setFAIcon(icon: FAType, size: CGSize? = nil, orientation: UIImageOrientation = UIImageOrientation.down, textColor: UIColor = UIColor.black, backgroundColor: UIColor = UIColor.clear, selectedTextColor: UIColor = UIColor.black, selectedBackgroundColor: UIColor = UIColor.clear) {
        FontLoader.loadFontIfNeeded()
        let tabBarItemImageSize = size ?? CGSize(width: 30, height: 30)

        image = UIImage(icon: icon, size: tabBarItemImageSize, orientation: orientation, textColor: textColor, backgroundColor: backgroundColor).withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        selectedImage = UIImage(icon: icon, size: tabBarItemImageSize, orientation: orientation, textColor: selectedTextColor, backgroundColor: selectedBackgroundColor).withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        setTitleTextAttributes([NSForegroundColorAttributeName: textColor], for: .normal)
        setTitleTextAttributes([NSForegroundColorAttributeName: selectedTextColor], for: .selected)
    }
}


public extension UISegmentedControl {
    
    public func setFAIcon(icon: FAType, forSegmentAtIndex segment: Int) {
        FontLoader.loadFontIfNeeded()
        let font = UIFont(name: FAStruct.FontName, size: 23)
        assert(font != nil, FAStruct.ErrorAnnounce)
        setTitleTextAttributes([NSFontAttributeName: font!], for: .normal)
        setTitle(icon.text, forSegmentAt: segment)
    }
}


public extension UIStepper {
    
    public func setFABackgroundImage(icon: FAType, forState state: UIControlState) {
        FontLoader.loadFontIfNeeded()
        let backgroundSize = CGSize(width: 47, height: 29)
        let image = UIImage(icon: icon, size: backgroundSize)
        setBackgroundImage(image, for: state)
    }
    
    public func setFAIncrementImage(icon: FAType, forState state: UIControlState) {
        FontLoader.loadFontIfNeeded()
        let incrementSize = CGSize(width: 16, height: 16)
        let image = UIImage(icon: icon, size: incrementSize)
        setIncrementImage(image, for: state)
    }
    
    public func setFADecrementImage(icon: FAType, forState state: UIControlState) {
        FontLoader.loadFontIfNeeded()
        let decrementSize = CGSize(width: 16, height: 16)
        let image = UIImage(icon: icon, size: decrementSize)
        setDecrementImage(image, for: state)
    }
}


public extension UIImage {
    
    public convenience init(icon: FAType, size: CGSize, orientation: UIImageOrientation = UIImageOrientation.down, textColor: UIColor = UIColor.black, backgroundColor: UIColor = UIColor.clear) {
        FontLoader.loadFontIfNeeded()
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.center
        
        let fontAspectRatio: CGFloat = 1.28571429
        let fontSize = min(size.width / fontAspectRatio, size.height)
        let font = UIFont(name: FAStruct.FontName, size: fontSize)
        assert(font != nil, FAStruct.ErrorAnnounce)
        let attributes = [NSFontAttributeName: font!, NSForegroundColorAttributeName: textColor, NSBackgroundColorAttributeName: backgroundColor, NSParagraphStyleAttributeName: paragraph]
        
        let attributedString = NSAttributedString(string: icon.text!, attributes: attributes)
        UIGraphicsBeginImageContextWithOptions(size, false , 0.0)
        attributedString.draw(in: CGRect(x: 0, y: (size.height - fontSize) * 0.5, width: size.width, height: fontSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        if let image = image {
            var imageOrientation = image.imageOrientation
            
            if(orientation != UIImageOrientation.down){
                imageOrientation = orientation
            }
            
            self.init(cgImage: image.cgImage!, scale: image.scale, orientation: imageOrientation)
//            self(cgImage: image.cgImage!, scale: image.scale, orientation: image.imageOrientation)
        } else {
            self.init()
        }
    }
    
    public convenience init(bgIcon: FAType, orientation: UIImageOrientation = UIImageOrientation.down, bgTextColor: UIColor = .black, bgBackgroundColor: UIColor = .clear, topIcon: FAType, topTextColor: UIColor = .black, bgLarge: Bool? = true, size: CGSize? = nil) {
        
        let bgSize: CGSize!
        let topSize: CGSize!
        let bgRect: CGRect!
        let topRect: CGRect!
        
        if bgLarge! {
            topSize = size ?? CGSize(width: 30, height: 30)
            bgSize = CGSize(width: 2 * topSize.width, height: 2 * topSize.height)
            
        } else {
            
            bgSize = size ?? CGSize(width: 30, height: 30)
            topSize = CGSize(width: 2 * bgSize.width, height: 2 * bgSize.height)
        }
        
        let bgImage = UIImage.init(icon: bgIcon, size: bgSize, orientation: orientation, textColor: bgTextColor)
        let topImage = UIImage.init(icon: topIcon, size: topSize, orientation: orientation, textColor: topTextColor)
        
        if bgLarge! {
            bgRect = CGRect(x: 0, y: 0, width: bgSize.width, height: bgSize.height)
            topRect = CGRect(x: topSize.width/2, y: topSize.height/2, width: topSize.width, height: topSize.height)
            UIGraphicsBeginImageContextWithOptions(bgImage.size, false, 0.0)
            
        } else {
            topRect = CGRect(x: 0, y: 0, width: topSize.width, height: topSize.height)
            bgRect = CGRect(x: bgSize.width/2, y: bgSize.height/2, width: bgSize.width, height: bgSize.height)
            UIGraphicsBeginImageContextWithOptions(topImage.size, false, 0.0)
            
        }
        
        bgImage.draw(in: bgRect)
        topImage.draw(in: topRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let image = image {
            var imageOrientation = image.imageOrientation
            
            if(orientation != UIImageOrientation.down){
                imageOrientation = orientation
            }
            
            self.init(cgImage: image.cgImage!, scale: image.scale, orientation: orientation)
        } else {
            self.init()
        }
    }    
}


public extension UISlider {
    
    func setFAMaximumValueImage(icon: FAType, orientation: UIImageOrientation = UIImageOrientation.down, customSize: CGSize? = nil) {
        maximumValueImage = UIImage(icon: icon, size: customSize ?? CGSize(width: 25,height: 25), orientation: orientation)
    }
    
    
    func setFAMinimumValueImage(icon: FAType, orientation: UIImageOrientation = UIImageOrientation.down, customSize: CGSize? = nil) {
        minimumValueImage = UIImage(icon: icon, size: customSize ?? CGSize(width: 25,height: 25), orientation: orientation)
    }
}


public extension UIViewController {
    var FATitle: FAType? {
        set {
            FontLoader.loadFontIfNeeded()
            let font = UIFont(name: FAStruct.FontName, size: 23)
            assert(font != nil,FAStruct.ErrorAnnounce)
            navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font!]
            title = newValue?.text
        }
        get {
            guard let title = title, let index = FAIcons.index(of: title) else { return nil }
            return FAType(rawValue: index)
        }
    }
}


private struct FAStruct {
    static let FontName = "FontAwesome"
    static let ErrorAnnounce = "****** FONT AWESOME SWIFT - FontAwesome font not found in the bundle or not associated with Info.plist when manual installation was performed. ******"
}


private class FontLoader {
    
    static func loadFontIfNeeded() {
        if (UIFont.fontNames(forFamilyName: FAStruct.FontName).count == 0) {
            
                let bundle = Bundle(for: FontLoader.self)
                var fontURL: URL!
                let identifier = bundle.bundleIdentifier
                
                if identifier?.hasPrefix("org.cocoapods") == true {
                    
                    fontURL = bundle.url(forResource: FAStruct.FontName, withExtension: "ttf", subdirectory: "Font-Awesome-Swift.bundle")
                } else {
                    
                    fontURL = bundle.url(forResource: FAStruct.FontName, withExtension: "ttf")
                }
                let data = try! Data(contentsOf: fontURL as URL)
                let provider = CGDataProvider(data: data as CFData)
                let font = CGFont(provider!)
                
                var error: Unmanaged<CFError>?
                if !CTFontManagerRegisterGraphicsFont(font, &error) {
                    
                    let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
                    let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
                    NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
                }
        }
    }
}

/**
 List of all icons in Font Awesome
 */
public enum FAType: Int {
    
    static var count: Int {
        return FAIcons.count
    }
    
    public var text: String? {
        return FAIcons[rawValue]
    }
    
    case FAGlass, FAMusic, FASearch, FAEnvelopeO, FAHeart, FAStar, FAStarO, FAUser, FAFilm, FAThLarge, FATh, FAThList, FACheck, FATimes, FARemove, FAClose, FASearchPlus, FASearchMinus, FAPowerOff, FASignal, FACog, FAGear, FATrashO, FAHome, FAFileO, FAClockO, FARoad, FADownload, FAArrowCircleODown, FAArrowCircleOUp, FAInbox, FAPlayCircleO, FARepeat, FARotateRight, FARefresh, FAListAlt, FALock, FAFlag, FAHeadphones, FAVolumeOff, FAVolumeDown, FAVolumeUp, FAQrcode, FABarcode, FATag, FATags, FABook, FABookmark, FAPrint, FACamera, FAFont, FABold, FAItalic, FATextHeight, FATextWidth, FAAlignLeft, FAAlignCenter, FAAlignRight, FAAlignJustify, FAList, FAOutdent, FADedent, FAIndent, FAVideoCamera, FAPictureO, FAPhoto, FAImage, FAPencil, FAMapMarker, FAAdjust, FATint, FAPencilSquareO, FAEdit, FAShareSquareO, FACheckSquareO, FAArrows, FAStepBackward, FAFastBackward, FABackward, FAPlay, FAPause, FAStop, FAForward, FAFastForward, FAStepForward, FAEject, FAChevronLeft, FAChevronRight, FAPlusCircle, FAMinusCircle, FATimesCircle, FACheckCircle, FAQuestionCircle, FAInfoCircle, FACrosshairs, FATimesCircleO, FACheckCircleO, FABan, FAArrowLeft, FAArrowRight, FAArrowUp, FAArrowDown, FAShare, FAMailForward, FAExpand, FACompress, FAPlus, FAMinus, FAAsterisk, FAExclamationCircle, FAGift, FALeaf, FAFire, FAEye, FAEyeSlash, FAExclamationTriangle, FAWarning, FAPlane, FACalendar, FARandom, FAComment, FAMagnet, FAChevronUp, FAChevronDown, FARetweet, FAShoppingCart, FAFolder, FAFolderOpen, FAArrowsV, FAArrowsH, FABarChart, FABarChartO, FATwitterSquare, FAFacebookSquare, FACameraRetro, FAKey, FACogs, FAGears, FAComments, FAThumbsOUp, FAThumbsODown, FAStarHalf, FAHeartO, FASignOut, FALinkedinSquare, FAThumbTack, FAExternalLink, FASignIn, FATrophy, FAGithubSquare, FAUpload, FALemonO, FAPhone, FASquareO, FABookmarkO, FAPhoneSquare, FATwitter, FAFacebook, FAFacebookF, FAGithub, FAUnlock, FACreditCard, FARss, FAFeed, FAHddO, FABullhorn, FABell, FACertificate, FAHandORight, FAHandOLeft, FAHandOUp, FAHandODown, FAArrowCircleLeft, FAArrowCircleRight, FAArrowCircleUp, FAArrowCircleDown, FAGlobe, FAWrench, FATasks, FAFilter, FABriefcase, FAArrowsAlt, FAUsers, FAGroup, FALink, FAChain, FACloud, FAFlask, FAScissors, FACut, FAFilesO, FACopy, FAPaperclip, FAFloppyO, FASave, FASquare, FABars, FANavicon, FAReorder, FAListUl, FAListOl, FAStrikethrough, FAUnderline, FATable, FAMagic, FATruck, FAPinterest, FAPinterestSquare, FAGooglePlusSquare, FAGooglePlus, FAMoney, FACaretDown, FACaretUp, FACaretLeft, FACaretRight, FAColumns, FASort, FAUnsorted, FASortDesc, FASortDown, FASortAsc, FASortUp, FAEnvelope, FALinkedin, FAUndo, FARotateLeft, FAGavel, FALegal, FATachometer, FADashboard, FACommentO, FACommentsO, FABolt, FAFlash, FASitemap, FAUmbrella, FAClipboard, FAPaste, FALightbulbO, FAExchange, FACloudDownload, FACloudUpload, FAUserMd, FAStethoscope, FASuitcase, FABellO, FACoffee, FACutlery, FAFileTextO, FABuildingO, FAHospitalO, FAAmbulance, FAMedkit, FAFighterJet, FABeer, FAHSquare, FAPlusSquare, FAAngleDoubleLeft, FAAngleDoubleRight, FAAngleDoubleUp, FAAngleDoubleDown, FAAngleLeft, FAAngleRight, FAAngleUp, FAAngleDown, FADesktop, FALaptop, FATablet, FAMobile, FAMobilePhone, FACircleO, FAQuoteLeft, FAQuoteRight, FASpinner, FACircle, FAReply, FAMailReply, FAGithubAlt, FAFolderO, FAFolderOpenO, FASmileO, FAFrownO, FAMehO, FAGamepad, FAKeyboardO, FAFlagO, FAFlagCheckered, FATerminal, FACode, FAReplyAll, FAMailReplyAll, FAStarHalfO, FAStarHalfEmpty, FAStarHalfFull, FALocationArrow, FACrop, FACodeFork, FAChainBroken, FAUnlink, FAQuestion, FAInfo, FAExclamation, FASuperscript, FASubscript, FAEraser, FAPuzzlePiece, FAMicrophone, FAMicrophoneSlash, FAShield, FACalendarO, FAFireExtinguisher, FARocket, FAMaxcdn, FAChevronCircleLeft, FAChevronCircleRight, FAChevronCircleUp, FAChevronCircleDown, FAHtml5, FACss3, FAAnchor, FAUnlockAlt, FABullseye, FAEllipsisH, FAEllipsisV, FARssSquare, FAPlayCircle, FATicket, FAMinusSquare, FAMinusSquareO, FALevelUp, FALevelDown, FACheckSquare, FAPencilSquare, FAExternalLinkSquare, FAShareSquare, FACompass, FACaretSquareODown, FAToggleDown, FACaretSquareOUp, FAToggleUp, FACaretSquareORight, FAToggleRight, FAEur, FAEuro, FAGbp, FAUsd, FADollar, FAInr, FARupee, FAJpy, FACny, FARmb, FAYen, FARub, FARuble, FARouble, FAKrw, FAWon, FABtc, FABitcoin, FAFile, FAFileText, FASortAlphaAsc, FASortAlphaDesc, FASortAmountAsc, FASortAmountDesc, FASortNumericAsc, FASortNumericDesc, FAThumbsUp, FAThumbsDown, FAYoutubeSquare, FAYoutube, FAXing, FAXingSquare, FAYoutubePlay, FADropbox, FAStackOverflow, FAInstagram, FAFlickr, FAAdn, FABitbucket, FABitbucketSquare, FATumblr, FATumblrSquare, FALongArrowDown, FALongArrowUp, FALongArrowLeft, FALongArrowRight, FAApple, FAWindows, FAAndroid, FALinux, FADribbble, FASkype, FAFoursquare, FATrello, FAFemale, FAMale, FAGratipay, FAGittip, FASunO, FAMoonO, FAArchive, FABug, FAVk, FAWeibo, FARenren, FAPagelines, FAStackExchange, FAArrowCircleORight, FAArrowCircleOLeft, FACaretSquareOLeft, FAToggleLeft, FADotCircleO, FAWheelchair, FAVimeoSquare, FATry, FATurkishLira, FAPlusSquareO, FASpaceShuttle, FASlack, FAEnvelopeSquare, FAWordpress, FAOpenid, FAUniversity, FAInstitution, FABank, FAGraduationCap, FAMortarBoard, FAYahoo, FAGoogle, FAReddit, FARedditSquare, FAStumbleuponCircle, FAStumbleupon, FADelicious, FADigg, FAPiedPiperPp, FAPiedPiperAlt, FADrupal, FAJoomla, FALanguage, FAFax, FABuilding, FAChild, FAPaw, FASpoon, FACube, FACubes, FABehance, FABehanceSquare, FASteam, FASteamSquare, FARecycle, FACar, FAAutomobile, FATaxi, FACab, FATree, FASpotify, FADeviantart, FASoundcloud, FADatabase, FAFilePdfO, FAFileWordO, FAFileExcelO, FAFilePowerpointO, FAFileImageO, FAFilePhotoO, FAFilePictureO, FAFileArchiveO, FAFileZipO, FAFileAudioO, FAFileSoundO, FAFileVideoO, FAFileMovieO, FAFileCodeO, FAVine, FACodepen, FAJsfiddle, FALifeRing, FALifeBouy, FALifeBuoy, FALifeSaver, FASupport, FACircleONotch, FARebel, FARa, FAResistance, FAEmpire, FAGe, FAGitSquare, FAGit, FAHackerNews, FAYCombinatorSquare, FAYcSquare, FATencentWeibo, FAQq, FAWeixin, FAWechat, FAPaperPlane, FASend, FAPaperPlaneO, FASendO, FAHistory, FACircleThin, FAHeader, FAParagraph, FASliders, FAShareAlt, FAShareAltSquare, FABomb, FAFutbolO, FASoccerBallO, FATty, FABinoculars, FAPlug, FASlideshare, FATwitch, FAYelp, FANewspaperO, FAWifi, FACalculator, FAPaypal, FAGoogleWallet, FACcVisa, FACcMastercard, FACcDiscover, FACcAmex, FACcPaypal, FACcStripe, FABellSlash, FABellSlashO, FATrash, FACopyright, FAAt, FAEyedropper, FAPaintBrush, FABirthdayCake, FAAreaChart, FAPieChart, FALineChart, FALastfm, FALastfmSquare, FAToggleOff, FAToggleOn, FABicycle, FABus, FAIoxhost, FAAngellist, FACc, FAIls, FAShekel, FASheqel, FAMeanpath, FABuysellads, FAConnectdevelop, FADashcube, FAForumbee, FALeanpub, FASellsy, FAShirtsinbulk, FASimplybuilt, FASkyatlas, FACartPlus, FACartArrowDown, FADiamond, FAShip, FAUserSecret, FAMotorcycle, FAStreetView, FAHeartbeat, FAVenus, FAMars, FAMercury, FATransgender, FAIntersex, FATransgenderAlt, FAVenusDouble, FAMarsDouble, FAVenusMars, FAMarsStroke, FAMarsStrokeV, FAMarsStrokeH, FANeuter, FAGenderless, FAFacebookOfficial, FAPinterestP, FAWhatsapp, FAServer, FAUserPlus, FAUserTimes, FABed, FAHotel, FAViacoin, FATrain, FASubway, FAMedium, FAYCombinator, FAYc, FAOptinMonster, FAOpencart, FAExpeditedssl, FABatteryFull, FABattery4, FABatteryThreeQuarters, FABattery3, FABatteryHalf, FABattery2, FABatteryQuarter, FABattery1, FABatteryEmpty, FABattery0, FAMousePointer, FAICursor, FAObjectGroup, FAObjectUngroup, FAStickyNote, FAStickyNoteO, FACcJcb, FACcDinersClub, FAClone, FABalanceScale, FAHourglassO, FAHourglassStart, FAHourglass1, FAHourglassHalf, FAHourglass2, FAHourglassEnd, FAHourglass3, FAHourglass, FAHandRockO, FAHandGrabO, FAHandPaperO, FAHandStopO, FAHandScissorsO, FAHandLizardO, FAHandSpockO, FAHandPointerO, FAHandPeaceO, FATrademark, FARegistered, FACreativeCommons, FAGg, FAGgCircle, FATripadvisor, FAOdnoklassniki, FAOdnoklassnikiSquare, FAGetPocket, FAWikipediaW, FASafari, FAChrome, FAFirefox, FAOpera, FAInternetExplorer, FATelevision, FATv, FAContao, FA500px, FAAmazon, FACalendarPlusO, FACalendarMinusO, FACalendarTimesO, FACalendarCheckO, FAIndustry, FAMapPin, FAMapSigns, FAMapO, FAMap, FACommenting, FACommentingO, FAHouzz, FAVimeo, FABlackTie, FAFonticons, FARedditAlien, FAEdge, FACreditCardAlt, FACodiepie, FAModx, FAFortAwesome, FAUsb, FAProductHunt, FAMixcloud, FAScribd, FAPauseCircle, FAPauseCircleO, FAStopCircle, FAStopCircleO, FAShoppingBag, FAShoppingBasket, FAHashtag, FABluetooth, FABluetoothB, FAPercent, FAGitlab, FAWpbeginner, FAWpforms, FAEnvira, FAUniversalAccess, FAWheelchairAlt, FAQuestionCircleO, FABlind, FAAudioDescription, FAVolumeControlPhone, FABraille, FAAssistiveListeningSystems, FAAmericanSignLanguageInterpreting, FAAslInterpreting, FADeaf, FADeafness, FAHardOfHearing, FAGlide, FAGlideG, FASignLanguage, FASigning, FALowVision, FAViadeo, FAViadeoSquare, FASnapchat, FASnapchatGhost, FASnapchatSquare, FAPiedPiper, FAFirstOrder, FAYoast, FAThemeisle, FAGooglePlusOfficial, FAGooglePlusCircle, FAFontAwesome, FAFa, FAAddressBook, FAAddressBookO, FAAdressCard, FAAdressCardO, FABandcamp, FABath, FABathtub, FADriversLicense, FADriversLicenseO, FAEerCast, FAEnvelopeOpen, FAEnvelopeOpenO, FAEtsy, FAFreeCodeCamp, FAGrav, FAHandshakeO, FAIdBadge, FAIdCard, FAIdCardO, FAImdb, FALinode, FAMeetup, FAMicrochip, FAPodcast, FAQuora, FARavelry, FAS15, FAShower, FASnowflakeO, FASuperpowers, FATelegram, FAThermometer, FAThermometer0, FAThermometer1, FAThermometer2, FAThermometer3, FAThermometer4, FAThermometerEmpty, FAThermometerFull, FAThermometerHalf, FAThermometerQuarter, FAThermometerThreeQuarters, FATimesRectangle, FATimesRectangleO, FAUserCircle, FAUserCircleO, FAUserO, FAVcard, FAVcardO, FAWindowClose, FAWindowCloseO, FAWindowMaximize, FAWindowMinimize, FAWindowRestore, FAWPExplorer
    }

    private let FAIcons = ["\u{f000}", "\u{f001}", "\u{f002}", "\u{f003}", "\u{f004}", "\u{f005}", "\u{f006}", "\u{f007}", "\u{f008}", "\u{f009}", "\u{f00a}", "\u{f00b}", "\u{f00c}", "\u{f00d}", "\u{f00d}", "\u{f00d}", "\u{f00e}", "\u{f010}", "\u{f011}", "\u{f012}", "\u{f013}", "\u{f013}", "\u{f014}", "\u{f015}", "\u{f016}", "\u{f017}", "\u{f018}", "\u{f019}", "\u{f01a}", "\u{f01b}", "\u{f01c}", "\u{f01d}", "\u{f01e}", "\u{f01e}", "\u{f021}", "\u{f022}", "\u{f023}", "\u{f024}", "\u{f025}", "\u{f026}", "\u{f027}", "\u{f028}", "\u{f029}", "\u{f02a}", "\u{f02b}", "\u{f02c}", "\u{f02d}", "\u{f02e}", "\u{f02f}", "\u{f030}", "\u{f031}", "\u{f032}", "\u{f033}", "\u{f034}", "\u{f035}", "\u{f036}", "\u{f037}", "\u{f038}", "\u{f039}", "\u{f03a}", "\u{f03b}", "\u{f03b}", "\u{f03c}", "\u{f03d}", "\u{f03e}", "\u{f03e}", "\u{f03e}", "\u{f040}", "\u{f041}", "\u{f042}", "\u{f043}", "\u{f044}", "\u{f044}", "\u{f045}", "\u{f046}", "\u{f047}", "\u{f048}", "\u{f049}", "\u{f04a}", "\u{f04b}", "\u{f04c}", "\u{f04d}", "\u{f04e}", "\u{f050}", "\u{f051}", "\u{f052}", "\u{f053}", "\u{f054}", "\u{f055}", "\u{f056}", "\u{f057}", "\u{f058}", "\u{f059}", "\u{f05a}", "\u{f05b}", "\u{f05c}", "\u{f05d}", "\u{f05e}", "\u{f060}", "\u{f061}", "\u{f062}", "\u{f063}", "\u{f064}", "\u{f064}", "\u{f065}", "\u{f066}", "\u{f067}", "\u{f068}", "\u{f069}", "\u{f06a}", "\u{f06b}", "\u{f06c}", "\u{f06d}", "\u{f06e}", "\u{f070}", "\u{f071}", "\u{f071}", "\u{f072}", "\u{f073}", "\u{f074}", "\u{f075}", "\u{f076}", "\u{f077}", "\u{f078}", "\u{f079}", "\u{f07a}", "\u{f07b}", "\u{f07c}", "\u{f07d}", "\u{f07e}", "\u{f080}", "\u{f080}", "\u{f081}", "\u{f082}", "\u{f083}", "\u{f084}", "\u{f085}", "\u{f085}", "\u{f086}", "\u{f087}", "\u{f088}", "\u{f089}", "\u{f08a}", "\u{f08b}", "\u{f08c}", "\u{f08d}", "\u{f08e}", "\u{f090}", "\u{f091}", "\u{f092}", "\u{f093}", "\u{f094}", "\u{f095}", "\u{f096}", "\u{f097}", "\u{f098}", "\u{f099}", "\u{f09a}", "\u{f09a}", "\u{f09b}", "\u{f09c}", "\u{f09d}", "\u{f09e}", "\u{f09e}", "\u{f0a0}", "\u{f0a1}", "\u{f0f3}", "\u{f0a3}", "\u{f0a4}", "\u{f0a5}", "\u{f0a6}", "\u{f0a7}", "\u{f0a8}", "\u{f0a9}", "\u{f0aa}", "\u{f0ab}", "\u{f0ac}", "\u{f0ad}", "\u{f0ae}", "\u{f0b0}", "\u{f0b1}", "\u{f0b2}", "\u{f0c0}", "\u{f0c0}", "\u{f0c1}", "\u{f0c1}", "\u{f0c2}", "\u{f0c3}", "\u{f0c4}", "\u{f0c4}", "\u{f0c5}", "\u{f0c5}", "\u{f0c6}", "\u{f0c7}", "\u{f0c7}", "\u{f0c8}", "\u{f0c9}", "\u{f0c9}", "\u{f0c9}", "\u{f0ca}", "\u{f0cb}", "\u{f0cc}", "\u{f0cd}", "\u{f0ce}", "\u{f0d0}", "\u{f0d1}", "\u{f0d2}", "\u{f0d3}", "\u{f0d4}", "\u{f0d5}", "\u{f0d6}", "\u{f0d7}", "\u{f0d8}", "\u{f0d9}", "\u{f0da}", "\u{f0db}", "\u{f0dc}", "\u{f0dc}", "\u{f0dd}", "\u{f0dd}", "\u{f0de}", "\u{f0de}", "\u{f0e0}", "\u{f0e1}", "\u{f0e2}", "\u{f0e2}", "\u{f0e3}", "\u{f0e3}", "\u{f0e4}", "\u{f0e4}", "\u{f0e5}", "\u{f0e6}", "\u{f0e7}", "\u{f0e7}", "\u{f0e8}", "\u{f0e9}", "\u{f0ea}", "\u{f0ea}", "\u{f0eb}", "\u{f0ec}", "\u{f0ed}", "\u{f0ee}", "\u{f0f0}", "\u{f0f1}", "\u{f0f2}", "\u{f0a2}", "\u{f0f4}", "\u{f0f5}", "\u{f0f6}", "\u{f0f7}", "\u{f0f8}", "\u{f0f9}", "\u{f0fa}", "\u{f0fb}", "\u{f0fc}", "\u{f0fd}", "\u{f0fe}", "\u{f100}", "\u{f101}", "\u{f102}", "\u{f103}", "\u{f104}", "\u{f105}", "\u{f106}", "\u{f107}", "\u{f108}", "\u{f109}", "\u{f10a}", "\u{f10b}", "\u{f10b}", "\u{f10c}", "\u{f10d}", "\u{f10e}", "\u{f110}", "\u{f111}", "\u{f112}", "\u{f112}", "\u{f113}", "\u{f114}", "\u{f115}", "\u{f118}", "\u{f119}", "\u{f11a}", "\u{f11b}", "\u{f11c}", "\u{f11d}", "\u{f11e}", "\u{f120}", "\u{f121}", "\u{f122}", "\u{f122}", "\u{f123}", "\u{f123}", "\u{f123}", "\u{f124}", "\u{f125}", "\u{f126}", "\u{f127}", "\u{f127}", "\u{f128}", "\u{f129}", "\u{f12a}", "\u{f12b}", "\u{f12c}", "\u{f12d}", "\u{f12e}", "\u{f130}", "\u{f131}", "\u{f132}", "\u{f133}", "\u{f134}", "\u{f135}", "\u{f136}", "\u{f137}", "\u{f138}", "\u{f139}", "\u{f13a}", "\u{f13b}", "\u{f13c}", "\u{f13d}", "\u{f13e}", "\u{f140}", "\u{f141}", "\u{f142}", "\u{f143}", "\u{f144}", "\u{f145}", "\u{f146}", "\u{f147}", "\u{f148}", "\u{f149}", "\u{f14a}", "\u{f14b}", "\u{f14c}", "\u{f14d}", "\u{f14e}", "\u{f150}", "\u{f150}", "\u{f151}", "\u{f151}", "\u{f152}", "\u{f152}", "\u{f153}", "\u{f153}", "\u{f154}", "\u{f155}", "\u{f155}", "\u{f156}", "\u{f156}", "\u{f157}", "\u{f157}", "\u{f157}", "\u{f157}", "\u{f158}", "\u{f158}", "\u{f158}", "\u{f159}", "\u{f159}", "\u{f15a}", "\u{f15a}", "\u{f15b}", "\u{f15c}", "\u{f15d}", "\u{f15e}", "\u{f160}", "\u{f161}", "\u{f162}", "\u{f163}", "\u{f164}", "\u{f165}", "\u{f166}", "\u{f167}", "\u{f168}", "\u{f169}", "\u{f16a}", "\u{f16b}", "\u{f16c}", "\u{f16d}", "\u{f16e}", "\u{f170}", "\u{f171}", "\u{f172}", "\u{f173}", "\u{f174}", "\u{f175}", "\u{f176}", "\u{f177}", "\u{f178}", "\u{f179}", "\u{f17a}", "\u{f17b}", "\u{f17c}", "\u{f17d}", "\u{f17e}", "\u{f180}", "\u{f181}", "\u{f182}", "\u{f183}", "\u{f184}", "\u{f184}", "\u{f185}", "\u{f186}", "\u{f187}", "\u{f188}", "\u{f189}", "\u{f18a}", "\u{f18b}", "\u{f18c}", "\u{f18d}", "\u{f18e}", "\u{f190}", "\u{f191}", "\u{f191}", "\u{f192}", "\u{f193}", "\u{f194}", "\u{f195}", "\u{f195}", "\u{f196}", "\u{f197}", "\u{f198}", "\u{f199}", "\u{f19a}", "\u{f19b}", "\u{f19c}", "\u{f19c}", "\u{f19c}", "\u{f19d}", "\u{f19d}", "\u{f19e}", "\u{f1a0}", "\u{f1a1}", "\u{f1a2}", "\u{f1a3}", "\u{f1a4}", "\u{f1a5}", "\u{f1a6}", "\u{f1a7}", "\u{f1a8}", "\u{f1a9}", "\u{f1aa}", "\u{f1ab}", "\u{f1ac}", "\u{f1ad}", "\u{f1ae}", "\u{f1b0}", "\u{f1b1}", "\u{f1b2}", "\u{f1b3}", "\u{f1b4}", "\u{f1b5}", "\u{f1b6}", "\u{f1b7}", "\u{f1b8}", "\u{f1b9}", "\u{f1b9}", "\u{f1ba}", "\u{f1ba}", "\u{f1bb}", "\u{f1bc}", "\u{f1bd}", "\u{f1be}", "\u{f1c0}", "\u{f1c1}", "\u{f1c2}", "\u{f1c3}", "\u{f1c4}", "\u{f1c5}", "\u{f1c5}", "\u{f1c5}", "\u{f1c6}", "\u{f1c6}", "\u{f1c7}", "\u{f1c7}", "\u{f1c8}", "\u{f1c8}", "\u{f1c9}", "\u{f1ca}", "\u{f1cb}", "\u{f1cc}", "\u{f1cd}", "\u{f1cd}", "\u{f1cd}", "\u{f1cd}", "\u{f1cd}", "\u{f1ce}", "\u{f1d0}", "\u{f1d0}", "\u{f1d0}", "\u{f1d1}", "\u{f1d1}", "\u{f1d2}", "\u{f1d3}", "\u{f1d4}", "\u{f1d4}", "\u{f1d4}", "\u{f1d5}", "\u{f1d6}", "\u{f1d7}", "\u{f1d7}", "\u{f1d8}", "\u{f1d8}", "\u{f1d9}", "\u{f1d9}", "\u{f1da}", "\u{f1db}", "\u{f1dc}", "\u{f1dd}", "\u{f1de}", "\u{f1e0}", "\u{f1e1}", "\u{f1e2}", "\u{f1e3}", "\u{f1e3}", "\u{f1e4}", "\u{f1e5}", "\u{f1e6}", "\u{f1e7}", "\u{f1e8}", "\u{f1e9}", "\u{f1ea}", "\u{f1eb}", "\u{f1ec}", "\u{f1ed}", "\u{f1ee}", "\u{f1f0}", "\u{f1f1}", "\u{f1f2}", "\u{f1f3}", "\u{f1f4}", "\u{f1f5}", "\u{f1f6}", "\u{f1f7}", "\u{f1f8}", "\u{f1f9}", "\u{f1fa}", "\u{f1fb}", "\u{f1fc}", "\u{f1fd}", "\u{f1fe}", "\u{f200}", "\u{f201}", "\u{f202}", "\u{f203}", "\u{f204}", "\u{f205}", "\u{f206}", "\u{f207}", "\u{f208}", "\u{f209}", "\u{f20a}", "\u{f20b}", "\u{f20b}", "\u{f20b}", "\u{f20c}", "\u{f20d}", "\u{f20e}", "\u{f210}", "\u{f211}", "\u{f212}", "\u{f213}", "\u{f214}", "\u{f215}", "\u{f216}", "\u{f217}", "\u{f218}", "\u{f219}", "\u{f21a}", "\u{f21b}", "\u{f21c}", "\u{f21d}", "\u{f21e}", "\u{f221}", "\u{f222}", "\u{f223}", "\u{f224}", "\u{f224}", "\u{f225}", "\u{f226}", "\u{f227}", "\u{f228}", "\u{f229}", "\u{f22a}", "\u{f22b}", "\u{f22c}", "\u{f22d}", "\u{f230}", "\u{f231}", "\u{f232}", "\u{f233}", "\u{f234}", "\u{f235}", "\u{f236}", "\u{f236}", "\u{f237}", "\u{f238}", "\u{f239}", "\u{f23a}", "\u{f23b}", "\u{f23b}", "\u{f23c}", "\u{f23d}", "\u{f23e}", "\u{f240}", "\u{f240}", "\u{f241}", "\u{f241}", "\u{f242}", "\u{f242}", "\u{f243}", "\u{f243}", "\u{f244}", "\u{f244}", "\u{f245}", "\u{f246}", "\u{f247}", "\u{f248}", "\u{f249}", "\u{f24a}", "\u{f24b}", "\u{f24c}", "\u{f24d}", "\u{f24e}", "\u{f250}", "\u{f251}", "\u{f251}", "\u{f252}", "\u{f252}", "\u{f253}", "\u{f253}", "\u{f254}", "\u{f255}", "\u{f255}", "\u{f256}", "\u{f256}", "\u{f257}", "\u{f258}", "\u{f259}", "\u{f25a}", "\u{f25b}", "\u{f25c}", "\u{f25d}", "\u{f25e}", "\u{f260}", "\u{f261}", "\u{f262}", "\u{f263}", "\u{f264}", "\u{f265}", "\u{f266}", "\u{f267}", "\u{f268}", "\u{f269}", "\u{f26a}", "\u{f26b}", "\u{f26c}", "\u{f26c}", "\u{f26d}", "\u{f26e}", "\u{f270}", "\u{f271}", "\u{f272}", "\u{f273}", "\u{f274}", "\u{f275}", "\u{f276}", "\u{f277}", "\u{f278}", "\u{f279}", "\u{f27a}", "\u{f27b}", "\u{f27c}", "\u{f27d}", "\u{f27e}", "\u{f280}", "\u{f281}", "\u{f282}", "\u{f283}", "\u{f284}", "\u{f285}", "\u{f286}", "\u{f287}", "\u{f288}", "\u{f289}", "\u{f28a}", "\u{f28b}", "\u{f28c}", "\u{f28d}", "\u{f28e}", "\u{f290}", "\u{f291}", "\u{f292}", "\u{f293}", "\u{f294}", "\u{f295}", "\u{f296}", "\u{f297}", "\u{f298}", "\u{f299}", "\u{f29a}", "\u{f29b}", "\u{f29c}", "\u{f29d}", "\u{f29e}", "\u{f2a0}", "\u{f2a1}", "\u{f2a2}", "\u{f2a3}", "\u{f2a3}", "\u{f2a4}", "\u{f2a4}", "\u{f2a4}", "\u{f2a5}", "\u{f2a6}", "\u{f2a7}", "\u{f2a7}", "\u{f2a8}", "\u{f2a9}", "\u{f2aa}", "\u{f2ab}", "\u{f2ac}", "\u{f2ad}", "\u{f2ae}", "\u{f2b0}", "\u{f2b1}", "\u{f2b2}", "\u{f2b3}", "\u{f2b3}", "\u{f2b4}", "\u{f2b4}", "\u{f2b9}", "\u{f2ba}", "\u{f2bb}", "\u{f2bc}", "\u{f2d5}", "\u{f2cd}", "\u{f2cd}", "\u{f2c2}", "\u{f2c3}", "\u{f2da}", "\u{f2b6}", "\u{f2b7}", "\u{f2d7}", "\u{f2c5}", "\u{f2d6}", "\u{f2b5}", "\u{f2c1}", "\u{f2c2}", "\u{f2c3}", "\u{f2d8}", "\u{f2b8}", "\u{f2e0}", "\u{f2db}", "\u{f2ce}", "\u{f2c4}", "\u{f2d9}", "\u{f2cd}", "\u{f2cc}", "\u{f2dc}", "\u{f2dd}", "\u{f2c6}", "\u{f2c7}", "\u{f2cb}", "\u{f2ca}", "\u{f2c9}", "\u{f2c8}", "\u{f2c7}", "\u{f2cb}", "\u{f2c7}", "\u{f2c9}", "\u{f2ca}", "\u{f2c8}", "\u{f2d3}", "\u{f2d4}", "\u{f2bd}", "\u{f2be}", "\u{f2c0}", "\u{f2bb}", "\u{f2bc}", "\u{f2d3}", "\u{f2d4}", "\u{f2d0}", "\u{f2d1}", "\u{f2d2}", "\u{f2de}"
    ]
