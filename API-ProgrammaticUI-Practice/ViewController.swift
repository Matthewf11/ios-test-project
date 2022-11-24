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
    var jokeService:JokeServicable = JokeService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
       
        //dictonary button
        dictonaryButton.addTarget(self, action: #selector(dictinaryButtonClicked(sender:)), for: .touchUpInside)
        dictonaryButton.backgroundColor = .red
        
        //chuck norris button
        button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        button.backgroundColor = .blue
        
        view.addSubview(tableView)
        view.addSubview(button)
        view.addSubview(dictonaryButton)
        
        dictonaryButton.frame.origin.y = 760
        dictonaryButton.setTitle("Dictonary", for: .normal)
        dictonaryButton.titleLabel?.textColor = .white
        
        button.frame.origin.y = 760.0
        button.setTitle("Search page", for: .normal)
        button.titleLabel?.textColor = .white
        
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
        tableView.frame.size.height = view.bounds.height - 100.0
        tableView.frame.size.width = view.bounds.width
        
        button.frame.size.height = 100.0
        button.frame.size.width = view.bounds.width/2
        
        dictonaryButton.frame.size.height = 100.0
        dictonaryButton.frame.size.width = view.bounds.width/2
        dictonaryButton.frame.origin.x = view.bounds.width/2
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

