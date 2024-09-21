import 'package:flutter/material.dart';
import 'package:oder_application/models/ServedProduct.dart';
import 'package:oder_application/models/Product.dart';

class WaitingCompletion extends StatefulWidget {
  final Function(DateTime, List<ServedProduct>) onKeyPressed;
  final double width;
  final double height;
  Map<DateTime,List<ServedProduct>> waitingOder;

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
            height: widget.height*0.03,
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
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('この注文を呼び出しますか？'),
                  content: (SingleChildScrollView(
                    child: ListBody(
                      children: [
                        for (int i = 0; i < entry.value.length; i++)
                           Text(
                            '${entry.value[i].object.name} (${entry.value[i].object.options[entry.value[i].optionNumber]}) 個数: ${entry.value[i].oderPieces}',
                          ),
                      ],
                    ),
                  )),
                  actions:[
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        widget.onKeyPressed(entry.key ,entry.value);
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('NO'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ]
                  
                );
              }
            );
          },
          child:Container(
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
                        color: Color.fromARGB(248, 131, 247, 168),
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
        ),
    ],
  ),
)


        ],
      )
    );
  }

}