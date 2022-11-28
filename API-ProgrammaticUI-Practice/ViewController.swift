//
//  ViewController.swift
//  API-ProgrammaticUI-Practice
//
//  Created by Matthew David Fleischer on 17/11/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var jokes:[String] = [String](repeating: "", count: 100)
    let tableView = UITableView()
    let button = UIButton()
    let dictonaryButton = UIButton()
    let animatedSplashScreen = UIImageView()
    var jokeService:JokeServicable = JokeService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
        //tableView setUp
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .lightGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //dictonary button
        dictonaryButton.addTarget(self, action: #selector(dictinaryButtonClicked(sender:)), for: .touchUpInside)
        dictonaryButton.backgroundColor = .red
        dictonaryButton.setTitle("Dictonary", for: .normal)
        dictonaryButton.titleLabel?.textColor = .white
        dictonaryButton.translatesAutoresizingMaskIntoConstraints = false
        
        //chuck norris button
        button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        button.backgroundColor = .blue
        button.setTitle("Search page", for: .normal)
        button.titleLabel?.textColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animatedSplashScreen)
        view.addSubview(tableView)
        view.addSubview(button)
        view.addSubview(dictonaryButton)
        
        //animating stuff?
//        var animationImages: [UIImage]?
//        animationImages?.append(UIImage(named: "1.png")!)
        var animationImages:[UIImage]? = [UIImage(named: "1.png")!,UIImage(named: "2.png")!,UIImage(named: "3.png")!,UIImage(named: "4.png")!,UIImage(named: "5.png")!]
        animatedSplashScreen.animationImages = animationImages
        animatedSplashScreen.animationRepeatCount = 1
        animatedSplashScreen.animationDuration = 5
        animatedSplashScreen.startAnimating()
        self.perform(#selector(hideAnimation(sender:)), with: animatedSplashScreen, afterDelay: 5.0)
    }
    
    @objc func hideAnimation(sender:UIImageView){
        sender.removeFromSuperview()
    }
    
    @objc func dictinaryButtonClicked(sender:UIButton){
        let dictionaryService = DictionaryService()
        let dcv = DictionaryViewController(dictionaryService: dictionaryService)
        self.present(dcv,animated: true)
    }
    
    @objc func buttonClicked(sender: UIButton){
        let chuckSearchService = ChuckSearchService()
        let svc = SearchViewController(chuckSearchService: chuckSearchService)
        self.present(svc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Laying out the subviews using frames
//        tableView.frame.size.height = view.bounds.height - 100.0
//        tableView.frame.size.width = view.bounds.width
//
//        button.frame.size.height = 100.0
//        button.frame.size.width = view.bounds.width/2
//        button.frame.origin.y = 760.0
//
//        dictonaryButton.frame.size.height = 100.0
//        dictonaryButton.frame.size.width = view.bounds.width/2
//        dictonaryButton.frame.origin.x = view.bounds.width/2
//        dictonaryButton.frame.origin.y = 760
        
        //laying out the subviews using auto layout
        var constraints = [
            //table view constraints
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            //buttons width and height constraints
            button.widthAnchor.constraint(equalToConstant: view.bounds.width/2),
            dictonaryButton.widthAnchor.constraint(equalToConstant: view.bounds.width/2),
            button.heightAnchor.constraint(equalToConstant: 50),
            dictonaryButton.heightAnchor.constraint(equalToConstant: 50),
            
            //buttons constraints
            button.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            dictonaryButton.topAnchor.constraint(equalTo:tableView.bottomAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            dictonaryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            button.leadingAnchor.constraint(equalTo: dictonaryButton.trailingAnchor),
            dictonaryButton.trailingAnchor.constraint(equalTo: button.leadingAnchor),
           
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dictonaryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
     
        ]
        
        NSLayoutConstraint.activate(constraints)
        //animated Splash screen setup
        animatedSplashScreen.frame = view.safeAreaLayoutGuide.layoutFrame
        view.bringSubviewToFront(animatedSplashScreen)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let labelView = UILabel()
        labelView.numberOfLines = 10
        labelView.frame = cell.frame
        labelView.font = labelView.font.withSize(10)
        jokeService.requestJoke(completion: {response in
            if let joke = response?.value {
                DispatchQueue.main.async {
                    labelView.text = joke
                    self.jokes[indexPath.row] = joke
                }
            }
        }, endPoint: "random")
        
        cell.addSubview(labelView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myMessage:String = jokes[indexPath.row]
        let myAlert = UIAlertController(title: "Alert", message: myMessage, preferredStyle: .alert)
        myAlert.addAction(UIAlertAction(title: "Exit", style: .cancel))
        present(myAlert,animated: true,completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
 
  
}

