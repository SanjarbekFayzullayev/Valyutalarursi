import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valyutalarkursi/main_provider.dart';
import 'package:valyutalarkursi/screens/home_page.dart';
import 'package:valyutalarkursi/screens/onboarding_screen.dart';

void main() {
  runApp( MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => MainProvider(),
    ),
  ], child:  const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences loginData;
  late bool newUser=true;
@override
  void initState() {
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
  mainProvider.getInt();
  mainProvider.getInt2();
  getBool();
  // TODO: implement initState
    super.initState();
  }
  void getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value2 = prefs.getBool("login") ?? true;
setState(() {
  newUser = value2;
});

  }

  @override
  Widget build(BuildContext context) {
    // print(newUser);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      color: Colors.black,
      home: newUser ==false ? const HomePage():const OnBoardingScreen(),
    );
  }


}
