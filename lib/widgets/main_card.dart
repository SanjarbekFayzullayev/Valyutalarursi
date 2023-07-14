import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valyutalarkursi/main_provider.dart';

class MainCard extends StatefulWidget {
  final String moneyName;
  final String moneyLoongName;
  final String money;
  final String diff;
  

  const MainCard(this.moneyName, this.moneyLoongName, this.money, this.diff,{Key? key})
      : super(key: key);

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
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
                yearStyle: TextStyle(color: Colors.amber),),
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
        List<String> b=selectedDate.toString().split(" ");
        mainProvider.selectedDate = b[0];

        mainProvider.refresh();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Consumer<MainProvider>(
      builder: (context, value, child) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => selectDate(context),
              child: Container(
                height: size.height * 0.3,
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage("assets/images/cardBg.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.amber,
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.moneyName,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              Text(widget.moneyLoongName,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(widget.money,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18)),
                    Center(
                        child: Image.asset(widget.diff.startsWith("-")
                            ? "assets/images/OutCardGraph.png"
                            : "assets/images/CardGraph.png")),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(mainProvider.selectedDate??
                            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                            style: TextStyle(
                                color: widget.diff.startsWith("-") ? Colors.red : Colors.green),
                          ),
                          widget.diff.startsWith("-")
                              ? Text(
                            " (${widget.diff})",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.redAccent),
                          )
                              : Text(
                            " (+${widget.diff})",
                            style:
                            const TextStyle(fontSize: 14, color: Colors.greenAccent),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
