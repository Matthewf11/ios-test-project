//
//  DictionaryViewController.swift
//  API-ProgrammaticUI-Practice
//
//  Created by Matthew David Fleischer on 21/11/2022.
//

import UIKit

class DictionaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var dictionaryResponse:[Definition] = []
    var dictionaryResults = UITableView()
    var queryParameter = UITextField()
    var searchButton = UIButton()
    var dictionaryService:DictionaryServicable
    
    init(dictionaryService:DictionaryServicable) {
        self.dictionaryService = dictionaryService
        super.init(nibName: nil, bundle: nil)
        
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dictionaryResults.delegate = self
        dictionaryResults.dataSource = self
        dictionaryResults.translatesAutoresizingMaskIntoConstraints = false
        
        queryParameter.backgroundColor = .lightGray
        queryParameter.placeholder = "Enter your search"
        queryParameter.translatesAutoresizingMaskIntoConstraints = false
        
        searchButton.backgroundColor = .red
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(searchDictonary(sender: )), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(dictionaryResults)
        view.addSubview(queryParameter)
        view.addSubview(searchButton)
    }
    
    
    @objc func searchDictonary(sender:UIButton) {
        dictionaryResponse = []
        if let query = queryParameter.text {
            dictionaryService.queryDictonary(completion: {
                response in
                DispatchQueue.main.async {
                    self.handleResponse(response: response)
                }
            }, query: query)
        }
        view.endEditing(true)
    }
    
    func handleResponse(response:Definitions?){
        if let response = response{
            dictionaryResponse = response.list.sorted(using: KeyPathComparator(\.thumbs_up,order: .reverse))
            //refresh UI
            dictionaryResults.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //subiews done with frames
//        dictionaryResults.frame.size.width = view.bounds.width
//        dictionaryResults.frame.size.height = view.bounds.height-100
//        dictionaryResults.frame.origin.y = view.bounds.origin.y + 100
//
//        queryParameter.frame.size.width = view.bounds.width - 100
//        queryParameter.frame.size.height = 100
//
//        searchButton.frame.size.height = 100
//        searchButton.frame.size.width = 100
//        searchButton.frame.origin.x = view.bounds.width - 100
        
        //subviews done with autolayout
        let constraints = [
            //results constraints
            dictionaryResults.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            dictionaryResults.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dictionaryResults.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            //width and height constraints for button and text input
            queryParameter.widthAnchor.constraint(equalToConstant: view.bounds.width - 100),
            queryParameter.heightAnchor.constraint(equalToConstant: 100),
            searchButton.widthAnchor.constraint(equalToConstant: 100),
            searchButton.heightAnchor.constraint(equalToConstant: 100),
            
            //button and text input constraints
            queryParameter.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            queryParameter.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor),
            queryParameter.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            queryParameter.bottomAnchor.constraint(equalTo: dictionaryResults.topAnchor),
            searchButton.trailingAnchor.constraint(equalTo: queryParameter.leadingAnchor),
            searchButton.topAnchor.constraint(equalTo: searchButton.topAnchor),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchButton.bottomAnchor.constraint(equalTo: dictionaryResults.topAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionaryResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let definitionLabel = UILabel()
        let upVotes = UILabel()
        let downVotes = UILabel()
        
        definitionLabel.font = definitionLabel.font.withSize(10)
        definitionLabel.numberOfLines = 10
        definitionLabel.text = dictionaryResponse[indexPath.row].definition
        if let thumbs_up:Int = dictionaryResponse[indexPath.row].thumbs_up{
            upVotes.text = String(thumbs_up)
            
        }
        if let thumbs_down:Int = dictionaryResponse[indexPath.row].thumbs_down{
            downVotes.text = String(thumbs_down)
        }
        
        definitionLabel.frame = cell.frame
        definitionLabel.frame.size.height = cell.frame.height
        definitionLabel.frame.size.width = cell.frame.width-100

        upVotes.frame.size.height = cell.frame.height
        upVotes.frame.size.width = 50
        upVotes.frame.origin.x = 250

        downVotes.frame.size.height = cell.frame.height
        downVotes.frame.size.width = 50
        downVotes.frame.origin.x = 325

        cell.addSubview(definitionLabel)
        cell.addSubview(upVotes)
        cell.addSubview(downVotes)
        
        return cell
    }


}
extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { a, b in
                a[keyPath: keyPath] < b[keyPath: keyPath]
            }
        }
    }
