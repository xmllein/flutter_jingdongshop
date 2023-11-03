import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/model/ProductModel.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import '../../services/ScreenAdaper.dart';

// 轮播数据模型
import '../../model/FocusModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  // 轮播数据
  List _focusData = [];

  // 猜你喜欢数据
  List _hotProductData = [];

  // 获取热门推荐商品
  List _bestProductData = [];

  // 状态保持
  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
    // 获取轮播图数据
    _getFocusData();
    // 获取猜你喜欢数据
    _getHotProductData();
    // 获取热门推荐商品
    _getBestProductData();
  }

  // 获取轮播数据
  _getFocusData() async {
    var api = '${Config.domain}api/focus';
    var result = await Dio().get(api);
    var focusList = FocusModel.fromJson(result.data);
    setState(() {
      _focusData = focusList.result;
    });
  }

  // 轮播组件
  Widget _swiperBuilder() {
    if (_focusData.isNotEmpty) {
      return AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            // 图片转换格式
            String pic = _focusData[index].pic;
            pic = Config.domain + pic.replaceAll('\\', '/');
            return Image.network(
              pic,
              fit: BoxFit.fill,
            );
          },
          autoplay: true,
          itemCount: _focusData.length,
          pagination: const SwiperPagination(),
          // control: const SwiperControl(),
        ),
      );
    } else {
      return const Text('加载中...');
    }
  }

  // 标题组件
  Widget _titleBuilder(String title) {
    return Container(
      height: ScreenAdaper.height(32),
      margin: EdgeInsets.only(left: ScreenAdaper.width(20)),
      padding: EdgeInsets.only(left: ScreenAdaper.width(20)),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.red,
            width: ScreenAdaper.width(10),
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black54,
          fontSize: ScreenAdaper.size(24),
          height: ScreenAdaper.height(2.4),
        ),
      ),
    );
  }

  // 获取猜你喜欢数据
  _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get(api);
    var hotProductData = ProductModel.fromJson(result.data);
    setState(() {
      _hotProductData = hotProductData.result;
    });
  }

  // 猜你喜欢
  Widget _hotProductList() {
    if (_hotProductData.isNotEmpty) {
      return Container(
        height: ScreenAdaper.height(234),
        padding: EdgeInsets.all(ScreenAdaper.width(20)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            // 图片转换格式
            String pic = _hotProductData[index].pic;
            pic = Config.domain + pic.replaceAll('\\', '/');
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: ScreenAdaper.width(21)),
                  height: ScreenAdaper.height(140),
                  width: ScreenAdaper.width(140),
                  child: Image.network(
                    pic,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: ScreenAdaper.height(44),
                  alignment: Alignment.center,
                  child: Text(
                    '商品名称${index + 1}',
                    style: TextStyle(
                      fontSize: ScreenAdaper.size(24),
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: 10,
        ),
      );
    } else {
      return const Text('加载中...');
    }
  }

  //  获取热门推荐商品
  _getBestProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var bestProductData = ProductModel.fromJson(result.data);
    setState(() {
      _bestProductData = bestProductData.result;
    });
  }

  // 热门推荐
  _recProductList() {
    // itemWidth
    double itemWidth = (ScreenAdaper.getScreenWidth() - 30) / 2;
    if (_bestProductData.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: _bestProductData.map((value) {
            // 图片转换格式
            String pic = value.pic;
            pic = Config.domain + pic.replaceAll('\\', '/');
            return Container(
              padding: const EdgeInsets.all(5),
              width: itemWidth,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(233, 233, 233, 0.9),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenAdaper.height(280),
                    // 自适应宽度
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network(
                        pic,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      value.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: ScreenAdaper.size(24),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Stack(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '¥${value.price}',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: ScreenAdaper.size(26),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '¥{value.old_price}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: ScreenAdaper.size(22),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }
    {
      return const Text('加载中...');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 初始化屏幕适配
    ScreenAdaper.init(context);
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            // 轮播
            _swiperBuilder(),
            const SizedBox(
              height: 10,
            ),
            // 猜你喜欢
            _titleBuilder('猜你喜欢'),
            const SizedBox(
              height: 10,
            ),
            _hotProductList(),
            // 热门推荐
            _titleBuilder('热门推荐'),

            _recProductList(),
          ],
        ),
      ),
    );
  }
}
