import Foundation
import UIKit

public extension UIButton {
    
    /**
    To set an icon, use i.e. `buttonName.setFAIcon(FAType.FAGithub, forState: .Normal)`
    */
    func setFAIcon(icon: FAType, forState state: UIControlState) {
        
        if let titleLabel = titleLabel {
            
            FontLoader.loadFontIfNeeded()
            let font = UIFont(name: FAStruct.FontName, size: titleLabel.font.pointSize)
            assert(font != nil, FAStruct.ErrorAnnounce)
            titleLabel.font = font!
            setTitle(icon.text, forState: state)
        }
    }
    
    /**
    To set an icon, use i.e. `buttonName.setFAIcon(FAType.FAGithub, iconSize: 35, forState: .Normal)`
    */
    func setFAIcon(icon: FAType, iconSize: CGFloat, forState state: UIControlState) {
        
        setFAIcon(icon, forState: state)
        if let fontName = titleLabel?.font.fontName {
            
            titleLabel?.font = UIFont(name: fontName, size: iconSize)
        }
    }
}

public extension UILabel {
    
    /**
    To set an icon, use i.e. `labelName.FAIcon = FAType.FAGithub`
    */
    var FAIcon: FAType? {
        
        set {
            
            if let newValue = newValue {
                
                FontLoader.loadFontIfNeeded()
                let fontAwesome = UIFont(name: FAStruct.FontName, size: self.font.pointSize)
                assert(font != nil, FAStruct.ErrorAnnounce)
                font = fontAwesome!
                text = newValue.text
            }
        }
        
        get {
            if let text = text {
                
                if let index =  FAIcons.indexOf(text) {
                    return FAType(rawValue: index)
                }
            }
            return nil
        }
    }
    
    /**
    To set an icon, use i.e. `labelName.setFAIcon(FAType.FAGithub, iconSize: 35)`
    */
    func setFAIcon(icon: FAType, iconSize: CGFloat) {
        
        FAIcon = icon
        font = UIFont(name: font.fontName, size: iconSize)
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
        setTitleTextAttributes([NSFontAttributeName: font!], forState: .Normal)
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
            setTitleTextAttributes([NSFontAttributeName: font!], forState: .Normal)
            title = newValue?.text
        }
        
        get {
            if let title = title {
                
                if let index =  FAIcons.indexOf(title) {
                    return FAType(rawValue: index)
                }
            }
            return nil
        }
    }
}

private struct FAStruct {
    
    static let FontName = "FontAwesome"
    static let ErrorAnnounce = "****** FONT AWESOME SWIFT - FontAwesome font not found in the bundle or not associated with Info.plist when manual installation was performed. ******"
}


private class FontLoader {
    
    struct Static {
        static var onceToken : dispatch_once_t = 0
    }
    
    static func loadFontIfNeeded() {
        if (UIFont.fontNamesForFamilyName(FAStruct.FontName).count == 0) {
            
            dispatch_once(&Static.onceToken) {
                let bundle = NSBundle(forClass: FontLoader.self)
                var fontURL = NSURL()
                let identifier = bundle.bundleIdentifier
                
                if identifier?.hasPrefix("org.cocoapods") == true {
                    
                    fontURL = bundle.URLForResource(FAStruct.FontName, withExtension: "ttf", subdirectory: "Font-Awesome-Swift.bundle")!
                } else {
                    
                    fontURL = bundle.URLForResource(FAStruct.FontName, withExtension: "ttf")!
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
public enum FAType: Int {
    
    static var count: Int {
        
        return FAIcons.count
    }
    
    var text: String? {
        
        return FAIcons[rawValue]
    }
    
    case FA500Px, FAAdjust, FAAdn, FAAlignCenter, FAAlignJustify, FAAlignLeft, FAAlignRight, FAAmazon, FAAmbulance, FAAnchor, FAAndroid, FAAngellist, FAAngleDoubleDown, FAAngleDoubleLeft, FAAngleDoubleRight, FAAngleDoubleUp, FAAngleDown, FAAngleLeft, FAAngleRight, FAAngleUp, FAApple, FAArchive, FAAreaChart, FAArrowCircleDown, FAArrowCircleLeft, FAArrowCircleODown, FAArrowCircleOLeft, FAArrowCircleORight, FAArrowCircleOUp, FAArrowCircleRight, FAArrowCircleUp, FAArrowDown, FAArrowLeft, FAArrowRight, FAArrowUp, FAArrows, FAArrowsAlt, FAArrowsH, FAArrowsV, FAAsterisk, FAAt, FAAutomobile, FABackward, FABalanceScale, FABan, FABank, FABarChart, FABarChartO, FABarcode, FABars, FABattery0, FABattery1, FABattery2, FABattery3, FABattery4, FABatteryEmpty, FABatteryFull, FABatteryHalf, FABatteryQuarter, FABatteryThreeQuarters, FABed, FABeer, FABehance, FABehanceSquare, FABell, FABellO, FABellSlash, FABellSlashO, FABicycle, FABinoculars, FABirthdayCake, FABitbucket, FABitbucketSquare, FABitcoin, FABlackTie, FABold, FABolt, FABomb, FABook, FABookmark, FABookmarkO, FABriefcase, FABtc, FABug, FABuilding, FABuildingO, FABullhorn, FABullseye, FABus, FABuysellads, FACab, FACalculator, FACalendar, FACalendarCheckO, FACalendarMinusO, FACalendarO, FACalendarPlusO, FACalendarTimesO, FACamera, FACameraRetro, FACar, FACaretDown, FACaretLeft, FACaretRight, FACaretSquareODown, FACaretSquareOLeft, FACaretSquareORight, FACaretSquareOUp, FACaretUp, FACartArrowDown, FACartPlus, FACc, FACcAmex, FACcDinersClub, FACcDiscover, FACcJcb, FACcMastercard, FACcPaypal, FACcStripe, FACcVisa, FACertificate, FAChain, FAChainBroken, FACheck, FACheckCircle, FACheckCircleO, FACheckSquare, FACheckSquareO, FAChevronCircleDown, FAChevronCircleLeft, FAChevronCircleRight, FAChevronCircleUp, FAChevronDown, FAChevronLeft, FAChevronRight, FAChevronUp, FAChild, FAChrome, FACircle, FACircleO, FACircleONotch, FACircleThin, FAClipboard, FAClockO, FAClone, FAClose, FACloud, FACloudDownload, FACloudUpload, FACny, FACode, FACodeFork, FACodepen, FACoffee, FACog, FACogs, FAColumns, FAComment, FACommentO, FACommenting, FACommentingO, FAComments, FACommentsO, FACompass, FACompress, FAConnectdevelop, FAContao, FACopy, FACopyright, FACreativeCommons, FACreditCard, FACrop, FACrosshairs, FACss3, FACube, FACubes, FACut, FACutlery, FADashboard, FADashcube, FADatabase, FADedent, FADelicious, FADesktop, FADeviantart, FADiamond, FADigg, FADollar, FADotCircleO, FADownload, FADribbble, FADropbox, FADrupal, FAEdit, FAEject, FAEllipsisH, FAEllipsisV, FAEmpire, FAEnvelope, FAEnvelopeO, FAEnvelopeSquare, FAEraser, FAEur, FAEuro, FAExchange, FAExclamation, FAExclamationCircle, FAExclamationTriangle, FAExpand, FAExpeditedssl, FAExternalLink, FAExternalLinkSquare, FAEye, FAEyeSlash, FAEyedropper, FAFacebook, FAFacebookF, FAFacebookOfficial, FAFacebookSquare, FAFastBackward, FAFastForward, FAFax, FAFeed, FAFemale, FAFighterJet, FAFile, FAFileArchiveO, FAFileAudioO, FAFileCodeO, FAFileExcelO, FAFileImageO, FAFileMovieO, FAFileO, FAFilePdfO, FAFilePhotoO, FAFilePictureO, FAFilePowerpointO, FAFileSoundO, FAFileText, FAFileTextO, FAFileVideoO, FAFileWordO, FAFileZipO, FAFilesO, FAFilm, FAFilter, FAFire, FAFireExtinguisher, FAFirefox, FAFlag, FAFlagCheckered, FAFlagO, FAFlash, FAFlask, FAFlickr, FAFloppyO, FAFolder, FAFolderO, FAFolderOpen, FAFolderOpenO, FAFont, FAFonticons, FAForumbee, FAForward, FAFoursquare, FAFrownO, FAFutbolO, FAGamepad, FAGavel, FAGbp, FAGe, FAGear, FAGears, FAGenderless, FAGetPocket, FAGg, FAGgCircle, FAGift, FAGit, FAGitSquare, FAGithub, FAGithubAlt, FAGithubSquare, FAGittip, FAGlass, FAGlobe, FAGoogle, FAGooglePlus, FAGooglePlusSquare, FAGoogleWallet, FAGraduationCap, FAGratipay, FAGroup, FAHSquare, FAHackerNews, FAHandGrabO, FAHandLizardO, FAHandODown, FAHandOLeft, FAHandORight, FAHandOUp, FAHandPaperO, FAHandPeaceO, FAHandPointerO, FAHandRockO, FAHandScissorsO, FAHandSpockO, FAHandStopO, FAHddO, FAHeader, FAHeadphones, FAHeart, FAHeartO, FAHeartbeat, FAHistory, FAHome, FAHospitalO, FAHotel, FAHourglass, FAHourglass1, FAHourglass2, FAHourglass3, FAHourglassEnd, FAHourglassHalf, FAHourglassO, FAHourglassStart, FAHouzz, FAHtml5, FAICursor, FAIls, FAImage, FAInbox, FAIndent, FAIndustry, FAInfo, FAInfoCircle, FAInr, FAInstagram, FAInstitution, FAInternetExplorer, FAIntersex, FAIoxhost, FAItalic, FAJoomla, FAJpy, FAJsfiddle, FAKey, FAKeyboardO, FAKrw, FALanguage, FALaptop, FALastfm, FALastfmSquare, FALeaf, FALeanpub, FALegal, FALemonO, FALevelDown, FALevelUp, FALifeBouy, FALifeBuoy, FALifeRing, FALifeSaver, FALightbulbO, FALineChart, FALink, FALinkedin, FALinkedinSquare, FALinux, FAList, FAListAlt, FAListOl, FAListUl, FALocationArrow, FALock, FALongArrowDown, FALongArrowLeft, FALongArrowRight, FALongArrowUp, FAMagic, FAMagnet, FAMailForward, FAMailReply, FAMailReplyAll, FAMale, FAMap, FAMapMarker, FAMapO, FAMapPin, FAMapSigns, FAMars, FAMarsDouble, FAMarsStroke, FAMarsStrokeH, FAMarsStrokeV, FAMaxcdn, FAMeanpath, FAMedium, FAMedkit, FAMehO, FAMercury, FAMicrophone, FAMicrophoneSlash, FAMinus, FAMinusCircle, FAMinusSquare, FAMinusSquareO, FAMobile, FAMobilePhone, FAMoney, FAMoonO, FAMortarBoard, FAMotorcycle, FAMousePointer, FAMusic, FANavicon, FANeuter, FANewspaperO, FAObjectGroup, FAObjectUngroup, FAOdnoklassniki, FAOdnoklassnikiSquare, FAOpencart, FAOpenid, FAOpera, FAOptinMonster, FAOutdent, FAPagelines, FAPaintBrush, FAPaperPlane, FAPaperPlaneO, FAPaperclip, FAParagraph, FAPaste, FAPause, FAPaw, FAPaypal, FAPencil, FAPencilSquare, FAPencilSquareO, FAPhone, FAPhoneSquare, FAPhoto, FAPictureO, FAPieChart, FAPiedPiper, FAPiedPiperAlt, FAPinterest, FAPinterestP, FAPinterestSquare, FAPlane, FAPlay, FAPlayCircle, FAPlayCircleO, FAPlug, FAPlus, FAPlusCircle, FAPlusSquare, FAPlusSquareO, FAPowerOff, FAPrint, FAPuzzlePiece, FAQq, FAQrcode, FAQuestion, FAQuestionCircle, FAQuoteLeft, FAQuoteRight, FARa, FARandom, FARebel, FARecycle, FAReddit, FARedditSquare, FARefresh, FARegistered, FARemove, FARenren, FAReorder, FARepeat, FAReply, FAReplyAll, FARetweet, FARmb, FARoad, FARocket, FARotateLeft, FARotateRight, FARouble, FARss, FARssSquare, FARub, FARuble, FARupee, FASafari, FASave, FAScissors, FASearch, FASearchMinus, FASearchPlus, FASellsy, FASend, FASendO, FAServer, FAShare, FAShareAlt, FAShareAltSquare, FAShareSquare, FAShareSquareO, FAShekel, FASheqel, FAShield, FAShip, FAShirtsinbulk, FAShoppingCart, FASignIn, FASignOut, FASignal, FASimplybuilt, FASitemap, FASkyatlas, FASkype, FASlack, FASliders, FASlideshare, FASmileO, FASoccerBallO, FASort, FASortAlphaAsc, FASortAlphaDesc, FASortAmountAsc, FASortAmountDesc, FASortAsc, FASortDesc, FASortDown, FASortNumericAsc, FASortNumericDesc, FASortUp, FASoundcloud, FASpaceShuttle, FASpinner, FASpoon, FASpotify, FASquare, FASquareO, FAStackExchange, FAStackOverflow, FAStar, FAStarHalf, FAStarHalfEmpty, FAStarHalfFull, FAStarHalfO, FAStarO, FASteam, FASteamSquare, FAStepBackward, FAStepForward, FAStethoscope, FAStickyNote, FAStickyNoteO, FAStop, FAStreetView, FAStrikethrough, FAStumbleupon, FAStumbleuponCircle, FASubscript, FASubway, FASuitcase, FASunO, FASuperscript, FASupport, FATable, FATablet, FATachometer, FATag, FATags, FATasks, FATaxi, FATelevision, FATencentWeibo, FATerminal, FATextHeight, FATextWidth, FATh, FAThLarge, FAThList, FAThumbTack, FAThumbsDown, FAThumbsODown, FAThumbsOUp, FAThumbsUp, FATicket, FATimes, FATimesCircle, FATimesCircleO, FATint, FAToggleDown, FAToggleLeft, FAToggleOff, FAToggleOn, FAToggleRight, FAToggleUp, FATrademark, FATrain, FATransgender, FATransgenderAlt, FATrash, FATrashO, FATree, FATrello, FATripadvisor, FATrophy, FATruck, FATry, FATty, FATumblr, FATumblrSquare, FATurkishLira, FATv, FATwitch, FATwitter, FATwitterSquare, FAUmbrella, FAUnderline, FAUndo, FAUniversity, FAUnlink, FAUnlock, FAUnlockAlt, FAUnsorted, FAUpload, FAUsd, FAUser, FAUserMd, FAUserPlus, FAUserSecret, FAUserTimes, FAUsers, FAVenus, FAVenusDouble, FAVenusMars, FAViacoin, FAVideoCamera, FAVimeo, FAVimeoSquare, FAVine, FAVk, FAVolumeDown, FAVolumeOff, FAVolumeUp, FAWarning, FAWechat, FAWeibo, FAWeixin, FAWhatsapp, FAWheelchair, FAWifi, FAWikipediaW, FAWindows, FAWon, FAWordpress, FAWrench, FAXing, FAXingSquare, FAYCombinator, FAYCombinatorSquare, FAYahoo, FAYc, FAYcSquare, FAYelp, FAYen, FAYoutube, FAYoutubePlay, FAYoutubeSquare
    
}

private let FAIcons = ["\u{f26e}", "\u{f042}", "\u{f170}", "\u{f037}", "\u{f039}", "\u{f036}", "\u{f038}", "\u{f270}", "\u{f0f9}", "\u{f13d}", "\u{f17b}", "\u{f209}", "\u{f103}", "\u{f100}", "\u{f101}", "\u{f102}", "\u{f107}", "\u{f104}", "\u{f105}", "\u{f106}", "\u{f179}", "\u{f187}", "\u{f1fe}", "\u{f0ab}", "\u{f0a8}", "\u{f01a}", "\u{f190}", "\u{f18e}", "\u{f01b}", "\u{f0a9}", "\u{f0aa}", "\u{f063}", "\u{f060}", "\u{f061}", "\u{f062}", "\u{f047}", "\u{f0b2}", "\u{f07e}", "\u{f07d}", "\u{f069}", "\u{f1fa}", "\u{f1b9}", "\u{f04a}", "\u{f24e}", "\u{f05e}", "\u{f19c}", "\u{f080}", "\u{f080}", "\u{f02a}", "\u{f0c9}", "\u{f244}", "\u{f243}", "\u{f242}", "\u{f241}", "\u{f240}", "\u{f244}", "\u{f240}", "\u{f242}", "\u{f243}", "\u{f241}", "\u{f236}", "\u{f0fc}", "\u{f1b4}", "\u{f1b5}", "\u{f0f3}", "\u{f0a2}", "\u{f1f6}", "\u{f1f7}", "\u{f206}", "\u{f1e5}", "\u{f1fd}", "\u{f171}", "\u{f172}", "\u{f15a}", "\u{f27e}", "\u{f032}", "\u{f0e7}", "\u{f1e2}", "\u{f02d}", "\u{f02e}", "\u{f097}", "\u{f0b1}", "\u{f15a}", "\u{f188}", "\u{f1ad}", "\u{f0f7}", "\u{f0a1}", "\u{f140}", "\u{f207}", "\u{f20d}", "\u{f1ba}", "\u{f1ec}", "\u{f073}", "\u{f274}", "\u{f272}", "\u{f133}", "\u{f271}", "\u{f273}", "\u{f030}", "\u{f083}", "\u{f1b9}", "\u{f0d7}", "\u{f0d9}", "\u{f0da}", "\u{f150}", "\u{f191}", "\u{f152}", "\u{f151}", "\u{f0d8}", "\u{f218}", "\u{f217}", "\u{f20a}", "\u{f1f3}", "\u{f24c}", "\u{f1f2}", "\u{f24b}", "\u{f1f1}", "\u{f1f4}", "\u{f1f5}", "\u{f1f0}", "\u{f0a3}", "\u{f0c1}", "\u{f127}", "\u{f00c}", "\u{f058}", "\u{f05d}", "\u{f14a}", "\u{f046}", "\u{f13a}", "\u{f137}", "\u{f138}", "\u{f139}", "\u{f078}", "\u{f053}", "\u{f054}", "\u{f077}", "\u{f1ae}", "\u{f268}", "\u{f111}", "\u{f10c}", "\u{f1ce}", "\u{f1db}", "\u{f0ea}", "\u{f017}", "\u{f24d}", "\u{f00d}", "\u{f0c2}", "\u{f0ed}", "\u{f0ee}", "\u{f157}", "\u{f121}", "\u{f126}", "\u{f1cb}", "\u{f0f4}", "\u{f013}", "\u{f085}", "\u{f0db}", "\u{f075}", "\u{f0e5}", "\u{f27a}", "\u{f27b}", "\u{f086}", "\u{f0e6}", "\u{f14e}", "\u{f066}", "\u{f20e}", "\u{f26d}", "\u{f0c5}", "\u{f1f9}", "\u{f25e}", "\u{f09d}", "\u{f125}", "\u{f05b}", "\u{f13c}", "\u{f1b2}", "\u{f1b3}", "\u{f0c4}", "\u{f0f5}", "\u{f0e4}", "\u{f210}", "\u{f1c0}", "\u{f03b}", "\u{f1a5}", "\u{f108}", "\u{f1bd}", "\u{f219}", "\u{f1a6}", "\u{f155}", "\u{f192}", "\u{f019}", "\u{f17d}", "\u{f16b}", "\u{f1a9}", "\u{f044}", "\u{f052}", "\u{f141}", "\u{f142}", "\u{f1d1}", "\u{f0e0}", "\u{f003}", "\u{f199}", "\u{f12d}", "\u{f153}", "\u{f153}", "\u{f0ec}", "\u{f12a}", "\u{f06a}", "\u{f071}", "\u{f065}", "\u{f23e}", "\u{f08e}", "\u{f14c}", "\u{f06e}", "\u{f070}", "\u{f1fb}", "\u{f09a}", "\u{f09a}", "\u{f230}", "\u{f082}", "\u{f049}", "\u{f050}", "\u{f1ac}", "\u{f09e}", "\u{f182}", "\u{f0fb}", "\u{f15b}", "\u{f1c6}", "\u{f1c7}", "\u{f1c9}", "\u{f1c3}", "\u{f1c5}", "\u{f1c8}", "\u{f016}", "\u{f1c1}", "\u{f1c5}", "\u{f1c5}", "\u{f1c4}", "\u{f1c7}", "\u{f15c}", "\u{f0f6}", "\u{f1c8}", "\u{f1c2}", "\u{f1c6}", "\u{f0c5}", "\u{f008}", "\u{f0b0}", "\u{f06d}", "\u{f134}", "\u{f269}", "\u{f024}", "\u{f11e}", "\u{f11d}", "\u{f0e7}", "\u{f0c3}", "\u{f16e}", "\u{f0c7}", "\u{f07b}", "\u{f114}", "\u{f07c}", "\u{f115}", "\u{f031}", "\u{f280}", "\u{f211}", "\u{f04e}", "\u{f180}", "\u{f119}", "\u{f1e3}", "\u{f11b}", "\u{f0e3}", "\u{f154}", "\u{f1d1}", "\u{f013}", "\u{f085}", "\u{f22d}", "\u{f265}", "\u{f260}", "\u{f261}", "\u{f06b}", "\u{f1d3}", "\u{f1d2}", "\u{f09b}", "\u{f113}", "\u{f092}", "\u{f184}", "\u{f000}", "\u{f0ac}", "\u{f1a0}", "\u{f0d5}", "\u{f0d4}", "\u{f1ee}", "\u{f19d}", "\u{f184}", "\u{f0c0}", "\u{f0fd}", "\u{f1d4}", "\u{f255}", "\u{f258}", "\u{f0a7}", "\u{f0a5}", "\u{f0a4}", "\u{f0a6}", "\u{f256}", "\u{f25b}", "\u{f25a}", "\u{f255}", "\u{f257}", "\u{f259}", "\u{f256}", "\u{f0a0}", "\u{f1dc}", "\u{f025}", "\u{f004}", "\u{f08a}", "\u{f21e}", "\u{f1da}", "\u{f015}", "\u{f0f8}", "\u{f236}", "\u{f254}", "\u{f251}", "\u{f252}", "\u{f253}", "\u{f253}", "\u{f252}", "\u{f250}", "\u{f251}", "\u{f27c}", "\u{f13b}", "\u{f246}", "\u{f20b}", "\u{f03e}", "\u{f01c}", "\u{f03c}", "\u{f275}", "\u{f129}", "\u{f05a}", "\u{f156}", "\u{f16d}", "\u{f19c}", "\u{f26b}", "\u{f224}", "\u{f208}", "\u{f033}", "\u{f1aa}", "\u{f157}", "\u{f1cc}", "\u{f084}", "\u{f11c}", "\u{f159}", "\u{f1ab}", "\u{f109}", "\u{f202}", "\u{f203}", "\u{f06c}", "\u{f212}", "\u{f0e3}", "\u{f094}", "\u{f149}", "\u{f148}", "\u{f1cd}", "\u{f1cd}", "\u{f1cd}", "\u{f1cd}", "\u{f0eb}", "\u{f201}", "\u{f0c1}", "\u{f0e1}", "\u{f08c}", "\u{f17c}", "\u{f03a}", "\u{f022}", "\u{f0cb}", "\u{f0ca}", "\u{f124}", "\u{f023}", "\u{f175}", "\u{f177}", "\u{f178}", "\u{f176}", "\u{f0d0}", "\u{f076}", "\u{f064}", "\u{f112}", "\u{f122}", "\u{f183}", "\u{f279}", "\u{f041}", "\u{f278}", "\u{f276}", "\u{f277}", "\u{f222}", "\u{f227}", "\u{f229}", "\u{f22b}", "\u{f22a}", "\u{f136}", "\u{f20c}", "\u{f23a}", "\u{f0fa}", "\u{f11a}", "\u{f223}", "\u{f130}", "\u{f131}", "\u{f068}", "\u{f056}", "\u{f146}", "\u{f147}", "\u{f10b}", "\u{f10b}", "\u{f0d6}", "\u{f186}", "\u{f19d}", "\u{f21c}", "\u{f245}", "\u{f001}", "\u{f0c9}", "\u{f22c}", "\u{f1ea}", "\u{f247}", "\u{f248}", "\u{f263}", "\u{f264}", "\u{f23d}", "\u{f19b}", "\u{f26a}", "\u{f23c}", "\u{f03b}", "\u{f18c}", "\u{f1fc}", "\u{f1d8}", "\u{f1d9}", "\u{f0c6}", "\u{f1dd}", "\u{f0ea}", "\u{f04c}", "\u{f1b0}", "\u{f1ed}", "\u{f040}", "\u{f14b}", "\u{f044}", "\u{f095}", "\u{f098}", "\u{f03e}", "\u{f03e}", "\u{f200}", "\u{f1a7}", "\u{f1a8}", "\u{f0d2}", "\u{f231}", "\u{f0d3}", "\u{f072}", "\u{f04b}", "\u{f144}", "\u{f01d}", "\u{f1e6}", "\u{f067}", "\u{f055}", "\u{f0fe}", "\u{f196}", "\u{f011}", "\u{f02f}", "\u{f12e}", "\u{f1d6}", "\u{f029}", "\u{f128}", "\u{f059}", "\u{f10d}", "\u{f10e}", "\u{f1d0}", "\u{f074}", "\u{f1d0}", "\u{f1b8}", "\u{f1a1}", "\u{f1a2}", "\u{f021}", "\u{f25d}", "\u{f00d}", "\u{f18b}", "\u{f0c9}", "\u{f01e}", "\u{f112}", "\u{f122}", "\u{f079}", "\u{f157}", "\u{f018}", "\u{f135}", "\u{f0e2}", "\u{f01e}", "\u{f158}", "\u{f09e}", "\u{f143}", "\u{f158}", "\u{f158}", "\u{f156}", "\u{f267}", "\u{f0c7}", "\u{f0c4}", "\u{f002}", "\u{f010}", "\u{f00e}", "\u{f213}", "\u{f1d8}", "\u{f1d9}", "\u{f233}", "\u{f064}", "\u{f1e0}", "\u{f1e1}", "\u{f14d}", "\u{f045}", "\u{f20b}", "\u{f20b}", "\u{f132}", "\u{f21a}", "\u{f214}", "\u{f07a}", "\u{f090}", "\u{f08b}", "\u{f012}", "\u{f215}", "\u{f0e8}", "\u{f216}", "\u{f17e}", "\u{f198}", "\u{f1de}", "\u{f1e7}", "\u{f118}", "\u{f1e3}", "\u{f0dc}", "\u{f15d}", "\u{f15e}", "\u{f160}", "\u{f161}", "\u{f0de}", "\u{f0dd}", "\u{f0dd}", "\u{f162}", "\u{f163}", "\u{f0de}", "\u{f1be}", "\u{f197}", "\u{f110}", "\u{f1b1}", "\u{f1bc}", "\u{f0c8}", "\u{f096}", "\u{f18d}", "\u{f16c}", "\u{f005}", "\u{f089}", "\u{f123}", "\u{f123}", "\u{f123}", "\u{f006}", "\u{f1b6}", "\u{f1b7}", "\u{f048}", "\u{f051}", "\u{f0f1}", "\u{f249}", "\u{f24a}", "\u{f04d}", "\u{f21d}", "\u{f0cc}", "\u{f1a4}", "\u{f1a3}", "\u{f12c}", "\u{f239}", "\u{f0f2}", "\u{f185}", "\u{f12b}", "\u{f1cd}", "\u{f0ce}", "\u{f10a}", "\u{f0e4}", "\u{f02b}", "\u{f02c}", "\u{f0ae}", "\u{f1ba}", "\u{f26c}", "\u{f1d5}", "\u{f120}", "\u{f034}", "\u{f035}", "\u{f00a}", "\u{f009}", "\u{f00b}", "\u{f08d}", "\u{f165}", "\u{f088}", "\u{f087}", "\u{f164}", "\u{f145}", "\u{f00d}", "\u{f057}", "\u{f05c}", "\u{f043}", "\u{f150}", "\u{f191}", "\u{f204}", "\u{f205}", "\u{f152}", "\u{f151}", "\u{f25c}", "\u{f238}", "\u{f224}", "\u{f225}", "\u{f1f8}", "\u{f014}", "\u{f1bb}", "\u{f181}", "\u{f262}", "\u{f091}", "\u{f0d1}", "\u{f195}", "\u{f1e4}", "\u{f173}", "\u{f174}", "\u{f195}", "\u{f26c}", "\u{f1e8}", "\u{f099}", "\u{f081}", "\u{f0e9}", "\u{f0cd}", "\u{f0e2}", "\u{f19c}", "\u{f127}", "\u{f09c}", "\u{f13e}", "\u{f0dc}", "\u{f093}", "\u{f155}", "\u{f007}", "\u{f0f0}", "\u{f234}", "\u{f21b}", "\u{f235}", "\u{f0c0}", "\u{f221}", "\u{f226}", "\u{f228}", "\u{f237}", "\u{f03d}", "\u{f27d}", "\u{f194}", "\u{f1ca}", "\u{f189}", "\u{f027}", "\u{f026}", "\u{f028}", "\u{f071}", "\u{f1d7}", "\u{f18a}", "\u{f1d7}", "\u{f232}", "\u{f193}", "\u{f1eb}", "\u{f266}", "\u{f17a}", "\u{f159}", "\u{f19a}", "\u{f0ad}", "\u{f168}", "\u{f169}", "\u{f23b}", "\u{f1d4}", "\u{f19e}", "\u{f23b}", "\u{f1d4}", "\u{f1e9}", "\u{f157}", "\u{f167}", "\u{f16a}", "\u{f166}"]