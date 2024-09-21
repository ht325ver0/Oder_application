import 'package:flutter/material.dart';
import 'Product.dart';

class ServedProduct{
  ///商品(Product)
  Product object;
  ///オプションの番号
  int optionNumber;
  ///注文数(int)
  int oderPieces;
  ///商品の価格(int)
  ///
  String? memo;

  DateTime? time;

  ServedProduct({
    required this.object,
    required this.optionNumber,
    required this.oderPieces,
    this.memo = null,
    this.time = null
  });

  ///小計計算
  int calculatSubtotal(){
    int subtotal = this.object.price * this.oderPieces;
    int discount = (oderPieces ~/ 3) * 30;
    subtotal -= discount;
    return subtotal;
  }
  
  

}
