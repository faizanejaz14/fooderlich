import 'package:flutter/material.dart';
import 'grocery_tile_screen.dart';
import 'grocery_item_screen.dart';
import '../models/grocery_manager.dart';
import '../models/grocery_item.dart';


class GroceryListScreen extends StatelessWidget {
  final GroceryManager manager;

  const GroceryListScreen({Key? key, required this.manager}) : super(key: key);

  Importance _stringToImportance(String importance) {
      switch (importance.toLowerCase()) {
        case 'high':
          return Importance.high;
        case 'medium':
          return Importance.medium;
        case 'low':
          return Importance.low;
        default:
          return Importance.low; // Default fallback
      }
    }

    String _importanceToString(Importance importance){
      switch (importance) {
        case Importance.high:
          return 'High';
        case Importance.medium:
          return 'Medium';
        case Importance.low:
          return 'Low';
        default:
          return 'Low'; // Default fallback
      }
    }
  @override
  Widget build(BuildContext context) {
    final items = manager.groceryItems;

    return Scaffold(
      appBar: AppBar(title: const Text('Grocery List')),
      // body: ListView.builder(
      body: ListView.separated(
      
        itemCount: items.length,
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ),
        itemBuilder: (context, index) {
          final item = items[index];

          return Dismissible(
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete_forever, 
                color: Colors.white, size: 50.0),
            ),
            onDismissed: (direction) {
              manager.deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.name} dismissed')),
              );
            },
            child: InkWell(
              // child: GroceryTile(
              //   key: Key(item.id),
              //   item: item,
              //   onComplete: (change) {
              //     if (change != null) {
              //       manager.completeItem(index, change);
              //     }
              //   },
              // ),
              child: GroceryTile(
                key: Key(item.id),
                name: item.name,
                date: item.date,
                quantity: item.quantity,
                importance: _importanceToString(item.importance),
                onChecked: () => manager.completeItem(index, !item.isComplete),
                color: Colors.blue, // Or any logic to determine color
                onEdit: (newDate, newQuantity, newImportance) {
                  final updatedItem = item.copyWith(
                    date: newDate,
                    quantity: newQuantity,
                    importance: _stringToImportance(newImportance),
                  );
                  manager.updateItem(updatedItem, index);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroceryItemScreen(
                      originalItem: item,
                      onUpdate: (updatedItem) {
                        manager.updateItem(updatedItem, index);
                        Navigator.pop(context);
                      },
                      onCreate: (newItem) {},
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
