import UIKit
import SDWebImage

class BandCell: UITableViewCell, ReusableTableViewCell {
    @IBOutlet private weak var cardView: UIView!
    
    @IBOutlet private weak var bandImage: UIImageView!
    @IBOutlet private weak var bandName: UILabel!
    @IBOutlet private weak var listeners: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        cardView.layer.cornerRadius = 12
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bandImage.setNeedsLayout()
        bandImage.layoutIfNeeded()
        bandImage.layer.cornerRadius = bandImage.bounds.width / 2
    }

    func setup(with cellModel: BandCellModel) {
        bandImage.sd_setImage(with: URL(string: cellModel.bandImageURL), completed: nil)
        bandName.text = cellModel.bandName
        listeners.text = "(\(cellModel.listeners) listeners)"
    }
}
