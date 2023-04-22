import 'package:flutter/material.dart';
import 'package:novel_app/widgets/list_category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trang chủ'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Cập nhật'),
              Tab(text: 'Danh mục'),
              Tab(text: 'Đã full'),
              Tab(text: 'Sáng tác'),
            ],
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(),
            const ListCategory(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
