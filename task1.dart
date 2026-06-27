import 'package:flutter/material.dart';
void main()=> runApp(myApp());

class myApp extends StatelessWidget{
  const myApp ({super.key});
  @override
  Widget build (BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Login Screen',
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context){
  return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
        width: 500,
        child: Center(
          child:
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
          const SizedBox(height: 25),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value){
              if(value == null || value.isEmpty){
                return 'Please enter your email';
              }
              if(!value.contains('@')){
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
                const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            validator: (value){
              if(value == null || value.isEmpty){
                return 'Please enter your password';
              }
              if(value.length < 6){
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                              }
              },
                      child: const Text('Login'),
          ),
        ],
      ),
    ),
  ),
),
    ),
);

}
}
class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Text('Welcome to the Home Screen'),
      ),
    );
  }
}