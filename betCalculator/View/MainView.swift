import UIKit
import SnapKit

final class MainView: UIView {
    
    //MARK: - Internal properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .lightBlueCustomColor
        tableView.register(MainCustomCell.self, forCellReuseIdentifier: "MainCustomCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
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
        addSubview(tableView)
        setNeedsUpdateConstraints()
    }
    
    //MARK: - Override methods
    
    override func updateConstraints() {
        super.updateConstraints()
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            $0.bottom.equalToSuperview()
        }
    }
}
