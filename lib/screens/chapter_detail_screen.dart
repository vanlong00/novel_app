import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../services/api_call.dart';

const List<String> listFontFamily = <String>[
  'Roboto',
  'DancingScript',
  'RobotoSlab'
];

class ChapterDetailScreen extends StatefulWidget {
  const ChapterDetailScreen({Key? key, required this.idChapter})
      : super(key: key);

  final int idChapter;

  @override
  State<ChapterDetailScreen> createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  final APICall apiCall = APICall();
  double _fontSize = 14.0;
  bool _isDarkMode = false;

  String _fontFamily = listFontFamily.first;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: const Text("A",
                                style: TextStyle(fontSize: 16.0)),
                            onPressed: () => setState(() => _fontSize = 16.0),
                          ),
                          TextButton(
                            child: const Text("A",
                                style: TextStyle(fontSize: 22.0)),
                            onPressed: () => setState(() => _fontSize = 22.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: const Text("Light"),
                            onPressed: () =>
                                setState(() => _isDarkMode = false),
                          ),
                          TextButton(
                            child: const Text("Dark"),
                            onPressed: () => setState(() => _isDarkMode = true),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.,
                    children: [
                      const Text('Font'),
                      DropdownButton<String>(
                        value: _fontFamily,
                        icon: const Icon(Icons.arrow_forward_ios),
                        elevation: 16,
                        underline: Container(
                          height: 1,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _fontFamily = value!;
                          });
                        },
                        items: listFontFamily
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        body: FutureBuilder<dynamic>(
          future: apiCall.getDetailChapter(widget.idChapter),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final chapter = snapshot.data;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        chapter.header,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: _fontSize,
                          fontFamily: _fontFamily,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Html(
                        data: chapter.body[0],
                        style: {
                          "p": Style(
                            textAlign: TextAlign.justify,
                            fontSize: FontSize(_fontSize),
                            fontFamily: _fontFamily,
                          ),
                        },
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
              return Container();
          },
        ),
      ),
    );
  }
}
