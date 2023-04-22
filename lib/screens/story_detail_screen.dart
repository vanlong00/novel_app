import 'package:flutter/material.dart';
import 'package:novel_app/services/api_call.dart';

import 'chapter_detail_screen.dart';

class StoryDetailScreen extends StatefulWidget {
  const StoryDetailScreen({Key? key, required this.story}) : super(key: key);

  final dynamic story;

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  final APICall apiCall = APICall();
  List<dynamic>? chapters;

  void loadData() {
    apiCall.getChapterByStory(widget.story.slug).then((value) {
      setState(() {
        chapters = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
                color: Colors.blue,
                iconSize: 32.0,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0)),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Đọc truyện',
                    style: TextStyle(fontSize: 22.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Image.network(widget.story.poster),
                  buildSpace(),
                  Text(
                    widget.story.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            buildSpacePart(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Các số mới nhất',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                Text(
                  'xem toàn bộ',
                  style: TextStyle(fontSize: 12.0, color: Colors.blue),
                ),
              ],
            ),
            chapters == null
                ? const CircularProgressIndicator()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChapterDetailScreen(
                                idChapter: chapters![index].id,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                title: Text(
                                  chapters![index].header,
                                  style: const TextStyle(fontSize: 16.0),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            buildSpace(),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  SizedBox buildSpacePart() => const SizedBox(height: 16.0);

  SizedBox buildSpace() => const SizedBox(height: 8.0);
}
