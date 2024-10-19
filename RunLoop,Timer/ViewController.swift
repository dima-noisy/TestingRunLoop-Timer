import UIKit

class ViewController: UIViewController {
    
    private var timer: Timer?
    
    private var counter = 10
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "10"
        label.backgroundColor = .gray
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var btn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setTitle("Start timer", for: .normal)
        btn.layer.cornerRadius = 6
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(tapOnBtnAction), for: .touchUpInside)
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        
        //createTimer()
    }
    
    private func setupView() {
        view.backgroundColor = .red
    }
    
    private func addSubviews() {
        view.addSubview(timerLabel)
        view.addSubview(btn)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btn.heightAnchor.constraint(equalToConstant: 60.0),
            btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40.0),
            btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40.0),
            
            timerLabel.bottomAnchor.constraint(equalTo: btn.topAnchor, constant: -40.0),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40.0),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40.0),
            timerLabel.heightAnchor.constraint(equalToConstant: 60.0),
        ])
    }
    /*
    private func createTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(timerAction),
            userInfo: nil,
            repeats: true)
    }
    
    @objc func timerAction() {
        print("Timer action")
    }
    */
    private func createTimerBtn() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true) { [weak self] timer in
                guard let self else { return }
                counter -= 1
                
                timerLabel.text = counter <= 0 ? "End of timer" : "\(counter)"
                if counter <= 0 {
                    self.timer?.invalidate()
                    self.timer = nil
                    print("Timer has been deleted")
                }
            }
        //timer?.tolerance = 0.1
    }
    
    private func makeGlobalRunLoopTimer() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true) { [weak self] timer in
                guard let self else { return }
                counter -= 1
                
                timerLabel.text = counter <= 0 ? "End of timer" : "\(counter)"
                print(counter <= 0 ? "End of timer" : "\(counter)")
                
                timer.tolerance = 0.7
                if counter <= 0 {
                    self.timer?.invalidate()
                    self.timer = nil
                }
            }
        guard let timer else { return }
        RunLoop.current.add(timer, forMode: .common)
        RunLoop.current.run()
    }
    
    @objc func tapOnBtnAction() {
        //createTimerBtn()
        makeGlobalRunLoopTimer()
    }
}

