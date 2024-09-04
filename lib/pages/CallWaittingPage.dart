import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oder_application/models/Product.dart';
import 'package:oder_application/models/SelectedProduct.dart';
import 'package:oder_application/widgets/WaitingCompletion.dart';


class CallWaittingPage extends StatefulWidget {
  CallWaittingPage({super.key,required this.title, required this.waitingOder});

  final String title;
  Map<DateTime,List<SelectedProduct>> waitingOder;


  @override
  State<CallWaittingPage> createState() => _CallWaittingPage();
}

class _CallWaittingPage extends State<CallWaittingPage> {
  
  @override
  Widget build(BuildContext context) {


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String a;

    Product GrilledChickenThigh = Product(name: '焼き鳥(もも)', stock: 100, prise: 100, options: ['塩','甘口','中辛','辛口','デス']);
    Product GrilledChickenSkin = Product(name: '焼き鳥(かわ)', stock: 100, prise: 100, options: ['塩','甘口','中辛','辛口','デス']);

    SelectedProduct product1 = SelectedProduct(object: GrilledChickenSkin, optionNumber: 2, oderPieces: 2, memo: '');
    SelectedProduct product2 = SelectedProduct(object: GrilledChickenThigh, optionNumber: 1, oderPieces: 1, memo: ''); 

    SelectedProduct product3 = SelectedProduct(object: GrilledChickenSkin, optionNumber: 4, oderPieces: 1, memo: 'あいう');
    SelectedProduct product4 = SelectedProduct(object: GrilledChickenThigh, optionNumber: 0, oderPieces: 3, memo: ''); 



    Map<DateTime,List<SelectedProduct>> testOder = {DateTime.utc(1989, 11, 9):[product1,product2],DateTime.utc(1989, 11, 10):[product3],DateTime.utc(1989, 11, 11):[product4]};

    void nullFunction(String a){

    }


    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 233, 230),
      appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: Text(widget.title),

          actions: [
            TextButton.icon(
              icon: const Icon(Icons.point_of_sale),
              label: const Text('会計',selectionColor: Color.fromARGB(0, 0, 100, 0),),
              onPressed: () => {},
            ),
          ],
        ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            WaitingCompletion(onKeyPressed: nullFunction, width: screenWidth*0.48, height: screenHeight*0.96, waitingOder: testOder)
          ]
        ),
      ),
    );
  }
}