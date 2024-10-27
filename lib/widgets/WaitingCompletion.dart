import 'package:flutter/material.dart';
import 'package:oder_application/models/ServedProduct.dart';
import 'package:oder_application/models/Product.dart';

class WaitingCompletion extends StatefulWidget {
  final Function(DateTime, List<ServedProduct>) onKeyPressed;
  final double width;
  final double height;
  Map<DateTime,List<ServedProduct>> waitingOder;
  int customerCounter;

  WaitingCompletion({required this.onKeyPressed, required this.width, required this.height, required this.waitingOder, required this.customerCounter});

  @override
  State<WaitingCompletion> createState() => _WaitingCompletion();
}

class _WaitingCompletion extends State<WaitingCompletion> {

  int servedCounter = 0;
  
  @override
  Widget build(BuildContext context) {
    try{
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          Container(
            width: widget.width,
            height: widget.height*0.05,
            margin: const EdgeInsets.all(3.0),
            color: const Color.fromARGB(248, 228, 227, 227),
            child: Center(child:Text('出来上がり待ち',selectionColor: Color.fromARGB(255, 255, 254, 254),style: TextStyle(fontSize: 18),)),
          ),
          SizedBox(
            width: widget.width * 0.95,
            height: widget.height * 0.8,
            child:SingleChildScrollView(
            child: Column(
              children: [
                for (var entry in widget.waitingOder.entries)
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('この注文を呼び出しますか？'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  for (var i in entry.value)
                                    Text(
                                      '${i.object.name} (${i.object.options[i.optionNumber]}) 個数: ${i.oderPieces}',
                                    ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  widget.onKeyPressed(entry.key, entry.value);
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('NO'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      color: Color.fromARGB(248, 247, 195, 131),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      padding: EdgeInsets.all(8.0),
                      width: widget.width*0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${entry.value[0].counter}番,${entry.key.hour}:${entry.key.minute}', // DateTimeの表示
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          for (var i in entry.value)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: widget.width * 0.7,
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  color: Color.fromARGB(248, 255, 255, 255),
                                  child: Text(
                                    '${i.object.name}(${i.object.options[i.optionNumber]}) 個数: ${i.oderPieces}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                                SizedBox(height: widget.height * 0.01),
                              ],
                            ),
                        ],
                      ),
                    ),
                ),
              ],
          ),
        ),
          )
        ],
      )
    );
    }catch (e, stackTrace) {
      // エラーの内容を表示
      debugPrint('Error2: $e\n');
      
      // スタックトレースを表示
      debugPrint('Stack Trace: $stackTrace');
      return Container();
    }
  }

}