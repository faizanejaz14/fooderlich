import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../models/grocery_item.dart';


class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              '../assets/fooderlich_assets/grocery_screen.jpg', // Ensure this image exists in assets
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'No Groceries',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Shopping for ingredients? Tap the + button to write them down!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              // onPressed: () {
              //  Provider.of<TabManager>(context, listen: false).goToRecipes();
              // },
              // child: const Text('Browse Recipes'),
                onPressed: () {
                  final manager = Provider.of<GroceryManager>(
                    context, listen: false);

                  // Add some default grocery items
                  manager.addItem(GroceryItem(
                    id: DateTime.now().millisecondsSinceEpoch.toString(), 
                    name: 'Tomatoes',
                    importance: Importance.high,
                    color: Colors.red, // Color based on item type
                    quantity: 2,
                    date: DateTime.now(),
                    isComplete: false,
                  ));

                  manager.addItem(GroceryItem(
                    id: DateTime.now().millisecondsSinceEpoch.toString() + '1', 
                    name: 'Milk',
                    importance: Importance.medium,
                    color: Colors.white,
                    quantity: 1,
                    date: DateTime.now(),
                    isComplete: false,
                  ));

                  manager.addItem(GroceryItem(
                    id: DateTime.now().millisecondsSinceEpoch.toString() + '2', 
                    name: 'Eggs',
                    importance: Importance.low,
                    color: Colors.brown,
                    quantity: 12,
                    date: DateTime.now(),
                    isComplete: false,
                  ));

                  // Print to check
                  print('Items added to GroceryManager: ${
                    manager.groceryItems.length}');

                  // Show the grocery list after adding items
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Default grocery items added!')),
                  );
                },
                child: const Text('Add Some Items'),
            ),
          ],
        ),
      ),
    );
  }
}
