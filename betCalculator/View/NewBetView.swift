import UIKit
import SnapKit

final class NewBetView: UIView {
    
    //MARK: - Internal properties
    
    let betsNameTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.blueCustomColor.cgColor
        textField.layer.cornerRadius = 20
        textField.keyboardType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let betTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.blueCustomColor.cgColor
        textField.layer.cornerRadius = 20
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let oddsTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.text = "1.0"
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.blueCustomColor.cgColor
        textField.layer.cornerRadius = 20
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let resultTextField: UITextField = {
        let textField = UITextField()
        textField.isUserInteractionEnabled = false
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.blueCustomColor.cgColor
        textField.layer.cornerRadius = 20
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save Bet", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blueCustomColor
        button.layer.cornerRadius = 20
        return button
    }()
    
    //MARK: - Private properties
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Your can win"
        return label
    }()
    
    private let oddsLabel: UILabel = {
        let label = UILabel()
        label.text = "Coefficient"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let betLabel: UILabel = {
        let label = UILabel()
        label.text = "New bet"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let betsNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bet's name"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Initialase
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setup() {
        backgroundColor = .white
        addSubview(betsNameLabel)
        addSubview(betsNameTextField)
        addSubview(betLabel)
        addSubview(betTextField)
        addSubview(oddsLabel)
        addSubview(oddsTextField)
        addSubview(resultLabel)
        addSubview(resultTextField)
        addSubview(calculateButton)
        setNeedsUpdateConstraints()
    }
    
    //MARK: - Override methods
    
    override func updateConstraints() {
        super.updateConstraints()
        betsNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.frame.width / 1.5)
            $0.height.equalTo(30)
        }
        
        betsNameTextField.snp.makeConstraints {
            $0.top.equalTo(betsNameLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.frame.width / 1.5)
            $0.height.equalTo(40)
        }
        
        betLabel.snp.makeConstraints {
            $0.top.equalTo(betsNameTextField.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.frame.width / 1.5)
            $0.height.equalTo(30)
        }
        
        betTextField.snp.makeConstraints {
            $0.top.equalTo(betLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.frame.width / 1.5)
            $0.height.equalTo(40)
        }
        
        oddsLabel.snp.makeConstraints {
            $0.top.equalTo(betTextField.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.frame.width / 1.5)
            $0.height.equalTo(30)
        }
        
        oddsTextField.snp.makeConstraints {
            $0.top.equalTo(oddsLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.frame.width / 1.5)
            $0.height.equalTo(40)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(oddsTextField.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.frame.width / 1.5)
            $0.height.equalTo(30)
        }
        
        resultTextField.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.frame.width / 1.5)
            $0.height.equalTo(40)
        }
        
        calculateButton.snp.makeConstraints {
            $0.top.equalTo(resultTextField.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.frame.width / 1.5)
            $0.height.equalTo(40)
        }
    }
}
