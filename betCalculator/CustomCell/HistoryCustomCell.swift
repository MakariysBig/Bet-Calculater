import UIKit

final class HistoryCustomCell: UITableViewCell {
    
    //MARK: - Private properties
    
    private let coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Internal properties
    
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
    
    let winLabel: UILabel = {
        let label = UILabel()
        label.text = "Win: +0.0p"
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
        contentView.addSubview(winLabel)
        contentView.addSubview(coeffLabel)
        setupLayout()
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
            winLabel.leadingAnchor.constraint(equalTo: coverView.leadingAnchor, constant: 10),
            winLabel.topAnchor.constraint(equalTo: betLabel.bottomAnchor),
            winLabel.heightAnchor.constraint(equalToConstant: 30),
            winLabel.trailingAnchor.constraint(equalTo: coverView.centerXAnchor),
        ])
    }
}
