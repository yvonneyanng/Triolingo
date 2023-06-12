import UIKit
import UserNotifications

class ViewController: UIViewController, dataChoices {
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    

    func chosenData(languageSelection: String, levelSelection: String, timeSelection: String){
        languageLabel.text = languageSelection
        levelLabel.text = levelSelection
        timeLabel.text = timeSelection
        
//        var pushHour = Int(timeLabel.text!.prefix(2))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForPermission()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SettingViewController{
            let backItem = UIBarButtonItem()
            backItem.title = "返回"
            navigationItem.backBarButtonItem = backItem
            vc.chosenDataDelegate = self
            vc.languageC = languageLabel.text!
            vc.levelC = levelLabel.text!
            vc.timeC = timeLabel.text!
        }
        
        if let vc = segue.destination as? PracticeViewController{
            let backItem = UIBarButtonItem()
            backItem.title = "返回"
            navigationItem.backBarButtonItem = backItem
            vc.language = languageLabel.text!
            vc.level = levelLabel.text!
        }
        
        if segue.destination is RecordViewController{
            let backItem = UIBarButtonItem()
            backItem.title = "返回"
            navigationItem.backBarButtonItem = backItem
        }
        
    }

    @IBAction func settingClick(_ sender: Any) {
    }
    
    func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.dispatchNotification()
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification()
                    }
                }
            default:
                return
            }
        }
    }
    
    func dispatchNotification() {
        let identifier = "my-practice-notification"
        let title = "Triolingo time!"
        let body = "For god's sake just click in. 👊"
        let hour = 11
        let minute = 30
        let isDaily = true
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
}

