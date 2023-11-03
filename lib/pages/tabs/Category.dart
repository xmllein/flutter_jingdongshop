import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/Config.dart';

import '../../services/ScreenAdaper.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 初始化屏幕适配
    ScreenAdaper.init(context);

    // 计算GridView 宽高比
    var leftWidth = ScreenAdaper.getScreenWidth() / 4;
    var rightItemWdith =
        (ScreenAdaper.getScreenWidth() - leftWidth - 20 - 20) / 3;
    rightItemWdith = ScreenAdaper.width(rightItemWdith);
    var rightItemHeight = rightItemWdith + ScreenAdaper.height(28);

    return Scaffold(
      body: Row(
        children: [
          Container(
              width: leftWidth,
              height: double.infinity,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectIndex = index;
                          });
                        },
                        child: Container(
                          child: Text(
                            "第${index}条",
                            textAlign: TextAlign.center,
                          ),
                          width: double.infinity,
                          height: ScreenAdaper.height(56),
                          color:
                              _selectIndex == index ? Colors.red : Colors.white,
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
                itemCount: 28,
              )),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              height: double.infinity,
              color: Color.fromRGBO(240, 246, 246, 0.9),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: rightItemWdith / rightItemHeight,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(
                            "https://www.itying.com/images/flutter/list8.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          child: Text("女装"),
                          height: ScreenAdaper.height(28),
                        )
                      ],
                    ),
                  );
                },
                itemCount: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
