import UIKit

class EntriesTableViewController: UITableViewController {
    private let expositionEntries: [ExpositionEntry]? = JSONParser<[ExpositionEntry]>.decode(
        from: "items")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expositionEntries?.count ?? 0
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Identifier.entryCell,
            for: indexPath
        )
        let defaultContentConfiguration = cell.defaultContentConfiguration()
        cell.contentConfiguration = setCellConfiguration(
            from: defaultContentConfiguration,
            cellForRowAt: indexPath
        )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let entryDetailViewController = storyboard?.instantiateViewController(
            withIdentifier: Identifier.entryDetailView
        ) as? EntryDetailViewController else {
            return
        }
        
        let title = expositionEntries?[indexPath.row].name
        let image = expositionEntries?[indexPath.row].image
        let description = expositionEntries?[indexPath.row].description
        entryDetailViewController.setEntryData(image: image, description: description)
        entryDetailViewController.navigationItem.title = title
        
        navigationController?.pushViewController(entryDetailViewController, animated: true)
    }
    
    private func setCellConfiguration(
        from defaultConfiguration: UIListContentConfiguration,
        cellForRowAt indexPath: IndexPath
    ) -> UIListContentConfiguration {
        var configuration = defaultConfiguration
        configuration.textProperties.font = UIFont.preferredFont(forTextStyle: .title1)
        configuration.textProperties.adjustsFontForContentSizeCategory = true
        configuration.text = expositionEntries?[indexPath.row].name
        configuration.secondaryText = expositionEntries?[indexPath.row].shortDescription
        configuration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .body)
        configuration.secondaryTextProperties.adjustsFontForContentSizeCategory = true
        configuration.image = expositionEntries?[indexPath.row].image
        configuration.imageProperties.maximumSize.height = 50
        configuration.imageProperties.maximumSize.width = 50
        configuration.imageProperties.reservedLayoutSize.width = 50
        return configuration
    }
}
