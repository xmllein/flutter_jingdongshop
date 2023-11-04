import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_jdshop/config/Config.dart';

class ProductDetailPage extends StatefulWidget {
  final List _productContentList;

  const ProductDetailPage(this._productContentList, {Key? key})
      : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  var id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget._productContentList[0].id;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse("${Config.domain}pcontent?id=${id}")),
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {},
            ),
          )
        ],
      ),
    );
  }
}
