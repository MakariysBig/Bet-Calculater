import UIKit
import SnapKit

final class CurrencyView: UIView {
    
    //MARK: - Internal properties

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .lightBlueCustomColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        return tableView
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
        addSubview(tableView)
        setNeedsUpdateConstraints()
    }
    
    //MARK: - Override methods
    
    override func updateConstraints() {
        super.updateConstraints()
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview()
        }
    }
}
