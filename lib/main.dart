


import 'package:flutter/material.dart';
import 'package:movie_app/service/movie_service.dart';
import 'package:movie_app/ui/pages/Screen1.dart';
import 'package:movie_app/ui/pages/Screen2.dart';

void main() async{

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "hello",
      initialRoute: "/",
      routes: {
        '/': (BuildContext context) => Screen1(),
        '/screen2': (BuildContext context) => Screen2(),
      },
    );
  }
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _StateHomePage();
}

class _StateHomePage extends State<HomePage> {
  String json = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
            
              children: [
                Text(json),
            
                SizedBox(height: 30,),
            
                ElevatedButton(onPressed: () async {
                  final result = await MovieService().fetchPopularMovies();
                  setState(() {
                    json = result;
                  });
                }, child: Text("GetData"))
              ],
            ),
          ),
        ),
    );
  }
}

