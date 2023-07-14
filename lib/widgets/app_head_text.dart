import 'package:flutter/material.dart';

class AppHeadText extends StatefulWidget {
  String money;
  String moneyName;
  String ccy;

  AppHeadText(this.money, this.moneyName, this.ccy, {Key? key})
      : super(key: key);

  @override
  State<AppHeadText> createState() => _AppHeadTextState();
}

class _AppHeadTextState extends State<AppHeadText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.moneyName,
            style: const TextStyle(fontSize: 16, color: Colors.grey)),
        const SizedBox(
          height: 18,
        ),
        Row(
          children: [
            const Text("1 ",
                style: const TextStyle(fontSize: 26, color: Colors.white)),
            Text(
              widget.ccy,
              style: const TextStyle(color: Colors.white, fontSize: 26),
            ),
            const Text(" = ",
                style: TextStyle(fontSize: 26, color: Colors.white)),
            Text(widget.money,
                style: const TextStyle(fontSize: 26, color: Colors.white)),
            const Text(
              " so'm",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
