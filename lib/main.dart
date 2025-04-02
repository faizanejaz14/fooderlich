import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fooderlich_theme.dart';
import 'home.dart';
import 'screens/login_screen.dart'; // Import Login screen
import 'models/models.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.light();
    return MaterialApp(
      theme: theme,
      title: 'Fooderlich',
      home: MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (context)=> TabManager(),),
          ChangeNotifierProvider(create: (context)=> GroceryManager()),
          ChangeNotifierProvider(create: (context) => LoginManager()), // 
        ] ,
        // child: const Home(), 
        //child: const LoginScreen(), // Start with LoginScreen     
        child: Builder(
        builder: (context) {
          final loginManager = Provider.of<LoginManager>(context);
          return MaterialApp(
            theme: FooderlichTheme.light(),
            title: 'Fooderlich',
            home: loginManager.isLoggedIn ? const Home() : const LoginScreen(),
          );
        },
      ),
      ),
    );
  }
}
