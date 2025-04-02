import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';
import '../components/friend_post_tile.dart';

class FriendPostListView extends StatelessWidget {
  final List<Post> friendPosts;

  const FriendPostListView({super.key, required this.friendPosts});

  @override
  Widget build (BuildContext context){
    return Padding(padding: EdgeInsets.only(
      left: 16,
      right: 16,
      top: 0,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('temp'),
        SizedBox(
          height: 16,
        ),
        ListView.separated(
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: friendPosts.length,
            itemBuilder: (context, index){
              final post = friendPosts[index];
              return FriendPostTile(post: post);
            },
            separatorBuilder: (context, index){
              return const SizedBox(
                width: 16,
              );
            },
        ),
        SizedBox(
          height: 16,
        ),
      ],
    ),
    );
  }
  
}