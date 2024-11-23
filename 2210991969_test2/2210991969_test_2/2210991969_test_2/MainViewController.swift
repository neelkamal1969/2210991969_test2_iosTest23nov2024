//
//  MainViewController.swift
//  2210991969_test_2
//
//  Created by student-2 on 23/11/24.
//
import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	let Meal = 2210991969_test_2.Meal()

	@IBOutlet weak var tableView: UITableView!
	var meals: [Meal] = [] // Replace with Core Data fetch if using it


	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		fetchMeals() // Load data from Core Data or UserDefaults
	}
	
	
	func fetchMeals() {
		   guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
		   let context = appDelegate.persistentContainer.viewContext

		   let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()

		   do {
			   meals = try context.fetch(fetchRequest)
			   tableView.reloadData() // Reload table view after fetching
			   print("Fetched \(meals.count) meals.")
		   } catch {
			   print("Failed to fetch meals: \(error.localizedDescription)")
		   }
	   }

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return meals.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		  let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath)
		  let meal = meals[indexPath.row]

		  // Configure the cell
		  cell.textLabel?.text = meal.name ?? "Unnamed Meal"
		  cell.detailTextLabel?.text = "\(meal.calories) Calories | \(meal.prepTime) min"
		  
		  if let imageData = meal.image {
			  cell.imageView?.image = UIImage(data: imageData)
		  } else {
			  cell.imageView?.image = UIImage(systemName: "photo") // Default placeholder image
		  }

		  return cell
	  }

	// MARK: - Navigation to Details Screen
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		 if segue.identifier == "ShowDetails",
			let detailsVC = segue.destination as? DetailsViewController,
			let selectedRow = tableView.indexPathForSelectedRow?.row {
			 detailsVC.selectedMeal = meals[selectedRow]
		 }
	 }

	 
}

