//
//  SearchViewController.swift
//  API-ProgrammaticUI-Practice
//
//  Created by Matthew David Fleischer on 21/11/2022.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let searchTextField = UITextField()
    let searchResults = UITableView()
    let searchButton = UIButton()
    var jokesReturned:[String] = []
    var chuckSearchService:ChuckSearchServicable
    init(chuckSearchService:ChuckSearchServicable){
        self.chuckSearchService = chuckSearchService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder) not implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchResults.dataSource = self
        searchResults.delegate = self
        view.addSubview(searchResults)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        
        searchButton.addTarget(self, action: #selector(searchButtonClicked(sender:)), for: .touchUpInside)
        searchButton.backgroundColor = .red
        searchButton.setTitle("Search", for: .normal)
        
        
        searchTextField.backgroundColor = .lightGray
        searchTextField.placeholder = "Enter your search"
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResults.frame.size.width = view.bounds.width
        searchResults.frame.size.height = view.bounds.height - 100
        searchResults.frame.origin.y = view.bounds.origin.y + 100
        
        searchTextField.frame.size.width = view.bounds.width - 100
        searchTextField.frame.size.height = 100
        
        searchButton.frame.size.width = 100
        searchButton.frame.size.height = 100
        searchButton.frame.origin.x = view.bounds.width - 100
    }
    
    @objc func searchButtonClicked(sender: UIButton) {
        jokesReturned = []
        if let search = searchTextField.text{
            chuckSearchService.searchAPI(completion: {response in
                if let jokes = response?.result{
                    DispatchQueue.main.async {
                        self.handleResponse(jokes: jokes)
                    }
                }
            }, searchQuery:search)
        }
        view.endEditing(true)
    }
    
    func handleResponse(jokes:[Body]){
        for joke in jokes{
            if let jokeValue = joke.value{
                jokesReturned.append(jokeValue)
            }
        }
        searchResults.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //do nothing
        let cell = UITableViewCell()
        let label = UILabel()
        label.frame = cell.frame
        label.numberOfLines = 10
        label.font = label.font.withSize(10)
        label.text = jokesReturned[indexPath.row]
        cell.addSubview(label)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokesReturned.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myMessage = jokesReturned[indexPath.row]
        let myAlert = UIAlertController(title: "Joke", message: myMessage, preferredStyle: .alert)
        myAlert.addAction(UIAlertAction(title: "Exit", style: .cancel))
        present(myAlert,animated: true,completion: nil)
    }
}
