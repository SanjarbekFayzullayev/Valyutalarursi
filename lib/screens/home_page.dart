import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valyutalarkursi/main_provider.dart';
import 'package:valyutalarkursi/model/data_model.dart';
import 'package:valyutalarkursi/widgets/Card.dart';
import 'package:valyutalarkursi/widgets/app_head_text.dart';
import 'package:valyutalarkursi/widgets/lits_item.dart';
import 'package:valyutalarkursi/widgets/main_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.getRequestHttp();
    super.initState();
  }

  String? date1;



  int selectedIndex = 0;
  dynamic rng = Random();
  dynamic rng2 = Random();
  String? date;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      body: Consumer<MainProvider>(
        builder: (context, value, child) {
          return FutureBuilder(
            future: mainProvider.getRequestHttp(),
            builder: (context, AsyncSnapshot<List<DataModel>> snapshot) {
              if (!snapshot.hasData) {

                return Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(CupertinoIcons.wifi_slash,
                                color: Colors.amber, size: 120),
                            OutlinedButton(
                                style: const ButtonStyle(
                                    side: MaterialStatePropertyAll(
                                        BorderSide(color: Colors.amber)),
                                    overlayColor: MaterialStatePropertyAll(
                                        Colors.white10)),
                                onPressed: () {
                                  mainProvider.refresh();
                                },
                                child: const Text(
                                  "Takrorlash",
                                  style: TextStyle(color: Colors.amber),
                                ))
                          ]),
                    ));
              }
              return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bgmain.png"),
                        fit: BoxFit.cover)),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppHeadText(
                          snapshot.data![mainProvider.card].Rate.toString(),
                          snapshot.data![mainProvider.card].CcyNm_UZ.toString(),
                          snapshot.data![mainProvider.card].Ccy.toString(),
                        ),

                        const Cards(),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Tanlangan Valyutalar",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MainCard(
                                  snapshot.data![mainProvider.card].Ccy
                                      .toString(),
                                  snapshot.data![mainProvider.card].CcyNm_UZ
                                      .toString(),
                                  "${snapshot.data![mainProvider.card].Rate.toString()} so'm",
                                  snapshot.data![mainProvider.card].Diff
                                      .toString()),
                              MainCard(
                                  snapshot.data![mainProvider.card2].Ccy
                                      .toString(),
                                  snapshot.data![mainProvider.card2].CcyNm_UZ
                                      .toString(),
                                  "${snapshot.data![mainProvider.card2].Rate.toString()} so'm",
                                  snapshot.data![mainProvider.card2].Diff
                                      .toString()),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ProductItem(
                                  snapshot.data![index].Ccy ?? "...",
                                  snapshot.data![index].CcyNm_UZ ?? "...",
                                  snapshot.data![index].Rate ?? "...",
                                  mainProvider.card,
                                  mainProvider.card2,
                                  index,
                                  snapshot.data![index].Diff.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
