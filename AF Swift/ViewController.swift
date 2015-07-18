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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.delegate = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.barTintColor = UIColor.blueColor()
            controller.searchBar.placeholder = "Type Icon Name"
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        bGithub.setFAIcon(FAType.FAGithub, iconSize: 35)
        bTwitter.setFAIcon(FAType.FATwitter, iconSize: 35)
    }
    
    
    //MARK: UITableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let c = tableView.dequeueReusableCellWithIdentifier("IconCell") as! IconCell
        
        c.lFont.text = resultSearchController.active ? filteredData[indexPath.row] : helper[indexPath.row]
        
        let icon = resultSearchController.active ? FAType(rawValue: find(helper, filteredData[indexPath.row])!) : FAType(rawValue: indexPath.row)
        c.lSmall.FAIcon = icon
        c.lMedium.FAIcon = icon
        c.lBig.FAIcon = icon
        
        return c
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultSearchController.active ? filteredData.count :  FAType.count
    }
    
    
    //MARK: Search
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredData = []
        filterContentForSearchText(searchController.searchBar.text.lowercaseString)
        self.tableView.reloadData()
    }
    
    @IBAction func bGithubPressed(sender: UIBarButtonItem) {
        
        if let requestUrl = NSURL(string: "https://github.com/Vaberer/Font-Awesome-Swift") {
            UIApplication.sharedApplication().openURL(requestUrl)
        }
    }
    
    @IBAction func bTwitterPressed(sender: UIBarButtonItem) {
        
        if let twitterURL = NSURL(string: "twitter://user?id=2271666416") {
            
            if UIApplication.sharedApplication().canOpenURL(twitterURL) {
                
                UIApplication.sharedApplication().openURL(twitterURL)
            }
            
        }
    }
    
    //MARK: Helpers
    func filterContentForSearchText(searchText: String) {
        
        for f in helper {
            if f.lowercaseString.rangeOfString(searchText.lowercaseString) != nil {
                filteredData.append(f)
            }
        }
    }
    
    let helper = ["FAAdjust", "FAAdn", "FAAlignCenter", "FAAlignJustify", "FAAlignLeft", "FAAlignRight", "FAAmbulance", "FAAnchor", "FAAndroid", "FAAngellist", "FAAngleDoubleDown", "FAAngleDoubleLeft", "FAAngleDoubleRight", "FAAngleDoubleUp", "FAAngleDown", "FAAngleLeft", "FAAngleRight", "FAAngleUp", "FAApple", "FAArchive", "FAAreaChart", "FAArrowCircleDown", "FAArrowCircleLeft", "FAArrowCircleODown", "FAArrowCircleOLeft", "FAArrowCircleORight", "FAArrowCircleOUp", "FAArrowCircleRight", "FAArrowCircleUp", "FAArrowDown", "FAArrowLeft", "FAArrowRight", "FAArrowUp", "FAArrows", "FAArrowsAlt", "FAArrowsH", "FAArrowsV", "FAAsterisk", "FAAt", "FAAutomobile", "FABackward", "FABan", "FABank", "FABarChart", "FABarChartO", "FABarcode", "FABars", "FABed", "FABeer", "FABehance", "FABehanceSquare", "FABell", "FABellO", "FABellSlash", "FABellSlashO", "FABicycle", "FABinoculars", "FABirthdayCake", "FABitbucket", "FABitbucketSquare", "FABitcoin", "FABold", "FABolt", "FABomb", "FABook", "FABookmark", "FABookmarkO", "FABriefcase", "FABtc", "FABug", "FABuilding", "FABuildingO", "FABullhorn", "FABullseye", "FABus", "FABuysellads", "FACab", "FACalculator", "FACalendar", "FACalendarO", "FACamera", "FACameraRetro", "FACar", "FACaretDown", "FACaretLeft", "FACaretRight", "FACaretSquareODown", "FACaretSquareOLeft", "FACaretSquareORight", "FACaretSquareOUp", "FACaretUp", "FACartArrowDown", "FACartPlus", "FACc", "FACcAmex", "FACcDiscover", "FACcMastercard", "FACcPaypal", "FACcStripe", "FACcVisa", "FACertificate", "FAChain", "FAChainBroken", "FACheck", "FACheckCircle", "FACheckCircleO", "FACheckSquare", "FACheckSquareO", "FAChevronCircleDown", "FAChevronCircleLeft", "FAChevronCircleRight", "FAChevronCircleUp", "FAChevronDown", "FAChevronLeft", "FAChevronRight", "FAChevronUp", "FAChild", "FACircle", "FACircleO", "FACircleONotch", "FACircleThin", "FAClipboard", "FAClockO", "FAClose", "FACloud", "FACloudDownload", "FACloudUpload", "FACny", "FACode", "FACodeFork", "FACodepen", "FACoffee", "FACog", "FACogs", "FAColumns", "FAComment", "FACommentO", "FAComments", "FACommentsO", "FACompass", "FACompress", "FAConnectdevelop", "FACopy", "FACopyright", "FACreditCard", "FACrop", "FACrosshairs", "FACss3", "FACube", "FACubes", "FACut", "FACutlery", "FADashboard", "FADashcube", "FADatabase", "FADedent", "FADelicious", "FADesktop", "FADeviantart", "FADiamond", "FADigg", "FADollar", "FADotCircleO", "FADownload", "FADribbble", "FADropbox", "FADrupal", "FAEdit", "FAEject", "FAEllipsisH", "FAEllipsisV", "FAEmpire", "FAEnvelope", "FAEnvelopeO", "FAEnvelopeSquare", "FAEraser", "FAEur", "FAEuro", "FAExchange", "FAExclamation", "FAExclamationCircle", "FAExclamationTriangle", "FAExpand", "FAExternalLink", "FAExternalLinkSquare", "FAEye", "FAEyeSlash", "FAEyedropper", "FAFacebook", "FAFacebookF", "FAFacebookOfficial", "FAFacebookSquare", "FAFastBackward", "FAFastForward", "FAFax", "FAFemale", "FAFighterJet", "FAFile", "FAFileArchiveO", "FAFileAudioO", "FAFileCodeO", "FAFileExcelO", "FAFileImageO", "FAFileMovieO", "FAFileO", "FAFilePdfO", "FAFilePhotoO", "FAFilePictureO", "FAFilePowerpointO", "FAFileSoundO", "FAFileText", "FAFileTextO", "FAFileVideoO", "FAFileWordO", "FAFileZipO", "FAFilesO", "FAFilm", "FAFilter", "FAFire", "FAFireExtinguisher", "FAFlag", "FAFlagCheckered", "FAFlagO", "FAFlash", "FAFlask", "FAFlickr", "FAFloppyO", "FAFolder", "FAFolderO", "FAFolderOpen", "FAFolderOpenO", "FAFont", "FAForumbee", "FAForward", "FAFoursquare", "FAFrownO", "FAFutbolO", "FAGamepad", "FAGavel", "FAGbp", "FAGe", "FAGear", "FAGears", "FAGenderless", "FAGift", "FAGit", "FAGitSquare", "FAGithub", "FAGithubAlt", "FAGithubSquare", "FAGittip", "FAGlass", "FAGlobe", "FAGoogle", "FAGooglePlus", "FAGooglePlusSquare", "FAGoogleWallet", "FAGraduationCap", "FAGratipay", "FAGroup", "FAHSquare", "FAHackerNews", "FAHandODown", "FAHandOLeft", "FAHandORight", "FAHandOUp", "FAHddO", "FAHeader", "FAHeadphones", "FAHeart", "FAHeartO", "FAHeartbeat", "FAHistory", "FAHome", "FAHospitalO", "FAHotel", "FAHtml5", "FAIls", "FAImage", "FAInbox", "FAIndent", "FAInfo", "FAInfoCircle", "FAInr", "FAInstagram", "FAInstitution", "FAIoxhost", "FAItalic", "FAJoomla", "FAJpy", "FAJsfiddle", "FAKey", "FAKeyboardO", "FAKrw", "FALanguage", "FALaptop", "FALastfm", "FALastfmSquare", "FALeaf", "FALeanpub", "FALegal", "FALemonO", "FALevelDown", "FALevelUp", "FALifeBouy", "FALifeBuoy", "FALifeRing", "FALifeSaver", "FALightbulbO", "FALineChart", "FALink", "FALinkedin", "FALinkedinSquare", "FALinux", "FAList", "FAListAlt", "FAListOl", "FAListUl", "FALocationArrow", "FALock", "FALongArrowDown", "FALongArrowLeft", "FALongArrowRight", "FALongArrowUp", "FAMagic", "FAMagnet", "FAMailForward", "FAMailReply", "FAMailReplyAll", "FAMale", "FAMapMarker", "FAMars", "FAMarsDouble", "FAMarsStroke", "FAMarsStrokeH", "FAMarsStrokeV", "FAMaxcdn", "FAMeanpath", "FAMedium", "FAMedkit", "FAMehO", "FAMercury", "FAMicrophone", "FAMicrophoneSlash", "FAMinus", "FAMinusCircle", "FAMinusSquare", "FAMinusSquareO", "FAMobile", "FAMobilePhone", "FAMoney", "FAMoonO", "FAMortarBoard", "FAMotorcycle", "FAMusic", "FANavicon", "FANeuter", "FANewspaperO", "FAOpenid", "FAOutdent", "FAPagelines", "FAPaintBrush", "FAPaperPlane", "FAPaperPlaneO", "FAPaperclip", "FAParagraph", "FAPaste", "FAPause", "FAPaw", "FAPaypal", "FAPencil", "FAPencilSquare", "FAPencilSquareO", "FAPhone", "FAPhoneSquare", "FAPhoto", "FAPictureO", "FAPieChart", "FAPiedPiper", "FAPiedPiperAlt", "FAPinterest", "FAPinterestP", "FAPinterestSquare", "FAPlane", "FAPlay", "FAPlayCircle", "FAPlayCircleO", "FAPlug", "FAPlus", "FAPlusCircle", "FAPlusSquare", "FAPlusSquareO", "FAPowerOff", "FAPrint", "FAPuzzlePiece", "FAQq", "FAQrcode", "FAQuestion", "FAQuestionCircle", "FAQuoteLeft", "FAQuoteRight", "FARa", "FARandom", "FARebel", "FARecycle", "FAReddit", "FARedditSquare", "FARefresh", "FARemove", "FARenren", "FAReorder", "FARepeat", "FAReply", "FAReplyAll", "FARetweet", "FARmb", "FARoad", "FARocket", "FARotateLeft", "FARotateRight", "FARouble", "FARss", "FARssSquare", "FARub", "FARuble", "FARupee", "FASave", "FAScissors", "FASearch", "FASearchMinus", "FASearchPlus", "FASellsy", "FASend", "FASendO", "FAServer", "FAShare", "FAShareAlt", "FAShareAltSquare", "FAShareSquare", "FAShareSquareO", "FAShekel", "FASheqel", "FAShield", "FAShip", "FAShirtsinbulk", "FAShoppingCart", "FASignIn", "FASignOut", "FASignal", "FASimplybuilt", "FASitemap", "FASkyatlas", "FASkype", "FASlack", "FASliders", "FASlideshare", "FASmileO", "FASoccerBallO", "FASort", "FASortAlphaAsc", "FASortAlphaDesc", "FASortAmountAsc", "FASortAmountDesc", "FASortAsc", "FASortDesc", "FASortDown", "FASortNumericAsc", "FASortNumericDesc", "FASortUp", "FASoundcloud", "FASpaceShuttle", "FASpinner", "FASpoon", "FASpotify", "FASquare", "FASquareO", "FAStackExchange", "FAStackOverflow", "FAStar", "FAStarHalf", "FAStarHalfEmpty", "FAStarHalfFull", "FAStarHalfO", "FAStarO", "FASteam", "FASteamSquare", "FAStepBackward", "FAStepForward", "FAStethoscope", "FAStop", "FAStreetView", "FAStrikethrough", "FAStumbleupon", "FAStumbleuponCircle", "FASubscript", "FASubway", "FASuitcase", "FASunO", "FASuperscript", "FASupport", "FATable", "FATablet", "FATachometer", "FATag", "FATags", "FATasks", "FATaxi", "FATencentWeibo", "FATerminal", "FATextHeight", "FATextWidth", "FATh", "FAThLarge", "FAThList", "FAThumbTack", "FAThumbsDown", "FAThumbsODown", "FAThumbsOUp", "FAThumbsUp", "FATicket", "FATimes", "FATimesCircle", "FATimesCircleO", "FATint", "FAToggleDown", "FAToggleLeft", "FAToggleOff", "FAToggleOn", "FAToggleRight", "FAToggleUp", "FATrain", "FATransgender", "FATransgenderAlt", "FATrash", "FATrashO", "FATree", "FATrello", "FATrophy", "FATruck", "FATry", "FATty", "FATumblr", "FATumblrSquare", "FATurkishLira", "FATwitch", "FATwitter", "FATwitterSquare", "FAUmbrella", "FAUnderline", "FAUndo", "FAUniversity", "FAUnlink", "FAUnlock", "FAUnlockAlt", "FAUnsorted", "FAUpload", "FAUsd", "FAUser", "FAUserMd", "FAUserPlus", "FAUserSecret", "FAUserTimes", "FAUsers", "FAVenus", "FAVenusDouble", "FAVenusMars", "FAViacoin", "FAVideoCamera", "FAVimeoSquare", "FAVine", "FAVk", "FAVolumeDown", "FAVolumeOff", "FAVolumeUp", "FAWarning", "FAWechat", "FAWeibo", "FAWeixin", "FAWhatsapp", "FAWheelchair", "FAWifi", "FAWindows", "FAWon", "FAWordpress", "FAWrench", "FAXing", "FAXingSquare", "FAYahoo", "FAYelp", "FAYen", "FAYoutube", "FAYoutubePlay", "FAYoutubeSquare"]
}
