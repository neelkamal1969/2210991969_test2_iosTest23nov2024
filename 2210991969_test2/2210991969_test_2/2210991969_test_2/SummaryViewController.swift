//
//  SummaryViewController.swift
//  2210991969_test_2
//
//  Created by student-2 on 23/11/24.
//

import UIKit

class SummaryViewController: UIViewController {
	@IBOutlet weak var summaryLabel: UILabel!

	var totalCalories: Int = 0
	var nutritionBreakdown: String = ""

	// viewDidLoad is called when the view is loaded into memory
	 override func viewDidLoad() {
		 super.viewDidLoad()

		 // Update the summary label with the total calories and nutrition breakdown
		 summaryLabel.text = "Total Calories: \(totalCalories)\n\nNutrition Breakdown:\n\(nutritionBreakdown)"
	 }

	@IBAction func closeSummary() {
		dismiss(animated: true)
	}
}

