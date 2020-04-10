//
//  ContentView.swift
//  Contacts
//
//  Created by Mark on 10/04/2020.
//  Copyright © 2020 Mark Villar. All rights reserved.
//

import SwiftUI

enum SectionType {
    case ceo, athletes, celebrities
}

struct Contact: Hashable {
    let name: String
}

class DiffableTableViewController: UITableViewController {
    
    lazy var source: UITableViewDiffableDataSource<SectionType, Contact> = .init(tableView: self.tableView) { (_, indexPath, contact) -> UITableViewCell? in
        let cell = ContactCell(style: .default, reuseIdentifier: nil)
        cell.viewModel.name = contact.name
        return cell
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupSource()
    }
    
    func setupSource() {
        var snapshot = source.snapshot()
        snapshot.appendSections([.ceo, .athletes, .celebrities])
        
        snapshot.appendItems([
            .init(name: "Elon Musk"),
            .init(name: "Bill Gates"),
            .init(name: "Steve Jobs"),
            .init(name: "Jeff Bezos"),
            .init(name: "Tim Cook"),
            .init(name: "Larry Ellison"),
            .init(name: "Steve Ballmer")
        ], toSection: .ceo)
        
        snapshot.appendItems([
            .init(name: "Kobe Bryant"),
            .init(name: "Anthony Davis"),
            .init(name: "Stephen Curry"),
            .init(name: "Kevin Love")
        ], toSection: .athletes)
        
        snapshot.appendItems([
            .init(name: "Keira Knightley"),
            .init(name: "Dua Lipa")
        ], toSection: .celebrities)
        
        source.apply(snapshot)
    }
    
    // Currently does not work in iOS 13
    //override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //    return "Header \(section)"
    //}
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerLabel = UILabel()
        
        switch section {
        case 0:
            headerLabel.text = "CEOs"
        case 1:
            headerLabel.text = "Athletes"
        case 2:
            headerLabel.text = "Celebrities"
        default:
            headerLabel.text = "Other"
        }
        
        return headerLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

// SwiftUI Container
struct DiffableContainer: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        UINavigationController(rootViewController: DiffableTableViewController(style: .insetGrouped))
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiffableContainer()
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}
