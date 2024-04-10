import 'package:flutter/material.dart';
import 'login_page.dart';

class RegistrationFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Registration'),
      ),
      body: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  late String regnum = '23BCE1380';
  late String name = 'Ananya Singh';
  late String course = 'Bachelor of technology';
  late String branch = 'CSE core';
  late String mail = 'ananya.singh2023@vitstudent.ac.in';
  late String passwd = 'student';
  late String gender = 'female';
  late String accommodation = 'hosteller';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Reg No.: $regnum'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Name: $name'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Course: $course'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Branch: $branch'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('VIT Mail: $mail'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Password: $passwd'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Gender: $gender'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Accommodation: $accommodation'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            },
            child: Text('LOGOUT'),
          ),
        ],
      ),
    );
  }
}
