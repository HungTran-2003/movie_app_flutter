
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget{

  @override
  State<Screen1> createState() => _StateScreen1();

}

class _StateScreen1 extends State<Screen1> {
  String text ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(text),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: () async {
              final result = await Navigator.pushNamed(
                context,
                "/screen2",
              );
              if (result != null) {
                setState(() {
                  text = result.toString();
                });
              }
            }, child: Text("Bấm mẹ mày đi"))
          ],
        ),
      ),
    );
  }

}