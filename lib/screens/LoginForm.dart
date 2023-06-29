import 'package:flutter/material.dart';
import 'package:recipes/Comm/comHelper.dart';
import 'package:recipes/Comm/genLoginSignupHeader.dart';
import 'package:recipes/Comm/genTextFormField.dart';
import 'package:recipes/DatabaseHandler/DbHelper.dart';
import 'package:recipes/Model/UserModel.dart';
import 'package:recipes/Screens/SignupForm.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();

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

  login() async {
    String uid = _conUserId.text;
    String passwd = _conPassword.text;

    if (uid.isEmpty) {
      return alert(context, title: Text('Please Enter Username'));
    } else if (passwd.isEmpty) {
      return alert(context, title: Text('Please Enter Password'));
    } else {
      await database.getLoginUser(uid, passwd).then((userData) {
        if (userData != null) {
          // data check betul dia push and remove until
          //route tak boleh back
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginForm()),
                    (Route<dynamic> route) => false);
          });
        } else {
          return alert(context, title: Text('User Not Found. Please Create an Account'));
        }
      }).catchError((error) {
        print(error);
        return alert(context, title: Text('Login Fail'));
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id);
    sp.setString("user_name", user.user_name);
    sp.setString("email", user.email);
    sp.setString("password", user.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        backgroundColor: Colors.green[200],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                genLoginSignupHeader('Login'),
                getTextFormField(
                  controller: _conUserId,
                  icon: Icons.person,
                  hintName: 'username',
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Password',
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
                    onPressed: login,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.green[200],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Does not have account? '),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignupForm()));
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
    );
  }
}