import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valyutalarkursi/main_provider.dart';

class ProductItem extends StatefulWidget {
  final String code;
  final String title;
  final String cb_price;
  final String diff;
  int card;
  int card2;
  int index;

  ProductItem(this.code, this.title, this.cb_price, this.card, this.card2,
      this.index, this.diff,
      {Key? key})
      : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late SharedPreferences loginData;
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    List<String> a = selectedDate.toString().split(" ");
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              datePickerTheme: const DatePickerThemeData(
                backgroundColor: Color(0xFF100B07),
                yearStyle: TextStyle(color: Colors.amber),
              ),
              colorScheme: const ColorScheme.dark(
                surface: Colors.black,
                onBackground: Colors.amber,
                onSecondary: Colors.amber,
                background: Colors.amber,
                primary: Colors.amber,
                // header background color
                onPrimary: Colors.black,
                // header text color
                onSurface: Colors.amber, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.amber, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        List<String> b = selectedDate.toString().split(" ");
        mainProvider.selectedDate = b[0];

        mainProvider.refresh();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Consumer(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: InkWell(
            onTap: () => selectDate(context),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.code,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        widget.title,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 10),
                      )
                    ],
                  ),
                ),
                widget.diff.startsWith("-")
                    ? Image.asset("assets/images/outgraph.png")
                    : Image.asset("assets/images/graph.png"),
                const SizedBox(
                  width: 6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${widget.cb_price} so'm",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () async {
                              final mainProvider = Provider.of<MainProvider>(
                                  context,
                                  listen: false);
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              if (mainProvider.card == 23) {
                                prefs.setInt("view", widget.index);
                                mainProvider.getInt();
                                mainProvider.refresh();
                              } else if (mainProvider.card2 == 8) {
                                prefs.setInt("view2", widget.index);
                                mainProvider.getInt2();
                                mainProvider.refresh();
                              } else if (mainProvider.card2 != 8 &&
                                  mainProvider.card != 23) {
                                mainProvider.getClear();
                                print(mainProvider.card2);
                              }
                            },
                            icon: Icon(
                              widget.index == mainProvider.card ||
                                      widget.index == mainProvider.card2
                                  ? CupertinoIcons.pin_fill
                                  : CupertinoIcons.pin,
                              color: Colors.amber,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          mainProvider.selectedDate ??
                              "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                          style: TextStyle(
                              color: widget.diff.startsWith("-")
                                  ? Colors.red
                                  : Colors.green),
                        ),
                        widget.diff.startsWith("-")
                            ? Text(
                                " (${widget.diff})",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.redAccent),
                              )
                            : Text(
                                " (+${widget.diff})",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.greenAccent),
                              ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
