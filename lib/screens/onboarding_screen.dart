import 'package:flutter/material.dart';
import 'package:valyutalarkursi/model/onboardin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valyutalarkursi/screens/home_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  PageController _pageController = PageController();
  late SharedPreferences loginData;
  late bool newUser;

  @override
  void initState() {
    checkLogin();
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Onboarding.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemCount: model.length,
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.all(34),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(model[currentIndex].image),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(model[currentIndex].name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                                Text(model[currentIndex].description,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    model.length,
                    (index) => builder(context, index),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (currentIndex == model.length - 1) {
                      loginData.setBool("login", false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear);
                  },
                  child: Container(
                      margin: const EdgeInsets.all(30),
                      child: Image.asset("assets/images/btn.png")),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget builder(BuildContext context, int index) {
    return Container(
      height: 10,
      width: currentIndex == index ? 50 : 10,
      margin: const EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: currentIndex == index ? Colors.white : Colors.grey),
    );
  }

  void checkLogin() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool("login") ?? true);
    if (newUser == false) {
      // ignore: use_build_context_synchronously
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const HomePage(),
      //     ));
    }
  }
}
