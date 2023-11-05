import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

import '../services/SearchServices.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required arguments}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keywords = "";

  // 获取热门搜索数据

  // 获取历史记录数据
  List _historyListData = [];

  _getHistoryListData() async {
    var _historyList = await SearchServices.getHistoryList();
    setState(() {
      _historyListData = _historyList;
    });
  }

  @override
  void initState() {
    super.initState();
    _getHistoryListData();
  }

  // 长按删除
  _alertDialog(keywords) async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("提示信息!"),
            content: const Text("您确定要删除吗?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, "Cancle");
                },
                child: const Text(
                  "取消",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              TextButton(
                onPressed: () async {
                  // 删除
                  await SearchServices.removeHistoryData(keywords);
                  _getHistoryListData();
                  Navigator.pop(context, "Ok");
                },
                child: const Text(
                  "确定",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          );
        });
  }

  Widget _historyListWidget() {
    if (_historyListData.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("历史记录", style: TextStyle(fontSize: 20)),
          const Divider(),
          Column(
            children: _historyListData.map((value) {
              return Column(
                children: [
                  ListTile(
                      title: Text("${value}"),
                      onLongPress: () {
                        // 长按删除
                        _alertDialog(value);
                      },
                      onTap: () {
                        // 搜索,跳转到商品列表传递参数(替换)
                        Navigator.pushReplacementNamed(context, '/productList',
                            arguments: {"keywords": value});
                      }),
                  const Divider()
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // 清空历史记录
                  SearchServices.clearHistoryList();
                  _getHistoryListData();
                },
                child: Container(
                  width: ScreenAdapter.width(400),
                  height: ScreenAdapter.height(64),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 1)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.delete), Text("清空历史记录")],
                  ),
                ),
              ),
            ],
          )
        ],
      );
    } else {
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left: 10),
          height: ScreenAdapter.height(56),
          decoration: BoxDecoration(
            // color: const Color.fromRGBO(233, 233, 233, 0.8),
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextField(
            autofocus: true,
            onChanged: (value) {
              setState(() {
                keywords = value;
              });
            },
            // textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: '请输入搜索内容',
              contentPadding: EdgeInsets.all(0),
              hintStyle: TextStyle(fontSize: ScreenAdapter.size(28)),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              // 保存搜索记录
              SearchServices.setHistoryData(keywords);
              // 搜索,跳转到商品列表传递参数(替换)
              Navigator.pushReplacementNamed(context, '/productList',
                  arguments: {"keywords": keywords});
            },
            child: SizedBox(
              height: ScreenAdapter.height(68),
              width: ScreenAdapter.width(80),
              child: const Row(
                children: [
                  Text(
                    "搜索",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            const Text("热搜", style: TextStyle(fontSize: 20)),
            const Divider(),
            Wrap(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("女装"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("女装"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("笔记本电脑"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("女装111"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("女装"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("女装"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("女装"),
                )
              ],
            ),
            const SizedBox(height: 10),
            _historyListWidget(),
          ],
        ),
      ),
    );
  }
}
