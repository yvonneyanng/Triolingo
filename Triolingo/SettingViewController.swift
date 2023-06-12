import UIKit

protocol dataChoices{
    func chosenData(languageSelection: String, levelSelection: String, timeSelection: String)
}

class SettingViewController: UIViewController {
    

    @IBOutlet weak var languageChoice: UITextField!
    @IBOutlet weak var levelChoice: UITextField!
    @IBOutlet weak var timeChoice: UITextField!
    
    var languageC = ""
    var levelC = ""
    var timeC = ""
    
    @IBOutlet weak var choiceBG: UIView!
    let language = ["英文 English", "日文 にほんご", "西班牙文 Español"]
    let level = ["初級", "中級", "高級"]
    let time = ["00:00 ~ 01:00", "01:00 ~ 02:00", "02:00 ~ 03:00", "03:00 ~ 04:00", "04:00 ~ 5:00", "05:00 ~ 06:00", "06:00 ~ 07:00", "07:00 ~ 08:00", "08:00 ~ 09:00", "09:00 ~ 10:00", "10:00 ~ 11:00", "11:00 ~ 12:00", "12:00 ~ 13:00", "13:00 ~ 14:00", "14:00 ~ 15:00", "15:00 ~ 16:00", "16:00 ~ 17:00", "17:00 ~ 18:00", "18:00 ~ 19:00", "19:00 ~ 20:00", "20:00 ~ 21:00", "21:00 ~ 22:00", "22:00 ~ 23:00", "23:00 ~ 0:00"]
    
    var languagePickerView = UIPickerView()
    var levelPickerView = UIPickerView()
    var timePickerView = UIPickerView()
    
    var chosenDataDelegate : dataChoices?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        choiceBG.layer.cornerRadius = 15.0;
        
        languageChoice.inputView = languagePickerView
        levelChoice.inputView = levelPickerView
        timeChoice.inputView = timePickerView
        
        languageChoice.tintColor = UIColor.clear
        levelChoice.tintColor = UIColor.clear
        timeChoice.tintColor = UIColor.clear
        
        languageChoice.textAlignment = .center
        levelChoice.textAlignment = .center
        timeChoice.textAlignment = .center
        
        languagePickerView.delegate = self
        languagePickerView.dataSource = self
        
        levelPickerView.delegate = self
        levelPickerView.dataSource = self
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
        
        languagePickerView.tag = 1
        levelPickerView.tag = 2
        timePickerView.tag = 3
        
        languageChoice.text = languageC
        levelChoice.text = levelC
        timeChoice.text = timeC
    }

    @IBAction func saveBtn(_ sender: Any) {
        self.chosenDataDelegate?.chosenData(languageSelection: languageChoice.text!, levelSelection: levelChoice.text!, timeSelection: timeChoice.text!)
        self.navigationController?.popViewController(animated: true)
    }

}


extension SettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag{
        case 1:
            return language.count
        case 2:
            return level.count
        case 3:
            return time.count
        default:
            return 1
        }
    }
    
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row:Int,forComponent component:Int) -> String? {
        switch pickerView.tag{
        case 1:
            return language[row]
        case 2:
            return level[row]
        case 3:
            return time[row]
        default:
            return "Data not found."
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row:Int,inComponent component:Int){
        switch pickerView.tag{
        case 1:
            languageChoice.text = language[row]
            languageChoice.resignFirstResponder()
        case 2:
            levelChoice.text = level[row]
            levelChoice.resignFirstResponder()
        case 3:
            timeChoice.text = time[row]
            timeChoice.resignFirstResponder()
        default:
            return
        }
    }
}
