import 'package:flutter/material.dart';
import 'package:novel_app/screens/home_screen.dart';
import 'package:novel_app/services/api_call.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // theme:  ThemeData(scaffoldBackgroundColor: Colors.white),
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleTextStyle: TextStyle(color: Colors.blue, fontSize: 22.0),
          iconTheme: IconThemeData(color: Colors.blue)
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          elevation: 0.0,
          height: 75.0,
          padding: EdgeInsets.all(8.0),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black26,
          labelStyle: TextStyle(fontSize: 18.0),
          unselectedLabelStyle: TextStyle(fontSize: 18.0),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final APICall apiCall = APICall();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: apiCall.getCategories(),
        builder: (context, snapshot) {
          // print("snapshot");
          // print(snapshot.data);
          if (snapshot.hasData) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (BuildContext context, int i) {
                      return Card(
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  snapshot.data![i].name,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
