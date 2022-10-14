import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker/widgets/shared.dart';
import 'package:flutter_covid_tracker/widgets/theme.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstName = Constants.prefs.getString("firstName") ?? "Animesh";
  String lastName = Constants.prefs.getString("lastName") ?? "Agarwal";
  String userName = Constants.prefs.getString("userName") ?? "Animesh";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: true,
          backgroundColor: MyTheme.themeColor,
          title: "Profile".text.letterSpacing(1).make(),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              FittedBox(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Hero(
                        tag: const Key("profile"),
                        child: CircleAvatar(
                          backgroundImage: const NetworkImage(
                              "https://chopdoc.com/wp-content/uploads/2019/04/mn2.jpg"),
                          radius: MediaQuery.of(context).size.height * 0.055,
                        ).pOnly(right: 16),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "$firstName $lastName"
                            .text
                            .textStyle(TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.050))
                            .bold
                            .make()
                            .w((MediaQuery.of(context).size.width * 0.6) - 6),
                        "@$userName".text.letterSpacing(1).make().py2(),
                      ],
                    )
                  ],
                ).pOnly(bottom: 12),
              ),
              50.heightBox,
              FirstName(firstName: firstName),
              25.heightBox,
              LastName(lastName: lastName),
              25.heightBox,
              UserName(userName: userName),
              25.heightBox,
            ],
          ).p20(),
        ));
  }
}

class FirstName extends StatelessWidget {
  const FirstName({
    Key? key,
    required this.firstName,
  }) : super(key: key);

  final String firstName;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: firstName,
      readOnly: true,
      decoration: InputDecoration(
          labelText: "First Name",
          floatingLabelStyle:
              TextStyle(fontSize: 21, color: MyTheme.themeColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyTheme.themeColor))),
    );
  }
}

class LastName extends StatelessWidget {
  const LastName({
    Key? key,
    required this.lastName,
  }) : super(key: key);

  final String lastName;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: lastName,
      readOnly: true,
      decoration: InputDecoration(
          labelText: "Last Name",
          floatingLabelStyle:
              TextStyle(fontSize: 21, color: MyTheme.themeColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyTheme.themeColor))),
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({
    Key? key,
    required this.userName,
  }) : super(key: key);

  final String userName;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: userName,
      readOnly: true,
      decoration: InputDecoration(
          labelText: "Last Name",
          floatingLabelStyle:
              TextStyle(fontSize: 21, color: MyTheme.themeColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyTheme.themeColor))),
    );
  }
}
