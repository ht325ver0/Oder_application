import 'package:flutter/material.dart';
import 'package:oder_application/models/SelectedProduct.dart';
import 'package:oder_application/models/Product.dart';

class WaitingCompletion extends StatefulWidget {
  final Function(String) onKeyPressed;
  final double width;
  final double height;
  Map<DateTime,List<SelectedProduct>> waitingOder;

  WaitingCompletion({required this.onKeyPressed, required this.width, required this.height, required this.waitingOder});

  @override
  State<WaitingCompletion> createState() => _WaitingCompletion();
}

class _WaitingCompletion extends State<WaitingCompletion> {

  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          Container(
            width: widget.width,
            height: widget.height*0.07,
            margin: const EdgeInsets.all(3.0),
            color: const Color.fromARGB(248, 228, 227, 227),
            child: Center(child:Text('出来上がり待ち',selectionColor: Color.fromARGB(255, 255, 254, 254),)),
          ),
          Container(
  width: widget.width * 0.95,
  height: widget.height * 0.8,
  child: ListView(
    children: [
      for (var entry in widget.waitingOder.entries)
        Container(
          color: Color.fromARGB(248, 247, 195, 131),
          margin: EdgeInsets.symmetric(vertical: 8.0),
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '(${number}),${entry.key}', // DateTimeの表示
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              for (int i = 0; i < entry.value.length; i++)
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      color: Color.fromARGB(248, 208, 247, 131),
                      child: Text(
                        '${entry.value[i].object.name} (${entry.value[i].object.options[entry.value[i].optionNumber]}) 個数: ${entry.value[i].oderPieces}',
                      ),
                    ),
                    Container(height: widget.height * 0.01,),
                  ],
                ),
                
            ],
          ),
        ),
    ],
  ),
)


        ],
      )
    );
  }

}