import 'package:flutter/material.dart';
import 'package:recipes/Comm/comHelper.dart';
import 'package:recipes/Comm/genLoginSignupHeader.dart';
import 'package:recipes/Comm/genTextFormField.dart';
import 'package:recipes/DatabaseHandler/DbHelper.dart';
import 'package:recipes/Model/UserModel.dart';
import 'package:recipes/Screens/LoginForm.dart';
import 'package:recipes/screens/navigation.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  GlobalKey<FormState> signupkey = GlobalKey<FormState>();

  TextEditingController _conUserId = TextEditingController();
  TextEditingController _conUserName = TextEditingController();
  TextEditingController _conEmail = TextEditingController();
  TextEditingController _conPassword = TextEditingController();
  TextEditingController _conCPassword = TextEditingController();

  var database;

  void alert(BuildContext context, {required Widget title}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    database = DbHelper();
  }

  // ...

  signUp() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;

    if (signupkey.currentState!.validate()) {
      if (passwd != cpasswd) {
        return alert(context, title: Text('Password Mismatch'));
      } else {
        signupkey.currentState!.save();

        UserModel uModel = UserModel(uid, uname, email, passwd);
        await database.saveData(uModel).then((userData)
        {
          return alert(context, title: Text('Create Account Success'));
        }).catchError((error) {
          print(error);

          return alert(context, title: Text('Error'));

        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
        backgroundColor: Colors.green[200],
      ),
      body: Form(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _conUserName,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'User Name'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _conEmail,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conCPassword,
                    icon: Icons.lock,
                    hintName: 'Confirm Password',
                    isObscureText: true,
                  ),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[200],
                      ),
                      child: const Text('Login'),
                      onPressed:(signUp
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Does you have account? '),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => HomePage()),
                                    (Route<dynamic> route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[200]),
                          child: Text('SignIn'),

                        )
                      ],
                    ),
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