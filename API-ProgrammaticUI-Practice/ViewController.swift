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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
       
        button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        button.backgroundColor = .blue
        
        view.addSubview(tableView)
        view.addSubview(button)
        
        button.frame.origin.y = 760.0
        button.setTitle("Search page", for: .normal)
        button.titleLabel?.textColor = .white
        
    }
    
    
    
    @objc func buttonClicked(sender: UIButton){
        let svc = SearchViewController()
        self.present(svc, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame.size.height = view.bounds.height - 100.0
        tableView.frame.size.width = view.bounds.width
        button.frame.size.height = 100.0
        button.frame.size.width = view.bounds.width
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let labelView = UILabel()
        labelView.numberOfLines = 10
        labelView.frame = cell.frame
        labelView.font = labelView.font.withSize(10)
        requestJoke(completion: {response in
            if let joke = response?.value {
                DispatchQueue.main.async {
                    labelView.text = joke
                    print(indexPath.row)
                    print(self.jokes)
                    print(joke)
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

