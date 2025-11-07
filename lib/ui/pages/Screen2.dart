import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget{

  @override
  State<Screen2> createState() => _StateScreen1();

}

class _StateScreen1 extends State<Screen2> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(text),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: () async {
              Navigator.pop(context, "Mày đã lấy được dữ liệu");
            }, child: Text("Bấm mẹ mày đi"))
          ],
        ),
      ),
    );
  }
}