import 'package:flutter/material.dart';

import '../widget/JdButton.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  List payList = [
    {
      "title": "支付宝支付",
      "chekced": true,
      "image": "https://www.itying.com/themes/itying/images/alipay.png"
    },
    {
      "title": "微信支付",
      "chekced": false,
      "image": "https://www.itying.com/themes/itying/images/weixinpay.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("去支付"),
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: 400,
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: payList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: Image.network("${payList[index]["image"]}"),
                        title: Text("${payList[index]["title"]}"),
                        trailing: payList[index]["chekced"]
                            ? const Icon(Icons.check)
                            : const Text(""),
                        onTap: () {
                          //让payList里面的checked都等于false
                          setState(() {
                            for (var i = 0; i < payList.length; i++) {
                              payList[i]['chekced'] = false;
                            }
                            payList[index]["chekced"] = true;
                          });
                        },
                      ),
                      const Divider(),
                    ],
                  );
                },
              )),
          JdButton(
            text: "支付",
            color: Colors.red,
            height: 74,
            cb: () {
              print('支付1111');
            },
          )
        ],
      ),
    );
  }
}
