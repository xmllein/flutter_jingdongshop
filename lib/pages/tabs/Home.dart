import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import '../../services/ScreenAdaper.dart';

// 轮播数据模型
import '../../model/FocusModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 轮播数据
  List _focusData = [];

  @override
  initState() {
    super.initState();
    // 获取轮播图数据
    _getFocusData();
  }

  // 获取轮播数据
  _getFocusData() async {
    var api =
        'https://console-mock.apipost.cn/mock/2117ba91-dec5-437a-ddf1-7f90025cffa8/focus';
    var result = await Dio().get(api);
    var focusList = FocusModel.fromJson(result.data);
    setState(() {
      _focusData = focusList.result;
    });
  }

  // 轮播api: jd.itying.com/api/focus
  // https://console-mock.apipost.cn/mock/2117ba91-dec5-437a-ddf1-7f90025cffa8/focus
  //  json to dart
  // https://javiercbk.github.io/json_to_dart/
  // 轮播图数据
  // List<Map> swiperDataList = [
  //   {'url': 'https://www.itying.com/images/flutter/slide01.jpg'},
  //   {'url': 'https://www.itying.com/images/flutter/slide02.jpg'},
  //   {'url': 'https://www.itying.com/images/flutter/slide03.jpg'},
  // ];

  // 轮播组件
  Widget _swiperBuilder() {
    if (_focusData.isNotEmpty) {
      return AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              _focusData[index].pic,
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

  // 热门商品
  Widget _hotProductList() {
    return Container(
      height: ScreenAdaper.height(234),
      padding: EdgeInsets.all(ScreenAdaper.width(20)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: ScreenAdaper.width(21)),
                height: ScreenAdaper.height(140),
                width: ScreenAdaper.width(140),
                child: Image.network(
                  'https://www.itying.com/images/flutter/hot${index + 1}.jpg',
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
  }

  // 热门推荐
  _recProductItem() {
    // itemWidth
    double itemWidth = (ScreenAdaper.getScreenWidth() - 30) / 2;
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
                'https://www.itying.com/images/flutter/list1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              '2019夏季新款女装高大上的衣服阔太太有型的衣服衣服阔太太有型的衣服',
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
                  '¥199',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: ScreenAdaper.size(26),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '¥299',
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
  }

  @override
  Widget build(BuildContext context) {
    // 初始化屏幕适配
    ScreenAdaper.init(context);
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            _swiperBuilder(),
            const SizedBox(
              height: 10,
            ),
            _titleBuilder('猜你喜欢'),
            const SizedBox(
              height: 10,
            ),
            _hotProductList(),
            // const SizedBox(
            //   height: 10,
            // ),
            _titleBuilder('热门推荐'),
            Container(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  _recProductItem(),
                  _recProductItem(),
                  _recProductItem(),
                  _recProductItem(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
