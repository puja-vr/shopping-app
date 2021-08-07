import 'package:flutter/material.dart';
import 'package:shopping_app/components/button.dart';
import 'package:shopping_app/components/form_error.dart';
import 'package:shopping_app/screens/home/home_screen.dart';
import 'package:shopping_app/services/auth.dart';
import 'package:shopping_app/shared/constants.dart';

class SignForm extends StatefulWidget {
  final bool signIn;
  SignForm({this.signIn = false});
  @override
  _SignFormState createState() => _SignFormState(signIn: signIn);
}

class _SignFormState extends State<SignForm> {
  final bool signIn;
  _SignFormState({this.signIn = false});

  final AuthService _ds = AuthService();
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;
  final List<String> errors = [];

  Future<dynamic> function(bool signIn) async {
    if (signIn == true) {
      result = await _ds.signInWithEmailAndPassword(email, password);
    } else {
      result = await _ds.signUpEmailAndPassword(email, password);
    }
    if (result == null) {
      setState(() {
        addError(error: kSignInError);
      });
    } else {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }

  void addError({required String error}) {
    if (!errors.contains(error)) errors.add(error);
  }

  void removeError({required String error}) {
    if (errors.contains(error)) errors.remove(error);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          buildEmailFormField(),
          SizedBox(height: 30),
          buildPasswordFormField(),
          SizedBox(height: 30),
          FormError(errors: errors),
          SizedBox(height: 20),
          Button(
            text: "Continue",
            press: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              if (_formKey.currentState!.validate()) {
                function(signIn);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        setState(() {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          }
          if (value.length >= 8) {
            removeError(error: kShortPassError);
          }
          password = value;
        });
      },
      validator: (value) {
        setState(() {
          if (value!.isEmpty) {
            addError(error: kPassNullError);
            return;
          }
          if (value.length < 8) {
            addError(error: kShortPassError);
            return;
          }
          return null;
        });
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Icons.lock,
            color: kpurple[800],
          ),
        ),
        fillColor: kwhite,
        filled: true,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        setState(() {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          }
          if (emailValidatorRegExp.hasMatch(value)) {
            removeError(error: kInvalidEmailError);
          }
          email = value;
        });
      },
      validator: (value) {
        setState(() {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return;
          }
          if (!emailValidatorRegExp.hasMatch(value)) {
            addError(error: kInvalidEmailError);
            return;
          }
          return null;
        });
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Icons.mail,
            color: kpurple[800],
          ),
        ),
        fillColor: kwhite,
        filled: true,
      ),
    );
  }
}
