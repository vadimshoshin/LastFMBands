import UIKit
import SDWebImage

class TrackCell: UITableViewCell {
    @IBOutlet private weak var trackCover: UIImageView!
    @IBOutlet private weak var trackTitle: UILabel!
    @IBOutlet private weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        cardView.layer.cornerRadius = 12
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        trackCover.setNeedsLayout()
        trackCover.layoutIfNeeded()
        trackCover.layer.cornerRadius = trackCover.bounds.width / 2
    }
    
    func setup(with model: TrackCellModel) {
        trackCover.sd_setImage(with: URL(string:model.trackCoverURL), completed: nil)
        trackTitle.text = model.trackName + " (\(model.plays) plays.)"
    }
}
