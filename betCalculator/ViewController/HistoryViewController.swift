import UIKit

final class HistoryViewController: UIViewController {
    
    //MARK: - properties
    
    private let userDefaults = UserDefaults.standard
    
    private var currency = "₽"
    private var amount   = 0.0
    private var winCount = 0
    
    private var winArray      = [Int]()
    private var betArray      = [String]()
    private var oddsArray     = [String]()
    private var resultArray   = [Double]()
    private var betsNameArray = [String]()
    
    private var rootView: HistoryView {
        self.view as! HistoryView
    }
    
    //MARK: - Livecycle
    
    override func loadView() {
        self.view = HistoryView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTarget()
        setupDelegate()
        updateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        winArray = userDefaults.value(forKey: "historyWinArray") as? [Int] ?? []
        currency = userDefaults.string(forKey: "currency") ?? "₽"
        betArray = userDefaults.value(forKey: "historyBetArray") as? [String] ?? []
        oddsArray = userDefaults.value(forKey: "historyOddsArray") as? [String] ?? []
        resultArray = userDefaults.value(forKey: "historyResultArray") as? [Double] ?? []
        betsNameArray = userDefaults.value(forKey: "historyBetsNameArray") as? [String] ?? []
        amount = 0.0
        winCount = 0
        calculateAmount()
        calculateWinCount()
        rootView.turnoverLabel.text = "Monthly turnover: \(amount)\(currency)"
        rootView.totalWinLabel.text = "Total win: \(winCount)"
        rootView.amountLabel.text = "\(amount)\(currency)"
        
        rootView.tableView.reloadData()
    }

    //MARK: - Private methods
    
    private func updateData() {
        winArray = userDefaults.value(forKey: "historyWinArray") as? [Int] ?? []
        currency = userDefaults.string(forKey: "currency") ?? "₽"
        betArray = userDefaults.value(forKey: "historyBetArray") as? [String] ?? []
        oddsArray = userDefaults.value(forKey: "historyOddsArray") as? [String] ?? []
        resultArray = userDefaults.value(forKey: "historyResultArray") as? [Double] ?? []
        betsNameArray = userDefaults.value(forKey: "betsNameArray") as? [String] ?? []
        winCount = 0
        amount = 0.0
        calculateAmount()
        calculateWinCount()
        rootView.turnoverLabel.text = "Monthly turnover: \(amount)\(currency)"
        rootView.totalWinLabel.text = "Total win: \(winCount)"
        rootView.amountLabel.text = "\(amount)\(currency)"
    }
    
    private func setupTarget() {
        rootView.currencyButton.addTarget(self, action: #selector(tapCurrencyButton), for: .touchUpInside)
    }
    
    private func setupDelegate() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    private func calculateWinCount() {
        for item in winArray {
            winCount += item
        }
    }
    
    private func calculateAmount() {
        for amount in resultArray {
            self.amount += amount
        }
    }
    
    //MARK: - Private actions
    
    @objc private func tapCurrencyButton() {
        let currencyVC = CurrencyViewController()
        currencyVC.title = "Currency Info"
        navigationController?.pushViewController(currencyVC, animated: true)
    }
}

//MARK: - Extension: UITableViewDelegate & UITableViewDataSource

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if betArray.count == 0 {
            return 0
        } else {
            return betArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCustomCell",
                                                       for: indexPath) as? HistoryCustomCell else { return UITableViewCell() }
        cell.betLabel.text = "\(betArray[indexPath.row])\(currency)"
        cell.coeffLabel.text = "\(oddsArray[indexPath.row])"
        cell.betsNameLabel.text = "\(betsNameArray[indexPath.row])"
        let result = resultArray[indexPath.row]
        if result >= 0 {
            cell.winLabel.text = "WIN: \(result)\(currency)"
            rootView.amountLabel.text = "\(amount)\(currency)"
            rootView.totalWinLabel.text = "Total win: \(winCount)"
            rootView.turnoverLabel.text = "Monthly turnover: \(amount)\(currency)"
        } else {
            cell.winLabel.text = "LOSE: \(result)\(currency)"
            rootView.amountLabel.text = "\(amount)\(currency)"
            rootView.totalWinLabel.text = "Total win: \(winCount)"
            rootView.turnoverLabel.text = "Monthly turnover: \(amount)\(currency)"
        }
        cell.selectionStyle = .none
        tableView.rowHeight = 150
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            betArray.remove(at: indexPath.row)
            oddsArray.remove(at: indexPath.row)
            resultArray.remove(at: indexPath.row)
            winArray.remove(at: indexPath.row)
            betsNameArray.remove(at: indexPath.row)
            userDefaults.set(betArray, forKey: "historyBetArray")
            userDefaults.set(oddsArray, forKey: "historyOddsArray")
            userDefaults.set(resultArray, forKey: "historyResultArray")
            userDefaults.set(winArray, forKey: "historyWinArray")
            userDefaults.set(betsNameArray, forKey: "historyBetsNameArray")
        }
        
        betArray = userDefaults.value(forKey: "historyBetArray") as? [String] ?? []
        oddsArray = userDefaults.value(forKey: "historyOddsArray") as? [String] ?? []
        resultArray = userDefaults.value(forKey: "historyResultArray") as? [Double] ?? []
        winArray = userDefaults.value(forKey: "historyWinArray") as? [Int] ?? []
        betsNameArray = userDefaults.value(forKey: "historyBetsNameArray") as? [String] ?? []

        amount = 0.0
        winCount = 0
        rootView.turnoverLabel.text = "Monthly turnover: \(amount)\(currency)"
        rootView.totalWinLabel.text = "Total win: \(winCount)"
        rootView.amountLabel.text = "\(amount)\(currency)"
        calculateAmount()
        calculateWinCount()
        rootView.tableView.reloadData()
    }
}
