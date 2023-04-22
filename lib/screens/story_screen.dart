import 'package:flutter/material.dart';
import 'package:novel_app/screens/story_detail_screen.dart';
import 'package:novel_app/services/api_call.dart';
import 'package:intl/intl.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key, required this.category}) : super(key: key);

  final dynamic category;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final APICall apiCall = APICall();
  late List<dynamic> listStory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: apiCall.getStoryByCategory(widget.category.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listStory = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: listStory.length,
                      (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => StoryDetailScreen(
                                  story: listStory[index],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 0.0,
                            child: Container(
                              height: 150.0,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Row(
                                children: [
                                  // Picture on the left
                                  Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            listStory[index].poster),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Information on the right
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          buildHeader(listStory[index].title),
                                          buildSpace(),
                                          // Author
                                          buildInfo(listStory[index].author),
                                          buildSpace(),
                                          buildInfo(listStory[index].status),
                                          buildSpace(),
                                          buildInfo(
                                            DateFormat('hh:mm:ss dd/mm/yyyy')
                                                .format(
                                              DateTime.parse(
                                                  listStory[index].updatedDate),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
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

  Text buildInfo(String info) {
    return Text(
      info,
      style: const TextStyle(
        fontSize: 10,
        color: Colors.black54,
      ),
    );
  }

  SizedBox buildSpace() => const SizedBox(height: 8);

  Text buildHeader(String header) {
    return Text(
      header,
      style: const TextStyle(fontSize: 16),
      maxLines: null,
    );
  }
}
