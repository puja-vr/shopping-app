import 'package:flutter/material.dart';
import 'package:shopping_app/components/button.dart';
import 'package:shopping_app/components/form_error.dart';
import 'package:shopping_app/services/database.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/shared/screen_size.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";
  final String uid;
  final String email;
  ProfileScreen({
    required this.uid,
    required this.email,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String name = '';
  int phone = 0;
  String address = '';

  void addError({required String error}) {
    if (!errors.contains(error)) errors.add(error);
  }

  void removeError({required String error}) {
    if (errors.contains(error)) errors.remove(error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kpurple[50],
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: ScreenSize.screenWidth * 0.3,
                  height: ScreenSize.screenWidth * 0.3,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 5, color: kwhite),
                      color: kpurple[800]),
                  child: Icon(Icons.person, size: 100, color: kwhite),
                ),
                SizedBox(height: 30),
                buildEmailFormField(),
                SizedBox(height: 30),
                buildNameFormField(),
                SizedBox(height: 30),
                buildPhoneNumberFormField(),
                SizedBox(height: 30),
                buildAddressFormField(),
                SizedBox(height: 30),
                FormError(errors: errors),
                SizedBox(height: 20),
                Button(
                  text: "Save",
                  press: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (_formKey.currentState!.validate()) {
                      DatabaseService(uid: widget.uid)
                          .updateUserData(name, widget.email, phone, address);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        padding: EdgeInsets.fromLTRB(20, 7, 0, 7),
                        content: Text("Profile updated!",
                            style: TextStyle(color: kwhite, fontSize: 16)),
                        backgroundColor: kpurple,
                        duration: defaultDuration,
                      ));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "${widget.email}",
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

  TextFormField buildAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => address = newValue!,
      onChanged: (value) {
        setState(() {
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }
          address = value;
        });
      },
      validator: (value) {
        setState(() {
          if (value!.isEmpty) {
            addError(error: kAddressNullError);
            return;
          }
          return null;
        });
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Icons.my_location,
            color: kpurple[800],
          ),
        ),
        fillColor: kwhite,
        filled: true,
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone = int.tryParse(newValue!)!,
      onChanged: (value) {
        setState(() {
          if (value.isNotEmpty && value.length == 10) {
            removeError(error: kPhoneNumberNullError);
          }
          phone = int.tryParse(value)!;
        });
      },
      validator: (value) {
        setState(() {
          if (value!.isEmpty || value.length < 10 || value.length > 10) {
            addError(error: kPhoneNumberNullError);
            return;
          }
          return null;
        });
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Icons.call,
            color: kpurple[800],
          ),
        ),
        fillColor: kwhite,
        filled: true,
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      onSaved: (newValue) => name = newValue!,
      onChanged: (value) {
        setState(() {
          if (value.isNotEmpty) {
            removeError(error: kNamelNullError);
          }
          name = value;
        });
      },
      validator: (value) {
        setState(() {
          if (value!.isEmpty) {
            addError(error: kNamelNullError);
            return;
          }
          return null;
        });
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your name",
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Icons.person_rounded,
            color: kpurple[800],
          ),
        ),
        fillColor: kwhite,
        filled: true,
      ),
    );
  }
}
