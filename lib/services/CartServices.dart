class CartServices {
  static addCart(item) {
    //把对象转换成Map类型的数据
    item = CartServices.formatCartData(item);

    print(item);

//     {_id: 5a0425bc010e711234661439, title: 磨砂牛皮男休闲鞋-有属性, price: 688, selectedAttr: 牛皮 ,系带,黄色, count: 3, pic: public\upload\RinsvExKu7Ed-oc
// s_7W1DxYO.png, checked: true}
  }

  //过滤数据
  static formatCartData(item) {
    final Map data = <String, dynamic>{};
    data['_id'] = item.id;
    data['title'] = item.title;
    data['price'] = item.price;
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = item.pic;
    //是否选中
    data['checked'] = true;
    return data;
  }
}
