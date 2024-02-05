import 'package:flutter/material.dart';
import 'confirmation_screen.dart';

class FormScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
        const SnackBar(content: Text("Thank you form submitted successfully")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(
            name: _nameController.text,
            email: _emailController.text,
          ),
        ),
      );


    }
  }

  String? validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter an Email";
    }
    RegExp emailregexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailregexp.hasMatch(value)) {
      return "Please Enter a valid Email";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Enter Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter UserName";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30,),
              TextFormField(
                controller: _emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Enter Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: validateEmail,
              ),
              SizedBox(height: 30,),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.purple,
                ),
                child: ElevatedButton(
                  onPressed: () => _submitForm(context),
                  child: Text("Submit", style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
