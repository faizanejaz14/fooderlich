import 'package:flutter/material.dart';
import '../components/components.dart';
import '../models/models.dart';

class TodayRecipeListView extends StatelessWidget {
  final List<ExploreRecipe> recipes;

  const TodayRecipeListView({
    super.key,
    required this.recipes,
  });


  @override
  Widget build (BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Text('temp holding'),
        SizedBox(
          height: 16,
        ),
        Container(
          height: 400,
          color: Colors.transparent,
          child: ListView.separated(scrollDirection: Axis.horizontal,
            itemCount: recipes.length,
            itemBuilder: (context, index){
              final recipe = recipes[index];
              return buildCard(recipe);
            },
            separatorBuilder: (context, index){
              return const SizedBox(
                width: 16,
              );
            },
          ),
        )
      ]
      ),
    );
  }
  Widget buildCard (ExploreRecipe recipe){
    if (recipe.cardType == RecipeCardType.card1){
      return Card1(recipe: recipe);
    }else if (recipe.cardType == RecipeCardType.card2){
      return Card2(recipe: recipe);
    }else if (recipe.cardType == RecipeCardType.card3){
      return Card3(recipe: recipe);
    }else {
      throw Exception('The card is non existent');
    }
  }
}


