// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//         // leading: IconButton(
//         //   icon: const Icon(Icons.arrow_back),
//         //   onPressed: () {
//         //     Navigator.pop(context); // Go back when pressed
//         //   },
//         // ),
//       ),
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Welcome Back!',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 40),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   _buildTextField(Icons.email, 'Email', false),
//                   const SizedBox(height: 20),
//                   _buildTextField(Icons.lock, 'Password', true),
//                   const SizedBox(height: 10),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {},
//                       child: const Text(
//                         'Forgot Password?',
//                         style: TextStyle(color: Colors.white70),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   _buildLoginButton(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// Widget _buildTextField(IconData icon, String hint, bool isPassword) {
//   return SizedBox(
//     height: 40, // Reduced height
//     child: TextField(
//       obscureText: isPassword ? _obscureText : false,
//       style: const TextStyle(color: Colors.white, fontSize: 14), // 
//       textAlignVertical: TextAlignVertical.center, // Align text properly
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 10, horizontal: 15),
//         prefixIcon: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 5), //
//           child: Icon(icon, color: Colors.white70, size: 18), // Smaller icon
//         ),
//         prefixIconConstraints: const BoxConstraints(
//           minWidth: 35, // Ensures icon alignment
//           minHeight: 20,
//         ),
//         suffixIcon: isPassword
//             ? IconButton(
//                 icon: Icon(
//                   _obscureText ? Icons.visibility_off : Icons.visibility,
//                   color: Colors.white70,
//                   size: 18, // Smaller icon
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _obscureText = !_obscureText;
//                   });
//                 },
//               )
//             : null,
//         hintText: hint,
//         hintStyle: const TextStyle(color: Colors.white54, fontSize: 14), // 
//         filled: true,
//         fillColor: Colors.white24,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     ),
//   );
// }


//   Widget _buildLoginButton() {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.blueAccent,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//         minimumSize: const Size(double.infinity, 50),
//       ),
//       child: const Text(
//         'Login',
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home.dart'; // Import Home
import '../models/models.dart'; // Import LoginManager

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Hardcoded login credentials
  final String correctEmail = 'admin@example.com';
  final String correctPassword = '123456';

  void _login() {
    if (_emailController.text == correctEmail &&
        _passwordController.text == correctPassword) {
          // ✅ Update LoginManager state
      Provider.of<LoginManager>(context, listen: false).login();
      // Navigate to Home and remove LoginScreen from stack
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildTextField(
                    Icons.email, 'Email', false, _emailController),
                  const SizedBox(height: 20),
                  _buildTextField(
                    Icons.lock, 'Password', true, _passwordController),
                  const SizedBox(height: 20),
                  _buildLoginButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    IconData icon, String hint, bool isPassword, 
    TextEditingController controller) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscureText : false,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 15),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10, right: 5),
            child: Icon(icon, color: Colors.white70, size: 18),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility, 
                    color: Colors.white70, size: 18),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
          filled: true,
          fillColor: Colors.white24,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), 
          borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _login,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text('Login', style: TextStyle(fontSize: 18, 
      fontWeight: FontWeight.bold)),
    );
  }
}
