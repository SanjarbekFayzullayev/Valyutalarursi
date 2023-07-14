import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valyutalarkursi/main_provider.dart';
class Cards extends StatefulWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
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
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => selectDate(context),
        child: Container(
            height: size.height*0.08,
            width: size.width,
            decoration: BoxDecoration(image: const DecorationImage(image:  AssetImage("assets/images/cardBg.png"),
                fit: BoxFit.cover),

              borderRadius: BorderRadius.circular(10)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_month,color: Colors.amber),
                 SizedBox(
                  width: 8,
                ),
                Text("Valyuta tarixi",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)
              ],
            )),
      ),
    );
  }
}







