//
//  DetailsViewController.swift
//  2210991969_test_2
//
//  Created by student-2 on 23/11/24.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	
	
	private func showAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default))
		present(alert, animated: true)
	}

	

	@IBOutlet weak var nameField: UITextField!
	@IBOutlet var ingredientsField: UITextField!
	@IBOutlet weak var instructionsField: UITextField!
	@IBOutlet weak var categoryField: UITextField!
	@IBOutlet weak var caloriesField: UITextField!
	@IBOutlet weak var prepTimeField: UITextField!
	@IBOutlet weak var imageView: UIImageView!

	var selectedMeal: Meal?
	// Reference to Core Data context
		let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

	override func viewDidLoad() {
		super.viewDidLoad()
		if let meal = selectedMeal {
			nameField.text = meal.name
			ingredientsField.text = meal.ingredients
			instructionsField.text = meal.instructions
			categoryField.text = meal.category
			caloriesField.text = "\(meal.calories)"
			prepTimeField.text = "\(meal.prepTime)"
			imageView.image = UIImage(data: meal.image)
			if let imageData = meal.image {
						 imageView.image = UIImage(data: imageData)
					 }
		}
	}

	@IBAction func saveMeal() {
		// Either update the selected meal or create a new one
				let meal: Meal
				if let existingMeal = selectedMeal {
					meal = existingMeal
				} else {
					meal = Meal(context: context) // Create a new Meal object
				}
				
				// Validate and save inputs
				guard let name = nameField.text, !name.isEmpty,
					  let ingredients = ingredientsField.text, !ingredients.isEmpty,
					  let instructions = instructionsField.text, !instructions.isEmpty,
					  let category = categoryField.text, !category.isEmpty,
					  let caloriesText = caloriesField.text, let calories = Int16(caloriesText),
					  let prepTimeText = prepTimeField.text, let prepTime = Int16(prepTimeText) else {
					showAlert(title: "Error", message: "Please fill in all fields.")
					return
				}
				
				meal.name = name
				meal.ingredients = ingredients
				meal.instructions = instructions
				meal.category = category
				meal.calories = calories
				meal.prepTime = prepTime
				if let image = imageView.image, let imageData = image.jpegData(compressionQuality: 0.8) {
					meal.image = imageData
				}
				
				do {
					try context.save()
					navigationController?.popViewController(animated: true)
				} catch {
					print("Error saving meal: \(error)")
				}	}

	@IBAction func uploadImage() {
		let picker = UIImagePickerController()
		picker.delegate = self
		picker.sourceType = .photoLibrary
		present(picker, animated: true)
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		if let image = info[.originalImage] as? UIImage {
			imageView.image = image
		}
		dismiss(animated: true)
	}
}
