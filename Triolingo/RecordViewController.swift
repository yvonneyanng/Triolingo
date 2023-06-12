import UIKit

class RecordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var dataProvider = DataProvider()
    var selectedRecord: Sentences?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 15.0;
        dataProvider.loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.record.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordTableViewCell
        let record = dataProvider.record[indexPath.row]
        cell.recordImg.image = UIImage(named: record.img)
        cell.recordLabel.text = record.question
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecord = dataProvider.record[indexPath.row]
        performSegue(withIdentifier: "gotoDetail", sender: self)
    }
    
    private func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController{
            let backItem = UIBarButtonItem()
            backItem.title = "返回"
            navigationItem.backBarButtonItem = backItem
            vc.record = selectedRecord
        }
    }
    
}
