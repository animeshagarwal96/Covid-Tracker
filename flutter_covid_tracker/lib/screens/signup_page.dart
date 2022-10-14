import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker/widgets/url.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter_covid_tracker/widgets/shared.dart';
import 'package:flutter_covid_tracker/widgets/theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formkey = GlobalKey<FormState>();

  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _userName;
  late TextEditingController _password;
  RxBool isTap = false.obs;

  void formValidate() {
    if (_formkey.currentState!.validate()) {
      context.vxNav.clearAndPush(Uri.parse(MyUrl.homePage));
    }
  }

  @override
  void initState() {
    _firstName = TextEditingController(text: "");
    _lastName = TextEditingController(text: "");
    _userName = TextEditingController(text: "");
    _password = TextEditingController(text: "");

    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _userName.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            const AccountHeader(),
            30.heightBox,
            FormField(
              formkey: _formkey,
              firstName: _firstName,
              lastName: _lastName,
              userName: _userName,
              password: _password,
            ),
            50.heightBox,
            Obx(() => isTap.value
                ? const CircularProgressIndicator()
                : Material(
                    color: MyTheme.themeColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: InkWell(
                      onTap: () => formValidate(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        alignment: Alignment.center,
                        child: "Submit".text.white.bold.make(),
                      ),
                    ),
                  )),
          ],
        ).px32(),
      ),
    )));
  }
}

class FormField extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController userName;
  final TextEditingController password;
  const FormField({
    Key? key,
    required this.formkey,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          controller: firstName,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "First Name",
            floatingLabelStyle:
                TextStyle(color: MyTheme.themeColor, fontSize: 20.0),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: MyTheme.themeColor),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: MyTheme.themeColor, width: 2.0)),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Enter your first name please";
            } else if (value.contains(RegExp(r'[1-9]'))) {
              return "First name cannot contain numbers";
            }
            Constants.prefs.setString("firstName", value);
            return null;
          },
        ).py16(),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: lastName,
          decoration: InputDecoration(
            labelText: "Last Name",
            floatingLabelStyle:
                TextStyle(color: MyTheme.themeColor, fontSize: 20.0),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: MyTheme.themeColor),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: MyTheme.themeColor, width: 2.0)),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Enter your last name please";
            } else if (value.contains(RegExp(r'[1-9]'))) {
              return "Last name cannot contain number";
            }
            Constants.prefs.setString("lastName", value);
            return null;
          },
        ).py16(),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: userName,
          decoration: InputDecoration(
            labelText: "User Name",
            floatingLabelStyle:
                TextStyle(color: MyTheme.themeColor, fontSize: 20.0),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: MyTheme.themeColor),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: MyTheme.themeColor, width: 2.0)),
          ),
          validator: (value) {
            if (value!.length < 6) {
              return "User name must contain atleast 6 letter";
            }
            Constants.prefs.setString("userName", value);
            return null;
          },
        ).py16(),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            floatingLabelStyle:
                TextStyle(color: MyTheme.themeColor, fontSize: 20.0),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: MyTheme.themeColor),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: MyTheme.themeColor, width: 2.0)),
          ),
          validator: (value) {
            if (value!.length < 6) {
              return "Password length should be atleast 6";
            }
            Constants.prefs.setString("password", value);
            return null;
          },
        ).py16(),
      ],
    );
  }
}

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        "Account Details".text.xl2.bold.center.make().p16().pOnly(top: 64.0),
        "Enter details to Sign-up"
            .text
            .center
            .letterSpacing(1)
            .xl
            .make()
            .px12()
            .w(MediaQuery.of(context).size.width / 2 + 50),
      ],
    ).px16().centered();
  }
}
