//
//  ViewController.swift
//  EarthquakeAPIInvasiveCode
//
//  Created by Paul Wallace on 10/19/17.
//  Copyright © 2017 Paul Wallace. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    private let urlString = "https://earthquake-report.com/feeds/recent-eq?json"
    
    @IBOutlet weak var tableView: UITableView!{
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
//            let string = NSStringFromClass(EarthquakeTableViewCell.class)
            let nib = UINib(nibName: "EarthquakeTableViewCell", bundle: nil)
            newValue.register(nib, forCellReuseIdentifier: EarthquakeTableViewCell.identifier)
        }
    }
    private lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    private lazy var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    private var earthquakes : [QuakeInfo] = []
    
    private lazy var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()
    
    private var viewContext : NSManagedObjectContext!
    
    private var globalContext : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        globalContext = appDelegate.persistentContainer.newBackgroundContext()
        viewContext = appDelegate.persistentContainer.viewContext
        globalContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        updateData(self)
    }
    
    func fetchData(){
        let entity = NSEntityDescription.entity(forEntityName: "QuakeInfo", in: viewContext)
        let fetchRequest = NSFetchRequest<QuakeInfo>()
        fetchRequest.entity = entity
        let sortDescriptor = NSSortDescriptor(key: "magnitude", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let results = try self.viewContext.fetch(fetchRequest)
            self.earthquakes = results
            self.tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func updateData(_ sender: Any) {
        guard let url : URL = URL(string: urlString) else {return}
        let dataTask = urlSession.dataTask(with: url) {
            (data: Data?, response : URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let jsonData = data else { return }
                do {
                    let tempQuakes = try self.jsonDecoder.decode([Earthquake].self, from: jsonData)
                    self.globalContext.perform { //needed for concurrecny I think
                        for earthquake in tempQuakes {
                            let quakeInfo = QuakeInfo(context: self.globalContext)
                            quakeInfo.title = earthquake.title
                            quakeInfo.magnitude = (earthquake.magnitude as NSString).floatValue
                            quakeInfo.date = earthquake.date as NSDate
                            
                            let quakeLoc = QuakeLoc(context: self.globalContext)
                            quakeLoc.depth = (earthquake.depth as NSString).floatValue
                            quakeLoc.latitude = (earthquake.latitude as NSString).doubleValue
                            quakeLoc.longitude = (earthquake.longitude as NSString).doubleValue
                            quakeLoc.location = earthquake.location
                            
                            let quakeWeb = QuakeWeb(context: self.globalContext)
                            quakeWeb.link = earthquake.link
                            
                            quakeInfo.quakeLoc = quakeLoc
                            quakeWeb.quakeLoc = quakeLoc

                            //SHOULD SAVE IN BATCHES, A CERTAIN NUMBER since save blocks 
                        }
                        do {
                            try self.globalContext.save()
                            DispatchQueue.main.async {
                                self.fetchData()
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                    return
                }
            }
        }
        dataTask.resume()
    }
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earthquakes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EarthquakeTableViewCell.identifier, for: indexPath) as! EarthquakeTableViewCell
        cell.title.text = earthquakes[indexPath.row].title
        cell.magnitude.text = "\(earthquakes[indexPath.row].magnitude)"
        cell.date.text = dateFormatter.string(from: earthquakes[indexPath.row].date! as Date)
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currQuakeInfo = self.earthquakes[indexPath.row]
        let currQuakeLoc = currQuakeInfo.quakeLoc
        let mapVC = MapViewController(nibName: "MapViewController", bundle: nil)
        self.show(mapVC, sender: nil)
        mapVC.currQuakeLoc = currQuakeLoc
    }
}

