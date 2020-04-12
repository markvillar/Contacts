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
            .init(name: "Elon Musk", image: "https://www.biography.com/.image/t_share/MTY2MzU3Nzk2OTM2MjMwNTkx/elon_musk_royal_society.jpg"),
            .init(name: "Bill Gates", image: "https://pbs.twimg.com/profile_images/988775660163252226/XpgonN0X_400x400.jpg"),
            .init(name: "Steve Jobs", image: "https://www.biography.com/.image/t_share/MTY2MzU3OTcxMTUwODQxNTM1/steve-jobs--david-paul-morrisbloomberg-via-getty-images.jpg"),
            .init(name: "Jeff Bezos", image: "https://www.proactiveinvestors.com/upload/Article/Image/2018_10/1539710172_bezos.jpg"),
            .init(name: "Tim Cook", image: "https://www.looktothestars.org/photo/12957-tim-cook/story_half_width.jpg"),
            .init(name: "Larry Ellison", image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Larry_Ellison_picture.png"),
            .init(name: "Steve Ballmer", image: "https://cdn2.hubspot.net/hubfs/1716276/API/celebrities/Steve_Ballmer.jpg")
        ], toSection: .ceo)
        
        snapshot.appendItems([
            .init(name: "Kobe Bryant", image: "https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/110.png"),
            .init(name: "Anthony Davis", image: "https://playerswiki.com/uploads/thumb/xanthony-davis-300-300.jpeg.pagespeed.ic.ersSsfGAHS.jpg"),
            .init(name: "Stephen Curry", image: "https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/3975.png"),
            .init(name: "Kevin Love", image: "https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/3449.png")
        ], toSection: .athletes)
        
        snapshot.appendItems([
            .init(name: "Keira Knightley", image: "https://www.thefamouspeople.com/profiles/images/keira-knightley-3.jpg"),
            .init(name: "Dua Lipa", image: "https://i.insider.com/5b58c4425ae6b4d6018b457d?width=1100&format=jpeg&auto=webp")
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
        DiffableContainer()
    }
}
