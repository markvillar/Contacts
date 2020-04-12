//
//  ContentView.swift
//  Contacts
//
//  Created by Mark on 10/04/2020.
//  Copyright © 2020 Mark Villar. All rights reserved.
//

import SwiftUI

enum SectionType {
    case ceo, athletes, celebrities, other
}

class ContactSource: UITableViewDiffableDataSource<SectionType, Contact> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

class DiffableTableViewController: UITableViewController {
    
    lazy var source: ContactSource = .init(tableView: self.tableView) { (_, indexPath, contact) -> UITableViewCell? in
        let cell = ContactCell(style: .default, reuseIdentifier: nil)
        cell.viewModel.name = contact.name
        cell.viewModel.image = contact.image
        cell.viewModel.isFavourite = contact.isFavourite
        return cell
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupNavigation()
        setupSource()
    }
    
    fileprivate func setupNavigation() {
        navigationItem.rightBarButtonItem = .init(title: "Add", style: .plain, target: self, action: #selector(handleAddContact))
    }
    
    @objc func handleAddContact() {
        let contactFormView = ContactFormView { (name, sectionType)  in
            self.dismiss(animated: true)
            
            var snapshot = self.source.snapshot()
            
            snapshot.appendItems([
                .init(name: name, image: "https://res.cloudinary.com/apilama/image/fetch/f_auto,c_thumb,q_auto,w_300,h_300/https://s3-us-west-2.amazonaws.com/orfium-public/images/profiles/c88175d44b894f3183ed5c7ce816b907.jpg")
            ], toSection: sectionType)
            
            self.source.apply(snapshot)
        }
        let hostingController = UIHostingController(rootView: contactFormView)
        
        present(hostingController, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            completion(true)
            
            guard var snapshot = self?.source.snapshot() else { return }
            
            guard let contact = self?.source.itemIdentifier(for: indexPath) else { return }
            
            snapshot.deleteItems([contact])
            
            self?.source.apply(snapshot)
        }
        
        let favouriteAction = UIContextualAction(style: .normal, title: "Favourite") { [weak self] (_, _, completion) in
            completion(true)
            
            guard var snapshot = self?.source.snapshot() else { return }
            
            guard let contact = self?.source.itemIdentifier(for: indexPath) else { return }
            
            contact.isFavourite.toggle()
            
            snapshot.reloadItems([contact])
            
            self?.source.apply(snapshot)
            
        }
        
        return .init(actions: [deleteAction, favouriteAction])
    }
    
    func setupSource() {
        var snapshot = source.snapshot()
        snapshot.appendSections([.ceo, .athletes, .celebrities])
        
        snapshot.appendItems([
            .init(name: "Elon Musk", image: "https://www.biography.com/.image/t_share/MTY2MzU3Nzk2OTM2MjMwNTkx/elon_musk_royal_society.jpg"),
            .init(name: "Bill Gates", image: "https://pbs.twimg.com/profile_images/988775660163252226/XpgonN0X_400x400.jpg"),
            .init(name: "Jeff Bezos", image: "https://www.proactiveinvestors.com/upload/Article/Image/2018_10/1539710172_bezos.jpg"),
            .init(name: "Tim Cook", image: "https://www.looktothestars.org/photo/12957-tim-cook/story_half_width.jpg"),
            .init(name: "Larry Ellison", image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Larry_Ellison_picture.png"),
            .init(name: "Steve Ballmer", image: "https://cdn2.hubspot.net/hubfs/1716276/API/celebrities/Steve_Ballmer.jpg")
        ], toSection: .ceo)
        
        snapshot.appendItems([
            .init(name: "Kobe Bryant", image: "https://lh3.googleusercontent.com/proxy/naTLCrAKQeztNSlb9t9-VEm7mAKBTQeI7CPDW3jP83HofAgIbKLPrI8uQ5g46dZxFsi53fuPiGvHn1BkQj-lP8lP_zPi52sPw7GRWQ7Oe7_1eRYAxCjKxarvJntMke5-CHs_go0B1lj2BoE4OvMYh9Nkt1s4W3NyXyO963OK_-LF"),
            .init(name: "Anthony Davis", image: "https://playerswiki.com/uploads/thumb/xanthony-davis-300-300.jpeg.pagespeed.ic.ersSsfGAHS.jpg"),
            .init(name: "Stephen Curry", image: "https://thumbor.forbes.com/thumbor/fit-in/416x416/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5cfeafe234a5c4000847fe0b%2F0x0.jpg%3Fbackground%3D000000%26cropX1%3D2262%26cropX2%3D3516%26cropY1%3D640%26cropY2%3D1894")
        ], toSection: .athletes)
        
        snapshot.appendItems([
            .init(name: "Daniel Craig", image: "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-15/e15/c1.0.1078.1078a/s640x640/81473100_890079188097573_3212549203202901355_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_cat=109&_nc_ohc=vz1d-Vx4BikAX9CZU-x&oh=e3a38feff4955ff5e3d97510b7aa22c9&oe=5ED03108"),
            .init(name: "Keira Knightley", image: "https://www.biography.com/.image/t_share/MTQyMDAyMDM3MDU0MjUyNzQw/keira-knightley_gettyimages-462189176jpg.jpg")
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
