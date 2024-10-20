import 'package:flutter/material.dart';
import 'package:movieapp/global_keys.dart';
import 'package:movieapp/providers/common.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      Provider.of<CommonProvider>(GlobalKeys.navigatorKey.currentContext!,
              listen: false)
          .onLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's sign you in.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Welcome back",
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                    Text(
                      "You've been missed!",
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Утасны дугаараа оруулна уу!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.9), width: 1),
                        ),
                        label: Text("Утасны дугаар"),
                        labelStyle:
                            TextStyle(color: Colors.white.withOpacity(0.6)),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Нууц үгээ оруулна уу!";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.9), width: 1),
                        ),
                        label: Text("Нууц үг"),
                        labelStyle:
                            TextStyle(color: Colors.white.withOpacity(0.6)),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: () => _onSubmit(),
                      child: Text("Нэвтрэх")),
                )
              ],
            )));
  }
}
