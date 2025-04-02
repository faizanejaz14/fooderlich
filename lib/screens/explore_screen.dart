import 'package:flutter/material.dart';
import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';
import '../models/explore_data.dart';


class ExploreScreen extends StatelessWidget {
  final mockService = MockFooderlichService();

  ExploreScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: mockService.getExploreData(), 
      builder: (context, AsyncSnapshot<ExploreData> snapshot){
        if (snapshot.connectionState == ConnectionState.done){
          //final recipes = (snapshot.data as ExploreData).todayRecipes;
         // return TodayRecipeListView(recipes: recipes);
         return ListView(
          scrollDirection: Axis.vertical,
          children: [
            TodayRecipeListView(recipes: 
            snapshot.data?.todayRecipes ?? []),
            const SizedBox(
              height: 16,
            ),
            FriendPostListView(friendPosts: snapshot.data?.friendPosts ?? [])
          ],
         );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}