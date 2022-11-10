import UIKit

protocol MainCustomCellDelegate: AnyObject {
    func presentShareSheet(index: Int)
}

final class MainCustomCell: UITableViewCell {
    
    //MARK: - Internal properties
    var index = 0
    weak var delegate: MainCustomCellDelegate?
    
    //MARK: - Private properties    
    
    private var historyBetArray      = [String]()
    private var historyOddsArray     = [String]()
    private var historyResultArray   = [Double]()
    private var historyWinArray      = [Int]()
    private var historyBetsNameArray = [String]()
    
    private let userDefaults = UserDefaults.standard
    
    private let coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let winButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Win", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .black)
        button.backgroundColor = .lightBlueCustomColor
        button.layer.cornerRadius = 19
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Lose", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .black)
        button.backgroundColor = .lightBlueCustomColor
        button.layer.cornerRadius = 19
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let betsNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.tintColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let betLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "0.0p"
        label.textColor = .black
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let coeffLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0x"
        label.textColor = .black
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let canWinLabel: UILabel = {
        let label = UILabel()
        label.text = "Can win: "
        label.textColor = .black
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Override methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Initialise
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setup() {
        backgroundColor = .lightBlueCustomColor
        contentView.addSubview(coverView)
        contentView.addSubview(betsNameLabel)
        contentView.addSubview(betLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(coeffLabel)
        contentView.addSubview(canWinLabel)
        contentView.addSubview(winButton)
        contentView.addSubview(loseButton)
        setupLayout()
        winButton.addTarget(self, action: #selector(tapWinButton), for: .touchUpInside)
        loseButton.addTarget(self, action: #selector(tapLoseButton), for: .touchUpInside)
    }
    
    @objc func tapWinButton() {
        var winCount = userDefaults.value(forKey: "historyWinArray") as? [Int] ?? []
        winCount.insert(1, at: 0)
        userDefaults.set(winCount, forKey: "historyWinArray")
        
        var bet = betLabel.text
        bet?.removeLast()
        let odds = coeffLabel.text
        var result = valueLabel.text ?? "0.0"
        result.removeLast()
        let resultDouble = Double(result)
        let betsName = betsNameLabel.text
        
        if let bet = bet {
            historyBetArray = userDefaults.value(forKey: "historyBetArray") as? [String] ?? []
            historyBetArray.insert(bet, at: 0)
            userDefaults.set(historyBetArray, forKey: "historyBetArray")
        }
        
        if let odds = odds {
            historyOddsArray = userDefaults.value(forKey: "historyOddsArray") as? [String] ?? []
            historyOddsArray.insert(odds, at: 0)
            userDefaults.set(historyOddsArray, forKey: "historyOddsArray")
        }
        
        if let resultDouble = resultDouble {
            historyResultArray = userDefaults.value(forKey: "historyResultArray") as? [Double] ?? []
            historyResultArray.insert(resultDouble, at: 0)
            userDefaults.set(historyResultArray, forKey: "historyResultArray")
        }
        
        if let betsName = betsName {
            historyBetsNameArray = userDefaults.value(forKey: "historyBetsNameArray") as? [String] ?? []
            historyBetsNameArray.insert(betsName, at: 0)
            userDefaults.set(historyBetsNameArray, forKey: "historyBetsNameArray")
        }
        delegate?.presentShareSheet(index: index)
    }
    
    @objc func tapLoseButton() {
        var winCount = userDefaults.value(forKey: "historyWinArray") as? [Int] ?? []
        winCount.insert(0, at: 0)
        userDefaults.set(winCount, forKey: "historyWinArray")
        
        var bet = betLabel.text
        bet?.removeLast()
        let odds = coeffLabel.text
        var result = valueLabel.text ?? "0.0"
        result.removeLast()
        var resultDouble = Double(result)
        let unwrapBet = bet ?? "0.0"
        resultDouble = Double(unwrapBet)
        let betsName = betsNameLabel.text

        if let bet = bet {
            historyBetArray = userDefaults.value(forKey: "historyBetArray") as? [String] ?? []
            historyBetArray.insert(bet, at: 0)
            userDefaults.set(historyBetArray, forKey: "historyBetArray")
        }
        
        if let odds = odds {
            historyOddsArray = userDefaults.value(forKey: "historyOddsArray") as? [String] ?? []
            historyOddsArray.insert(odds, at: 0)
            userDefaults.set(historyOddsArray, forKey: "historyOddsArray")
        }
        
        if let resultDouble = resultDouble {
            historyResultArray = userDefaults.value(forKey: "historyResultArray") as? [Double] ?? []
            historyResultArray.insert(-resultDouble, at: 0)
            userDefaults.set(historyResultArray, forKey: "historyResultArray")
        }
        
        if let betsName = betsName {
            historyBetsNameArray = userDefaults.value(forKey: "historyBetsNameArray") as? [String] ?? []
            historyBetsNameArray.insert(betsName, at: 0)
            userDefaults.set(historyBetsNameArray, forKey: "historyBetsNameArray")
        }
        delegate?.presentShareSheet(index: index)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            coverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            coverView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            coverView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            coverView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            betsNameLabel.leadingAnchor.constraint(equalTo: coverView.leadingAnchor, constant: 10),
            betsNameLabel.topAnchor.constraint(equalTo: coverView.topAnchor, constant: 18),
            betsNameLabel.heightAnchor.constraint(equalToConstant: 30),
            betsNameLabel.trailingAnchor.constraint(equalTo: coverView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            betLabel.leadingAnchor.constraint(equalTo: coverView.leadingAnchor, constant: 10),
            betLabel.topAnchor.constraint(equalTo: betsNameLabel.bottomAnchor),
            betLabel.heightAnchor.constraint(equalToConstant: 30),
            betLabel.trailingAnchor.constraint(equalTo: coverView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            coeffLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            coeffLabel.topAnchor.constraint(equalTo: betLabel.topAnchor),
            coeffLabel.heightAnchor.constraint(equalToConstant: 30),
            coeffLabel.trailingAnchor.constraint(equalTo: coverView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            canWinLabel.leadingAnchor.constraint(equalTo: coverView.leadingAnchor, constant: 10),
            canWinLabel.topAnchor.constraint(equalTo: betLabel.bottomAnchor),
            canWinLabel.heightAnchor.constraint(equalToConstant: 30),
            canWinLabel.widthAnchor.constraint(equalToConstant: 75),
        ])
        
        NSLayoutConstraint.activate([
            winButton.trailingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: -10),
            winButton.topAnchor.constraint(equalTo: coverView.topAnchor, constant: 20),
            winButton.heightAnchor.constraint(equalToConstant: 38),
            winButton.widthAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: canWinLabel.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: canWinLabel.bottomAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: 30),
            valueLabel.trailingAnchor.constraint(equalTo: winButton.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            loseButton.trailingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: -10),
            loseButton.bottomAnchor.constraint(equalTo: coverView.bottomAnchor, constant: -20),
            loseButton.heightAnchor.constraint(equalToConstant: 38),
            loseButton.widthAnchor.constraint(equalToConstant: 38)
        ])
    }
}
