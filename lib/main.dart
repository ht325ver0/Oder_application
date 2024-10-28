import 'package:flutter/material.dart';
import 'pages/CallWaittingPage.dart';
import 'package:flutter/material.dart';
import 'package:oder_application/models/Product.dart';
import 'package:oder_application/models/ServedProduct.dart';
import 'package:oder_application/widgets/Calling.dart';
import 'package:oder_application/widgets/WaitingCompletion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {






  MyApp({super.key});

    Product GrilledChickenThigh = Product(name: '焼き鳥(もも)', stock: 100, price: 100, options: ['塩','甘口','中辛','辛口','デス']);
    Product GrilledChickenSkin = Product(name: '焼き鳥(かわ)', stock: 100, price: 100, options: ['塩','甘口','中辛','辛口','デス']);

    //late ServedProduct product1 = ServedProduct(object: GrilledChickenSkin, optionNumber: 2, oderPieces: 2, memo: '',time: DateTime.utc(1989, 11, 9));
    //late ServedProduct product2 = ServedProduct(object: GrilledChickenThigh, optionNumber: 1, oderPieces: 1, memo: '',time: DateTime.utc(1989, 11, 9)); 

    //late ServedProduct product3 = ServedProduct(object: GrilledChickenSkin, optionNumber: 4, oderPieces: 1, memo: 'あいう',time: DateTime.utc(1989, 11, 10));
    //late ServedProduct product4 = ServedProduct(object: GrilledChickenThigh, optionNumber: 0, oderPieces: 3, memo: '',time: DateTime.utc(1989, 11, 11)); 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 58, 146, 183)),
        useMaterial3: true,

      ),
      home: CallWaittingPage(title: '調理待ち一覧ページ',waitingOder:  {},callingOder: {},counter: 0,),
    );
  }
}

