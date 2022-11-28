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
        searchResults.translatesAutoresizingMaskIntoConstraints = false
        
        searchButton.addTarget(self, action: #selector(searchButtonClicked(sender:)), for: .touchUpInside)
        searchButton.backgroundColor = .red
        searchButton.setTitle("Search", for: .normal)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        searchTextField.backgroundColor = .lightGray
        searchTextField.placeholder = "Enter your search"
        searchTextField.translatesAutoresizingMaskIntoConstraints  = false
        
        view.addSubview(searchResults)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //layout done with frames
//        searchResults.frame.size.width = view.bounds.width
//        searchResults.frame.size.height = view.bounds.height - 100
//        searchResults.frame.origin.y = view.bounds.origin.y + 100
//
//        searchTextField.frame.size.width = view.bounds.width - 100
//        searchTextField.frame.size.height = 100
//
//        searchButton.frame.size.width = 100
//        searchButton.frame.size.height = 100
//        searchButton.frame.origin.x = view.bounds.width - 100
        
        //layout done with autolayout
        let constraints = [
            //search results constraints
            searchResults.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchResults.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchResults.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            //Text field and button width and height constraints
            searchTextField.widthAnchor.constraint(equalToConstant: view.bounds.width-100),
            searchTextField.heightAnchor.constraint(equalToConstant: 100),
            searchButton.widthAnchor.constraint(equalToConstant: 100),
            searchButton.heightAnchor.constraint(equalToConstant: 100),
            
            //Text field and button constraints
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor),
            searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: searchResults.topAnchor),
            searchButton.bottomAnchor.constraint(equalTo: searchResults.topAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
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
            }, searchQuery:handleQuery(query:search))
        }
        view.endEditing(true)
    }
    
    func handleQuery(query:String) -> String {
        var handledQuery:String = ""
        for i in query {
            if i == " " {
                handledQuery.append("%20")
            } else {
                handledQuery.append(i)
            }
        }
        return handledQuery
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
