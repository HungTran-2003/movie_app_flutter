import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/widgets/app_bar/app_bar_widget.dart';

class Screen2 extends StatefulWidget{

  @override
  State<Screen2> createState() => _StateScreen1();

}

class _StateScreen1 extends State<Screen2> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Detail",
        onPressed: (){
          Navigator.pop(context);
        },
        actions: [
          IconButton(onPressed: (){
            print("Bookmark");
          }, icon: Icon(Icons.bookmark, size: 24,color: Colors.white,))
        ],
      ),
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