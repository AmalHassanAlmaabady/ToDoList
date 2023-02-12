

import UIKit

class CellItemTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionTask: UILabel!
    @IBOutlet weak var dateTask: UILabel!
    @IBOutlet weak var titleTask: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
