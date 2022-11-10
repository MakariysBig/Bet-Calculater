import UIKit

final class CurrencyViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let userDefaults = UserDefaults.standard
    private let currency = ["🇷🇺₽", "🇺🇸$", "🇪🇺€", "🇬🇧£"]
    
    private var rootView: CurrencyView {
        self.view as! CurrencyView
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        self.view = CurrencyView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
    }
    
    //MARK: - Private methods
    
    private func setupDelegate() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
}

//MARK: - Extension: UITableViewDelegate & UITableViewDataSource

extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currency.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let item = currency[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var currency = currency[indexPath.row]
        currency.removeFirst()
        userDefaults.set(currency, forKey: "currency")
        navigationController?.popViewController(animated: true)
    } 
}
