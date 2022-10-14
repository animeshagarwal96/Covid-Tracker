import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter_covid_tracker/widgets/api.dart';
import 'package:flutter_covid_tracker/widgets/shared.dart';
import 'package:flutter_covid_tracker/widgets/theme.dart';
import 'package:flutter_covid_tracker/widgets/url.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String firstName = Constants.prefs.getString("firstName") ?? "Animesh";
  String userName = Constants.prefs.getString("userName") ?? "Animesh";
  List<dynamic> report = [];
  bool isLoaded = false;

  void goToProfilePage() {
    context.vxNav.push(Uri.parse(MyUrl.profilePage));
  }

  void logout() {
    Constants.prefs.clear();
    context.vxNav.clearAndPush(Uri.parse(MyUrl.signUpPage));
  }

  void getReport() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      final http.Response response = await Api.getCovidReport();
      if (response.statusCode == 200) {
        final List<dynamic> detail = jsonDecode(response.body);
        report.addAll(detail);
        setState(() {
          isLoaded = true;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: "Network error occur".text.letterSpacing(1).make()));
    }
  }

  @override
  void initState() {
    getReport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: MyTheme.themeColor,
        title: "Covid-19 Track".text.letterSpacing(1).make(),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://chopdoc.com/wp-content/uploads/2019/04/mn2.jpg")),
              accountName: firstName.text.letterSpacing(1).make(),
              accountEmail: "@$userName".text.bold.letterSpacing(1).make(),
            ),
            InkWell(
              onTap: () => goToProfilePage(),
              child: ListTile(
                  leading: const Icon(FontAwesomeIcons.user),
                  title: "Profile".text.xl.letterSpacing(1).make()),
            ),
            InkWell(
              onTap: () => logout(),
              child: ListTile(
                leading: const Icon(FontAwesomeIcons.arrowRightFromBracket),
                title: "Logout".text.xl.letterSpacing(1).make(),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: isLoaded == false
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: report.length,
                itemBuilder: (context, index) {
                  return CovidCard(
                    detail: report[index],
                  ).p12();
                },
              ),
      ),
    );
  }
}

class CovidCard extends StatelessWidget {
  final Map<String, dynamic> detail;
  const CovidCard({
    Key? key,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DateFormat.yMMMMEEEEd()
                .format(DateTime.parse(detail['dateChecked']))
                .text
                .gray500
                .textStyle(context.captionStyle)
                .bold
                .letterSpacing(1)
                .make()
                .p12(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    "Postive"
                        .text
                        .xl
                        .bold
                        .letterSpacing(1)
                        .make()
                        .pOnly(top: 4, bottom: 8, left: 4, right: 4),
                    Row(children: [
                      "${detail['positiveIncrease']}"
                          .text
                          .sm
                          .bold
                          .color(Colors.blue)
                          .letterSpacing(1)
                          .make(),
                      const Icon(
                        Icons.arrow_upward,
                        color: Colors.blue,
                      )
                    ]),
                    "${detail['positive']}"
                        .text
                        .semiBold
                        .letterSpacing(1)
                        .make()
                        .p4(),
                  ],
                ),
                Column(
                  children: [
                    "Death"
                        .text
                        .xl
                        .bold
                        .letterSpacing(1)
                        .make()
                        .pOnly(top: 4, bottom: 8, left: 4, right: 4),
                    Row(children: [
                      "${detail['deathIncrease']}"
                          .text
                          .sm
                          .bold
                          .color(Colors.red)
                          .letterSpacing(1)
                          .make(),
                      const Icon(
                        Icons.arrow_upward,
                        color: Colors.red,
                      )
                    ]),
                    "${detail['death']}"
                        .text
                        .semiBold
                        .letterSpacing(1)
                        .make()
                        .p4(),
                  ],
                ),
                Column(
                  children: [
                    "Criticle"
                        .text
                        .xl
                        .bold
                        .letterSpacing(1)
                        .make()
                        .pOnly(top: 4, bottom: 8, left: 4, right: 4),
                    Row(children: [
                      "${detail['inIcuCurrently']}"
                          .text
                          .sm
                          .bold
                          .color(Colors.orange)
                          .letterSpacing(1)
                          .make(),
                      const Icon(
                        Icons.arrow_upward,
                        color: Colors.orange,
                      )
                    ]),
                    "${detail['inIcuCumulative']}"
                        .text
                        .semiBold
                        .letterSpacing(1)
                        .make()
                        .p4(),
                  ],
                ),
              ],
            ).p8(),
          ],
        )));
  }
}
