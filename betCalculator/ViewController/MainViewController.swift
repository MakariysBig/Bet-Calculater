import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let userDefaults = UserDefaults.standard
    
    private var currency = "₽"
    private var winCount = 0
    
    private var betArray      = [Double]()
    private var oddsArray     = [Double]()
    private var resultArray   = [Double]()
    private var betsNameArray = [String]()
    
    private var rootView: MainView {
        self.view as! MainView
    }

    //MARK: - Livecycle
    
    override func loadView() {
        self.view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.set(winCount, forKey: "winCount")
        updateData()
        setupDelegate()
        setupNavItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
        rootView.tableView.reloadData()
    }

    //MARK: - Private methods
    
    private func updateData() {
        currency      = userDefaults.string(forKey: "currency") ?? "₽"
        betArray      = userDefaults.value(forKey: "betArray") as? [Double] ?? []
        oddsArray     = userDefaults.value(forKey: "oddsArray") as? [Double] ?? []
        resultArray   = userDefaults.value(forKey: "resultArray") as? [Double] ?? []
        betsNameArray = userDefaults.value(forKey: "betsNameArray") as? [String] ?? []
    }
    
    private func setupNavItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(toAddVC))
        navigationItem.rightBarButtonItem?.tintColor = .blueCustomColor
    }
    
    private func setupDelegate() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    //MARK: - Private actions
    
    @objc private func toAddVC() {
        let vc = UINavigationController(rootViewController: NewBetViewController())
        if let sheet = vc.presentationController as? UISheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(vc, animated: true)
    }
}

//MARK: - Extension: UITableViewDelegate & UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if betArray.count == 0 {
            return 0
        } else {
            return betArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCustomCell",
                                                       for: indexPath) as? MainCustomCell else { return UITableViewCell() }
        cell.index = indexPath.row
        cell.selectionStyle = .none
        cell.betLabel.text = "\(betArray[indexPath.row])\(currency)"
        cell.coeffLabel.text = "\(oddsArray[indexPath.row])x"
        cell.valueLabel.text = "\(resultArray[indexPath.row])\(currency)"
        cell.betsNameLabel.text = "Name: \(betsNameArray[indexPath.row])"
        tableView.rowHeight = 150
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            betArray.remove(at: indexPath.row)
            oddsArray.remove(at: indexPath.row)
            resultArray.remove(at: indexPath.row)
            betsNameArray.remove(at: indexPath.row)
            
            userDefaults.set(betArray, forKey: "betArray")
            userDefaults.set(oddsArray, forKey: "oddsArray")
            userDefaults.set(resultArray, forKey: "resultArray")
            userDefaults.set(betsNameArray, forKey: "betsNameArray")
        }
        rootView.tableView.reloadData()
    }
}

//MARK: - Extension: MainCustomCellDelegate

extension MainViewController: MainCustomCellDelegate {
    func presentShareSheet(index: Int) {
        betArray.remove(at: index)
        oddsArray.remove(at: index)
        resultArray.remove(at: index)
        betsNameArray.remove(at: index)

        userDefaults.set(betArray, forKey: "betArray")
        userDefaults.set(oddsArray, forKey: "oddsArray")
        userDefaults.set(resultArray, forKey: "resultArray")
        userDefaults.set(betsNameArray, forKey: "betsNameArray")

        betArray = userDefaults.value(forKey: "betArray") as? [Double] ?? []
        oddsArray = userDefaults.value(forKey: "oddsArray") as? [Double] ?? []
        resultArray = userDefaults.value(forKey: "resultArray") as? [Double] ?? []
        betsNameArray = userDefaults.value(forKey: "betsNameArray") as? [String] ?? []
        
        rootView.tableView.reloadData()
    }
}
