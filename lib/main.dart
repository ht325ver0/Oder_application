import 'package:flutter/material.dart';
import 'pages/CallWaittingPage.dart';
import 'package:flutter/material.dart';
import 'package:oder_application/models/Product.dart';
import 'package:oder_application/models/SelectedProduct.dart';
import 'package:oder_application/widgets/Calling.dart';
import 'package:oder_application/widgets/WaitingCompletion.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {






  MyApp({super.key});

    Product GrilledChickenThigh = Product(name: '焼き鳥(もも)', stock: 100, prise: 100, options: ['塩','甘口','中辛','辛口','デス']);
    Product GrilledChickenSkin = Product(name: '焼き鳥(かわ)', stock: 100, prise: 100, options: ['塩','甘口','中辛','辛口','デス']);

    late SelectedProduct product1 = SelectedProduct(object: GrilledChickenSkin, optionNumber: 2, oderPieces: 2, memo: '');
    late SelectedProduct product2 = SelectedProduct(object: GrilledChickenThigh, optionNumber: 1, oderPieces: 1, memo: ''); 

    late SelectedProduct product3 = SelectedProduct(object: GrilledChickenSkin, optionNumber: 4, oderPieces: 1, memo: 'あいう');
    late SelectedProduct product4 = SelectedProduct(object: GrilledChickenThigh, optionNumber: 0, oderPieces: 3, memo: ''); 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 58, 146, 183)),
        useMaterial3: true,

      ),
      home: CallWaittingPage(title: 'タイトル',waitingOder: {DateTime.utc(1989, 11, 9):[product1,product2],DateTime.utc(1989, 11, 10):[product3],DateTime.utc(1989, 11, 11):[product4]},callingOder: {},),
    );
  }
}

