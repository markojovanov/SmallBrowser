import UIKit

class TableViewController: UITableViewController {
    
    var websites = ["google.com","youtube.com","hackingwithswift.com","apple.com"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return websites.count
        }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(websites[indexPath.row].split(separator: ".")[0]).uppercased()
            return cell
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let webViewController = storyboard?.instantiateViewController(withIdentifier: "View") as? ViewController {
                webViewController.websiteToLoad = websites[indexPath.row]
                navigationController?.pushViewController(webViewController, animated: true)
            }
    }
}
