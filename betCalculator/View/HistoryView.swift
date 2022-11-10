import UIKit

final class HistoryView: UIView {
    
    //MARK: - Internal properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .lightBlueCustomColor
        tableView.register(HistoryCustomCell.self, forCellReuseIdentifier: "HistoryCustomCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 27, weight: .heavy)
        return label
    }()
    
    let totalWinLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Total win: 0"
        return label
    }()
    
    let turnoverLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Monthly turnover: 0"
        return label
    }()
    
    let currencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Currency", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blueCustomColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    lazy var stackViewForLabel: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [totalWinLabel, turnoverLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    //MARK: - Private properties
    
    private let amountImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blueCustomColor
        image.layer.cornerRadius = 80
        return image
    }()
    
    //MARK: - Initialise

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
        addSubview(amountImage)
        addSubview(amountLabel)
        addSubview(currencyButton)
        addSubview(stackViewForLabel)
        addSubview(tableView)
        setNeedsUpdateConstraints()
    }
    
    //MARK: - Override methods
    
    override func updateConstraints() {
        super.updateConstraints()
        amountImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            $0.height.equalTo(160)
            $0.width.equalTo(160)
        }
        
        amountLabel.snp.makeConstraints {
            $0.left.right.equalTo(amountImage)
            $0.top.bottom.equalTo(amountImage)
        }
        
        currencyButton.snp.makeConstraints {
            $0.centerY.equalTo(amountImage.snp.centerY)
            $0.leading.equalTo(amountImage.snp.trailing).offset(50)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
        
        stackViewForLabel.snp.makeConstraints {
            $0.top.equalTo(amountImage.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(stackViewForLabel.snp.bottom).offset(30)
            $0.bottom.equalToSuperview()
        }
    }
}
