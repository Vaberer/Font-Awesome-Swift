//
//  ViewController.swift
//  AF Swift
//
//  Created by Patrik Vaberer on 7/13/15.
//  Copyright (c) 2015 Patrik Vaberer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bGithub: UIBarButtonItem!
    @IBOutlet weak var bTwitter: UIBarButtonItem!
    var filteredData = [String]()
    var resultSearchController = UISearchController()
    
    @IBOutlet weak var l: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b.isHidden = true
        b.setFAText(prefixText: "prefix ", icon: .FATwitter, postfixText: " postfix", size: 30, forState: .normal, iconSize: 20)
        b.setFATitleColor(color: UIColor.red)

        l.isHidden = true
        l.setFAText(prefixText: "prefix ", icon: .FATwitter, postfixText: " postfix", size: 30, iconSize: 20)
        l.setFAColor(color: UIColor.red)

        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.delegate = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.barTintColor = UIColor.blue
            controller.searchBar.placeholder = "Type Icon Name"
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        bGithub.setFAIcon(icon: FAType.FAGithub, iconSize: 35)
        bTwitter.setFAIcon(icon: FAType.FATwitter, iconSize: 35)
    }
    
    
    @IBAction func bPressed(sender: AnyObject) {
        
        l.setFAText(prefixText: "prefix ", icon: .FATwitter, postfixText: "", size: 30, iconSize: 20)
        l.setFAColor(color: UIColor.green)
//        l.FAIcon = .FATwitter
        

        b.setFAText(prefixText: "", icon: .FATwitter, postfixText: " postfix", size: 30, forState: .normal, iconSize: 20)
        b.setFATitleColor(color: UIColor.green)

//        b.setFAIcon(.FATwitter, forState: .Normal)
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
    }
    
    @IBOutlet weak var b: UIButton!
    //MARK: UITableView
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let c = tableView.dequeueReusableCell(withIdentifier: "IconCell") as! IconCell
        
        c.lFont.text = resultSearchController.isActive ? filteredData[indexPath.row] : helper[indexPath.row]
        
        let icon = resultSearchController.isActive ? FAType(rawValue: helper.index(of: filteredData[indexPath.row])!) : FAType(rawValue: indexPath.row)
        c.lSmall.FAIcon = icon
        c.lMedium.FAIcon = icon
        c.lBig.FAIcon = icon
        c.iIcon.setFAIconWithName(icon: icon!, textColor: UIColor.black)
        return c
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultSearchController.isActive ? filteredData.count :  FAType.count
    }
    
    
    // MARK: Search
    
    
    func updateSearchResults(for searchController: UISearchController)
    {
        filteredData = []
        filterContentForSearchText(searchText: searchController.searchBar.text!.lowercased())
        self.tableView.reloadData()
    }
    
    
    @IBAction func bGithubPressed(sender: UIBarButtonItem) {
        
        if let requestUrl = NSURL(string: "https://github.com/Vaberer/Font-Awesome-Swift") {
            UIApplication.shared.openURL(requestUrl as URL)
        }
    }
    
    
    @IBAction func bTwitterPressed(sender: UIBarButtonItem) {
        
        if let twitterURL = NSURL(string: "twitter://user?id=2271666416") {
            
            if UIApplication.shared.canOpenURL(twitterURL as URL) {
                
                UIApplication.shared.openURL(twitterURL as URL)
            }
        }
    }
    
    
    // MARK: Helpers
    func filterContentForSearchText(searchText: String) {
        for f in helper {
            if f.lowercased().range(of: searchText.lowercased()) != nil {
                
                filteredData.append(f)
            }
        }
    }
    
    
    let helper = ["FAGlass", "FAMusic", "FASearch", "FAEnvelopeO", "FAHeart", "FAStar", "FAStarO", "FAUser", "FAFilm", "FAThLarge", "FATh", "FAThList", "FACheck", "FATimes", "FARemove", "FAClose", "FASearchPlus", "FASearchMinus", "FAPowerOff", "FASignal", "FACog", "FAGear", "FATrashO", "FAHome", "FAFileO", "FAClockO", "FARoad", "FADownload", "FAArrowCircleODown", "FAArrowCircleOUp", "FAInbox", "FAPlayCircleO", "FARepeat", "FARotateRight", "FARefresh", "FAListAlt", "FALock", "FAFlag", "FAHeadphones", "FAVolumeOff", "FAVolumeDown", "FAVolumeUp", "FAQrcode", "FABarcode", "FATag", "FATags", "FABook", "FABookmark", "FAPrint", "FACamera", "FAFont", "FABold", "FAItalic", "FATextHeight", "FATextWidth", "FAAlignLeft", "FAAlignCenter", "FAAlignRight", "FAAlignJustify", "FAList", "FAOutdent", "FADedent", "FAIndent", "FAVideoCamera", "FAPictureO", "FAPhoto", "FAImage", "FAPencil", "FAMapMarker", "FAAdjust", "FATint", "FAPencilSquareO", "FAEdit", "FAShareSquareO", "FACheckSquareO", "FAArrows", "FAStepBackward", "FAFastBackward", "FABackward", "FAPlay", "FAPause", "FAStop", "FAForward", "FAFastForward", "FAStepForward", "FAEject", "FAChevronLeft", "FAChevronRight", "FAPlusCircle", "FAMinusCircle", "FATimesCircle", "FACheckCircle", "FAQuestionCircle", "FAInfoCircle", "FACrosshairs", "FATimesCircleO", "FACheckCircleO", "FABan", "FAArrowLeft", "FAArrowRight", "FAArrowUp", "FAArrowDown", "FAShare", "FAMailForward", "FAExpand", "FACompress", "FAPlus", "FAMinus", "FAAsterisk", "FAExclamationCircle", "FAGift", "FALeaf", "FAFire", "FAEye", "FAEyeSlash", "FAExclamationTriangle", "FAWarning", "FAPlane", "FACalendar", "FARandom", "FAComment", "FAMagnet", "FAChevronUp", "FAChevronDown", "FARetweet", "FAShoppingCart", "FAFolder", "FAFolderOpen", "FAArrowsV", "FAArrowsH", "FABarChart", "FABarChartO", "FATwitterSquare", "FAFacebookSquare", "FACameraRetro", "FAKey", "FACogs", "FAGears", "FAComments", "FAThumbsOUp", "FAThumbsODown", "FAStarHalf", "FAHeartO", "FASignOut", "FALinkedinSquare", "FAThumbTack", "FAExternalLink", "FASignIn", "FATrophy", "FAGithubSquare", "FAUpload", "FALemonO", "FAPhone", "FASquareO", "FABookmarkO", "FAPhoneSquare", "FATwitter", "FAFacebook", "FAFacebookF", "FAGithub", "FAUnlock", "FACreditCard", "FARss", "FAFeed", "FAHddO", "FABullhorn", "FABell", "FACertificate", "FAHandORight", "FAHandOLeft", "FAHandOUp", "FAHandODown", "FAArrowCircleLeft", "FAArrowCircleRight", "FAArrowCircleUp", "FAArrowCircleDown", "FAGlobe", "FAWrench", "FATasks", "FAFilter", "FABriefcase", "FAArrowsAlt", "FAUsers", "FAGroup", "FALink", "FAChain", "FACloud", "FAFlask", "FAScissors", "FACut", "FAFilesO", "FACopy", "FAPaperclip", "FAFloppyO", "FASave", "FASquare", "FABars", "FANavicon", "FAReorder", "FAListUl", "FAListOl", "FAStrikethrough", "FAUnderline", "FATable", "FAMagic", "FATruck", "FAPinterest", "FAPinterestSquare", "FAGooglePlusSquare", "FAGooglePlus", "FAMoney", "FACaretDown", "FACaretUp", "FACaretLeft", "FACaretRight", "FAColumns", "FASort", "FAUnsorted", "FASortDesc", "FASortDown", "FASortAsc", "FASortUp", "FAEnvelope", "FALinkedin", "FAUndo", "FARotateLeft", "FAGavel", "FALegal", "FATachometer", "FADashboard", "FACommentO", "FACommentsO", "FABolt", "FAFlash", "FASitemap", "FAUmbrella", "FAClipboard", "FAPaste", "FALightbulbO", "FAExchange", "FACloudDownload", "FACloudUpload", "FAUserMd", "FAStethoscope", "FASuitcase", "FABellO", "FACoffee", "FACutlery", "FAFileTextO", "FABuildingO", "FAHospitalO", "FAAmbulance", "FAMedkit", "FAFighterJet", "FABeer", "FAHSquare", "FAPlusSquare", "FAAngleDoubleLeft", "FAAngleDoubleRight", "FAAngleDoubleUp", "FAAngleDoubleDown", "FAAngleLeft", "FAAngleRight", "FAAngleUp", "FAAngleDown", "FADesktop", "FALaptop", "FATablet", "FAMobile", "FAMobilePhone", "FACircleO", "FAQuoteLeft", "FAQuoteRight", "FASpinner", "FACircle", "FAReply", "FAMailReply", "FAGithubAlt", "FAFolderO", "FAFolderOpenO", "FASmileO", "FAFrownO", "FAMehO", "FAGamepad", "FAKeyboardO", "FAFlagO", "FAFlagCheckered", "FATerminal", "FACode", "FAReplyAll", "FAMailReplyAll", "FAStarHalfO", "FAStarHalfEmpty", "FAStarHalfFull", "FALocationArrow", "FACrop", "FACodeFork", "FAChainBroken", "FAUnlink", "FAQuestion", "FAInfo", "FAExclamation", "FASuperscript", "FASubscript", "FAEraser", "FAPuzzlePiece", "FAMicrophone", "FAMicrophoneSlash", "FAShield", "FACalendarO", "FAFireExtinguisher", "FARocket", "FAMaxcdn", "FAChevronCircleLeft", "FAChevronCircleRight", "FAChevronCircleUp", "FAChevronCircleDown", "FAHtml5", "FACss3", "FAAnchor", "FAUnlockAlt", "FABullseye", "FAEllipsisH", "FAEllipsisV", "FARssSquare", "FAPlayCircle", "FATicket", "FAMinusSquare", "FAMinusSquareO", "FALevelUp", "FALevelDown", "FACheckSquare", "FAPencilSquare", "FAExternalLinkSquare", "FAShareSquare", "FACompass", "FACaretSquareODown", "FAToggleDown", "FACaretSquareOUp", "FAToggleUp", "FACaretSquareORight", "FAToggleRight", "FAEur", "FAEuro", "FAGbp", "FAUsd", "FADollar", "FAInr", "FARupee", "FAJpy", "FACny", "FARmb", "FAYen", "FARub", "FARuble", "FARouble", "FAKrw", "FAWon", "FABtc", "FABitcoin", "FAFile", "FAFileText", "FASortAlphaAsc", "FASortAlphaDesc", "FASortAmountAsc", "FASortAmountDesc", "FASortNumericAsc", "FASortNumericDesc", "FAThumbsUp", "FAThumbsDown", "FAYoutubeSquare", "FAYoutube", "FAXing", "FAXingSquare", "FAYoutubePlay", "FADropbox", "FAStackOverflow", "FAInstagram", "FAFlickr", "FAAdn", "FABitbucket", "FABitbucketSquare", "FATumblr", "FATumblrSquare", "FALongArrowDown", "FALongArrowUp", "FALongArrowLeft", "FALongArrowRight", "FAApple", "FAWindows", "FAAndroid", "FALinux", "FADribbble", "FASkype", "FAFoursquare", "FATrello", "FAFemale", "FAMale", "FAGratipay", "FAGittip", "FASunO", "FAMoonO", "FAArchive", "FABug", "FAVk", "FAWeibo", "FARenren", "FAPagelines", "FAStackExchange", "FAArrowCircleORight", "FAArrowCircleOLeft", "FACaretSquareOLeft", "FAToggleLeft", "FADotCircleO", "FAWheelchair", "FAVimeoSquare", "FATry", "FATurkishLira", "FAPlusSquareO", "FASpaceShuttle", "FASlack", "FAEnvelopeSquare", "FAWordpress", "FAOpenid", "FAUniversity", "FAInstitution", "FABank", "FAGraduationCap", "FAMortarBoard", "FAYahoo", "FAGoogle", "FAReddit", "FARedditSquare", "FAStumbleuponCircle", "FAStumbleupon", "FADelicious", "FADigg", "FAPiedPiperPp", "FAPiedPiperAlt", "FADrupal", "FAJoomla", "FALanguage", "FAFax", "FABuilding", "FAChild", "FAPaw", "FASpoon", "FACube", "FACubes", "FABehance", "FABehanceSquare", "FASteam", "FASteamSquare", "FARecycle", "FACar", "FAAutomobile", "FATaxi", "FACab", "FATree", "FASpotify", "FADeviantart", "FASoundcloud", "FADatabase", "FAFilePdfO", "FAFileWordO", "FAFileExcelO", "FAFilePowerpointO", "FAFileImageO", "FAFilePhotoO", "FAFilePictureO", "FAFileArchiveO", "FAFileZipO", "FAFileAudioO", "FAFileSoundO", "FAFileVideoO", "FAFileMovieO", "FAFileCodeO", "FAVine", "FACodepen", "FAJsfiddle", "FALifeRing", "FALifeBouy", "FALifeBuoy", "FALifeSaver", "FASupport", "FACircleONotch", "FARebel", "FARa", "FAResistance", "FAEmpire", "FAGe", "FAGitSquare", "FAGit", "FAHackerNews", "FAYCombinatorSquare", "FAYcSquare", "FATencentWeibo", "FAQq", "FAWeixin", "FAWechat", "FAPaperPlane", "FASend", "FAPaperPlaneO", "FASendO", "FAHistory", "FACircleThin", "FAHeader", "FAParagraph", "FASliders", "FAShareAlt", "FAShareAltSquare", "FABomb", "FAFutbolO", "FASoccerBallO", "FATty", "FABinoculars", "FAPlug", "FASlideshare", "FATwitch", "FAYelp", "FANewspaperO", "FAWifi", "FACalculator", "FAPaypal", "FAGoogleWallet", "FACcVisa", "FACcMastercard", "FACcDiscover", "FACcAmex", "FACcPaypal", "FACcStripe", "FABellSlash", "FABellSlashO", "FATrash", "FACopyright", "FAAt", "FAEyedropper", "FAPaintBrush", "FABirthdayCake", "FAAreaChart", "FAPieChart", "FALineChart", "FALastfm", "FALastfmSquare", "FAToggleOff", "FAToggleOn", "FABicycle", "FABus", "FAIoxhost", "FAAngellist", "FACc", "FAIls", "FAShekel", "FASheqel", "FAMeanpath", "FABuysellads", "FAConnectdevelop", "FADashcube", "FAForumbee", "FALeanpub", "FASellsy", "FAShirtsinbulk", "FASimplybuilt", "FASkyatlas", "FACartPlus", "FACartArrowDown", "FADiamond", "FAShip", "FAUserSecret", "FAMotorcycle", "FAStreetView", "FAHeartbeat", "FAVenus", "FAMars", "FAMercury", "FATransgender", "FAIntersex", "FATransgenderAlt", "FAVenusDouble", "FAMarsDouble", "FAVenusMars", "FAMarsStroke", "FAMarsStrokeV", "FAMarsStrokeH", "FANeuter", "FAGenderless", "FAFacebookOfficial", "FAPinterestP", "FAWhatsapp", "FAServer", "FAUserPlus", "FAUserTimes", "FABed", "FAHotel", "FAViacoin", "FATrain", "FASubway", "FAMedium", "FAYCombinator", "FAYc", "FAOptinMonster", "FAOpencart", "FAExpeditedssl", "FABatteryFull", "FABattery4", "FABatteryThreeQuarters", "FABattery3", "FABatteryHalf", "FABattery2", "FABatteryQuarter", "FABattery1", "FABatteryEmpty", "FABattery0", "FAMousePointer", "FAICursor", "FAObjectGroup", "FAObjectUngroup", "FAStickyNote", "FAStickyNoteO", "FACcJcb", "FACcDinersClub", "FAClone", "FABalanceScale", "FAHourglassO", "FAHourglassStart", "FAHourglass1", "FAHourglassHalf", "FAHourglass2", "FAHourglassEnd", "FAHourglass3", "FAHourglass", "FAHandRockO", "FAHandGrabO", "FAHandPaperO", "FAHandStopO", "FAHandScissorsO", "FAHandLizardO", "FAHandSpockO", "FAHandPointerO", "FAHandPeaceO", "FATrademark", "FARegistered", "FACreativeCommons", "FAGg", "FAGgCircle", "FATripadvisor", "FAOdnoklassniki", "FAOdnoklassnikiSquare", "FAGetPocket", "FAWikipediaW", "FASafari", "FAChrome", "FAFirefox", "FAOpera", "FAInternetExplorer", "FATelevision", "FATv", "FAContao", "FA500px", "FAAmazon", "FACalendarPlusO", "FACalendarMinusO", "FACalendarTimesO", "FACalendarCheckO", "FAIndustry", "FAMapPin", "FAMapSigns", "FAMapO", "FAMap", "FACommenting", "FACommentingO", "FAHouzz", "FAVimeo", "FABlackTie", "FAFonticons", "FARedditAlien", "FAEdge", "FACreditCardAlt", "FACodiepie", "FAModx", "FAFortAwesome", "FAUsb", "FAProductHunt", "FAMixcloud", "FAScribd", "FAPauseCircle", "FAPauseCircleO", "FAStopCircle", "FAStopCircleO", "FAShoppingBag", "FAShoppingBasket", "FAHashtag", "FABluetooth", "FABluetoothB", "FAPercent", "FAGitlab", "FAWpbeginner", "FAWpforms", "FAEnvira", "FAUniversalAccess", "FAWheelchairAlt", "FAQuestionCircleO", "FABlind", "FAAudioDescription", "FAVolumeControlPhone", "FABraille", "FAAssistiveListeningSystems", "FAAmericanSignLanguageInterpreting", "FAAslInterpreting", "FADeaf", "FADeafness", "FAHardOfHearing", "FAGlide", "FAGlideG", "FASignLanguage", "FASigning", "FALowVision", "FAViadeo", "FAViadeoSquare", "FASnapchat", "FASnapchatGhost", "FASnapchatSquare", "FAPiedPiper", "FAFirstOrder", "FAYoast", "FAThemeisle", "FAGooglePlusOfficial", "FAGooglePlusCircle", "FAFontAwesome", "FAFa", "FAAddressBook", "FAAddressBookO", "FAAdressCard", "FAAdressCardO", "FABandcamp", "FABath", "FABathtub", "FADriversLicense", "FADriversLicenseO", "FAEerCast", "FAEnvelopeOpen", "FAEnvelopeOpenO", "FAEtsy", "FAFreeCodeCamp", "FAGrav", "FAHandshakeO", "FAIdBadge", "FAIdCard", "FAIdCardO", "FAImdb", "FALinode", "FAMeetup", "FAMicrochip", "FAPodcast", "FAQuora", "FARavelry", "FAS15", "FAShower", "FASnowflakeO", "FASuperpowers", "FATelegram", "FAThermometer", "FAThermometer0", "FAThermometer1", "FAThermometer2", "FAThermometer3", "FAThermometer4", "FAThermometerEmpty", "FAThermometerFull", "FAThermometerHalf", "FAThermometerQuarter", "FAThermometerThreeQuarters", "FATimesRectangle", "FATimesRectangleO", "FAUserCircle", "FAUserCircleO", "FAUserO", "FAVcard", "FAVcardO", "FAWindowClose", "FAWindowCloseO", "FAWindowMaximize", "FAWindowMinimize", "FAWindowRestore", "FAWPExplorer"
    ]
}
