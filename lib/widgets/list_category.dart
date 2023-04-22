import 'package:flutter/material.dart';
import 'package:novel_app/screens/story_screen.dart';

import '../services/api_call.dart';

class ListCategory extends StatefulWidget {
  const ListCategory({Key? key}) : super(key: key);

  @override
  State<ListCategory> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  final APICall apiCall = APICall();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: apiCall.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listCategory = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: listCategory.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 64.0,
                ),
                itemBuilder: (BuildContext context, int i) {
                  return Card(
                    elevation: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                      ),
                      child: TextButton(
                        child: Center(
                          child: Text(
                            listCategory[i].name,
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.black87),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => StoryScreen(
                                category: listCategory[i],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return Container();
        },
      ),
    );
  }
}
