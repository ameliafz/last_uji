import 'package:flutter/material.dart';
import 'package:last_uji/home.dart';
import 'package:last_uji/register.dart';
import 'package:last_uji/services/auth_services.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController emailController = TextEditingController(),
      passController = TextEditingController();

  Firebase_Auth Auth = Firebase_Auth();

  void login() async {
    String _email = emailController.text, _pass = passController.text;

    var isAuth = await Auth.login(email: _email, password: _pass);

    if (_email.isEmpty || _pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Username Dan Password Tidak Boleh Kosong!"),
        ),
      );
      return;
    }

    AlertDialog alert = AlertDialog(
      title: Text("Berhasil Login"),
      content: Container(
        child: Text("Selamat datang"),
      ),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          ),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alert);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 180,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: TextFormField(
                  controller: emailController,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    suffixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: TextFormField(
                  controller: passController,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  cursorColor: Colors.grey,
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    suffixIcon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                  onPressed: () {
                    login();
                  },
                  child: Text(
                    "Login"
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left: 90)),
                  Text(
                    "Belum Punya akun?",
                  ),
                  GestureDetector(
                    child: Text(
                      " Register",
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      ),
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}