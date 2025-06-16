import UIKit

class SurveyCell: UITableViewCell {
    static let identifier = "SurveyCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!

    var onAnswerTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        isAccessibilityElement = true
        accessibilityTraits = .button  // Ou .link, dependendo do contexto
    }

    @IBAction func answerTapped(_ sender: UIButton) {
        onAnswerTapped?()
    }

    func configure(with survey: Survey) {
        titleLabel.text = survey.title
        timeLabel.text = "Tempo estimado: \(survey.estimatedTime)"
        rewardLabel.text = "\(survey.reward)"

        // Acessibilidade
        titleLabel.accessibilityLabel = "Título da pesquisa: \(survey.title)"
        timeLabel.accessibilityLabel = "Tempo estimado: \(survey.estimatedTime)"
        rewardLabel.accessibilityLabel = "Recompensa: \(survey.reward)"
        answerButton.accessibilityLabel = "Botão responder pesquisa"
    }
}
