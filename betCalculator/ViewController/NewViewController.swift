import UIKit

final class NewViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let userDefaults = UserDefaults.standard
    
    private var bet      = 0.0
    private var odds     = 1.0
    private var result   = 0.0
    private var betsName = ""
    
    private var betArray      = [Double]()
    private var oddsArray     = [Double]()
    private var resultArray   = [Double]()
    private var betsNameArray = [String]()
    
    private var rootView: NewView {
        self.view as! NewView
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        self.view = NewView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTarget()
        registeerKeyBoardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
    
    //MARK: - Private methods
    
    private func updateData() {
        bet      = 0.0
        odds     = 1.0
        result   = 0.0
        betsName = ""
        
        rootView.resultTextField.text   = nil
        rootView.betTextField.text      = nil
        rootView.oddsTextField.text     = "1.0"
        rootView.betsNameTextField.text = nil
    }
    
    private func setupTarget() {
        rootView.betTextField.addTarget(self, action: #selector(betDidChange(_:)), for: .editingChanged)
        rootView.oddsTextField.addTarget(self, action: #selector(oddsDidChange(_:)), for: .editingChanged)
        rootView.betsNameTextField.addTarget(self, action: #selector(betsNameDidChange(_:)), for: .editingChanged)
        rootView.calculateButton.addTarget(self, action: #selector(saveBet), for: .touchUpInside)
    }
    
    private func calculateWin() {
        let bet = bet
        let odds = odds
        let roundResult = bet / odds
        result = Double(round(1000 * roundResult) / 1000)
        rootView.resultTextField.text = String("\(result)")
    }
    
    private func registeerKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Override methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - Private actions
    
    @objc private func saveBet() {
        if bet != 0.0 {
            betArray = userDefaults.value(forKey: "betArray") as? [Double] ?? []
            betArray.insert(result, at: 0)
            userDefaults.set(betArray, forKey: "betArray")
            
            oddsArray = userDefaults.value(forKey: "oddsArray") as? [Double] ?? []
            oddsArray.insert(odds, at: 0)
            userDefaults.set(oddsArray, forKey: "oddsArray")
            
            resultArray = userDefaults.value(forKey: "resultArray") as? [Double] ?? []
            resultArray.insert(bet, at: 0)
            userDefaults.set(resultArray, forKey: "resultArray")
            
            betsNameArray = userDefaults.value(forKey: "betsNameArray") as? [String] ?? []
            betsNameArray.insert(betsName, at: 0)
            userDefaults.set(betsNameArray, forKey: "betsNameArray")
        }
        tabBarController?.selectedIndex = 0
    }
    
    @objc private func betDidChange(_ textField: UITextField) {
        let strBet = textField.text ?? ""
        bet = Double(strBet) ?? 0.0
        calculateWin()
    }
    
    @objc private func oddsDidChange(_ textField: UITextField) {
        let strBet = textField.text ?? ""
        odds = Double(strBet) ?? 1.0
        calculateWin()
    }
    
    @objc private func betsNameDidChange(_ textField: UITextField) {
        betsName = textField.text ?? "unknown bet"
    }
    
    @objc private func keyboardWillShow(notification :NSNotification) {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        if height <= 670 {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 40
            }
        } else {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 0
            }
        }
    }
    
    @objc private func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
