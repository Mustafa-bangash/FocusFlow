import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:focus_flow_project/Home.dart';
import 'package:focus_flow_project/Signup.dart';
import 'package:focus_flow_project/main.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Enter required fields"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationClass()),
      );
    } on FirebaseException catch (ex) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Login Failed"),
          content: Text(ex.code.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Login Page',style: TextStyle(color: Color(0xFF9966FF)),),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFF111215),
        child: Padding(
          
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // EMAIL FIELD
              TextField(
                controller: emailController,
                style: TextStyle(
                  color: Colors.white
                ),
                decoration: InputDecoration(
                  labelText: "Email",
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(),
                ),
              ),
        
              SizedBox(height: 20),
        
              // PASSWORD FIELD
              TextField(
                controller: passwordController,
                style: TextStyle(
                    color: Colors.white
                ),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(),
                ),
              ),
        
              SizedBox(height: 30),
        
              // LOGIN BUTTON
              ElevatedButton(
                onPressed: () {
                  signIn(emailController.text.trim(),
                      passwordController.text.trim());
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),
              ),
        
              SizedBox(height: 30),
        
              // SIGNUP NAVIGATION
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
