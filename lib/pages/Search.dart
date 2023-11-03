import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required arguments}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left: 10),
          height: ScreenAdapter.height(56),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '请输入搜索内容',
              hintStyle: TextStyle(fontSize: ScreenAdapter.size(28)),
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              // 搜索
            },
            child: Container(
              height: ScreenAdapter.height(68),
              width: ScreenAdapter.width(80),
              child: Row(
                children: [Text("搜索")],
              ),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text('Search Page'),
      ),
    );
  }
}
