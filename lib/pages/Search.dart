import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required arguments}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keywords = "";

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
            onChanged: (value) {
              setState(() {
                keywords = value;
              });
            },
            // textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            const Text("热搜", style: TextStyle(fontSize: 20)),
            const Divider(),
            Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("女装"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("女装"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("笔记本电脑"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("女装111"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("女装"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("女装"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("女装"),
                )
              ],
            ),
            SizedBox(height: 10),
            Container(
              child: Text("历史记录", style: TextStyle(fontSize: 20)),
            ),
            Divider(),
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("女装"),
                ),
                Divider(),
                ListTile(
                  title: Text("女装"),
                ),
                Divider(),
                ListTile(
                  title: Text("男装"),
                ),
                Divider(),
                ListTile(
                  title: Text("手机"),
                ),
                Divider(),
                ListTile(
                  title: Text("鞋子"),
                ),
                Divider(),
              ],
            ),
            SizedBox(height: 100),
            InkWell(
              onTap: () {},
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
            )
          ],
        ),
      ),
    );
  }
}
