import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';
import 'screens/explore_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/grocery_screen.dart';
import 'screens/login_screen.dart'; // Import the Login screen

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    
    ExploreScreen(),
    RecipesScreen(),
    GroceryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<TabManager>(builder:(context, tabManager, child){
    return Consumer2<TabManager, LoginManager>(
      builder: (context, tabManager, loginManager, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Fooderlich',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            if (!loginManager.isLoggedIn) 
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              )
            else 
              TextButton(
                onPressed: () {
                  //loginManager.logout(); // Logout the user
                  Provider.of<LoginManager>(context, listen: false).logout();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logged out successfully!',
                      style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.yellow,
                    ),
                  );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              
          ],
        ),
        // body: pages[_selectedIndex],
        // body: pages[tabManager.selectedTab],
        body: IndexedStack(
          index: tabManager.selectedTab,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: 
            Theme.of(context).textSelectionTheme.selectionColor,
          //currentIndex: _selectedIndex,
          currentIndex: tabManager.selectedTab,
          // onTap: _onItemTapped,
          onTap: (index){tabManager.goToTab(index);},
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'To Buy',
            ),
          ],
        ),
      );
    }
    );
  }
}
