import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/model/CateModel.dart';

import '../../services/ScreenAdapter.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;

  // 左侧数据
  List _leftCateData = [];

  // 右侧数据
  List _rightCateData = [];

  // 状态保持
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // 左侧数据
    _getLeftCateData();
  }

  // 获取左侧数据
  _getLeftCateData() async {
    var api = "${Config.domain}api/pcate";
    var result = await Dio().get(api);
    var leftCateList = CateModel.fromJson(result.data);
    setState(() {
      _leftCateData = leftCateList.result;
    });

    // 请求右侧数据
    _getRightCateData(leftCateList.result[0].id);
  }

  // 左侧侧栏
  Widget _leftCateWidget(leftWidth) {
    if (_leftCateData.isNotEmpty) {
      return SizedBox(
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
                      _getRightCateData(_leftCateData[index].id);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: ScreenAdapter.height(84),
                    padding: EdgeInsets.only(top: ScreenAdapter.height(30)),
                    color: _selectIndex == index
                        ? const Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                    child: Text(
                      "${_leftCateData[index].title}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
              ],
            );
          },
          itemCount: _leftCateData.length,
        ),
      );
    } else {
      return SizedBox(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

  // 获取右侧分类数据
  _getRightCateData(id) async {
    var api = "${Config.domain}api/pcate?pid=${id}";
    var result = await Dio().get(api);
    var rightCateList = CateModel.fromJson(result.data);
    setState(() {
      _rightCateData = rightCateList.result;
    });
  }

  Widget _rightCateWidget(rightItemWdith, rightItemHeight) {
    if (_rightCateData.isNotEmpty) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          color: const Color.fromRGBO(240, 246, 246, 0.9),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: rightItemWdith / rightItemHeight,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              // 图片转换格式
              String pic = _rightCateData[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return InkWell(
                onTap: () {
                  // 跳转到商品列表页面
                  Navigator.pushNamed(context, '/productList',
                      arguments: {"cid": _rightCateData[index].id});
                },
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network(
                        pic,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: ScreenAdapter.height(28),
                      child: Text("${_rightCateData[index].title}"),
                    )
                  ],
                ),
              );
            },
            itemCount: _rightCateData.length,
          ),
        ),
      );
    } else {
      return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          color: const Color.fromRGBO(240, 246, 246, 0.9),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 初始化屏幕适配
    ScreenAdapter.init(context);

    // 计算GridView 宽高比
    var leftWidth = ScreenAdapter.getScreenWidth() / 4;
    var rightItemWidth =
        (ScreenAdapter.getScreenWidth() - leftWidth - 20 - 20) / 3;
    rightItemWidth = ScreenAdapter.width(rightItemWidth);
    var rightItemHeight = rightItemWidth + ScreenAdapter.height(28);

    return Scaffold(
      body: Row(
        children: [
          _leftCateWidget(leftWidth),
          _rightCateWidget(rightItemWidth, rightItemHeight)
        ],
      ),
    );
  }
}
