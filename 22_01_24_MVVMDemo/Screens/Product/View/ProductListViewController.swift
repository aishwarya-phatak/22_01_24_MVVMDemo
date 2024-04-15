//
//  ProductListViewController.swift
//  22_01_24_MVVMDemo
//
//  Created by Vishal Jagtap on 15/04/24.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    private let viewModel = ProductViewModel()
    private let productTableViewCellIdentifier = "ProductTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initProductTableView()
        registerWithXIB()
        initViewModel()
        observeEvent()
    }
    
    func initProductTableView(){
        productTableView.dataSource = self
        productTableView.delegate = self
    }
    
    func registerWithXIB(){
        let uiNib = UINib(nibName: productTableViewCellIdentifier, bundle: nil)
        self.productTableView.register(uiNib, forCellReuseIdentifier: productTableViewCellIdentifier)
    }
    
    func initViewModel(){
        viewModel.fetchProducts()
    }
    
    func observeEvent(){
        viewModel.eventHandler = { event in 
            switch event{
            case .loading:
                print("Data is loading..")
            case .stopLoading:
                print("Stop Loading..")
            case .dataLoaded:
                print("Data Loaded")
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
                print(self.viewModel.products)
            case .error(let error):
                print(error)
            }
        }
    }
}

extension ProductListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productTableVieWCell = self.productTableView.dequeueReusableCell(withIdentifier: productTableViewCellIdentifier, for: indexPath) as! ProductTableViewCell
        productTableVieWCell.product = viewModel.products[indexPath.row]
        return productTableVieWCell
    }
}


extension ProductListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }
}
