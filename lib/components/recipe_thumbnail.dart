import 'package:flutter/material.dart';
import '../models/models.dart';

class RecipeThumbnail extends StatelessWidget{
  final SimpleRecipe recipe;

  const RecipeThumbnail({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            recipe.dishImage,
            fit: BoxFit.cover,
          ),
        ),
        ),
        const SizedBox(
          height: 10,
        ),
       Text(
          recipe.title,
          style: TextStyle(
            fontSize: 12, // Bigger size
            fontWeight: FontWeight.bold, 
            color: Colors.amber, // Gold color
          ),
        ),
        Text(
          recipe.duration,
          style: TextStyle(
            fontStyle: FontStyle.italic, // Italic
            fontSize: 8
          ),
        ),
        Text(
          recipe.source,
          style: TextStyle(
            fontSize: 6, // Small size
          ),
        ),
      ],
      ),


    
    );
  }
}