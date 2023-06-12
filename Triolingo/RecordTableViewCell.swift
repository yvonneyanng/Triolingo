import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
