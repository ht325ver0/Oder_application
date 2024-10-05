import 'package:flutter/material.dart';
import 'package:oder_application/models/Product.dart';
import 'package:oder_application/models/ServedProduct.dart';
import 'package:oder_application/widgets/Calling.dart';
import 'package:oder_application/widgets/WaitingCompletion.dart';
import 'package:oder_application/firestore.dart';


class CallWaittingPage extends StatefulWidget {
  CallWaittingPage({super.key,required this.title, required this.waitingOder, required this.callingOder});

  final String title;
  Map<DateTime,List<ServedProduct>> waitingOder;
  Map<DateTime,List<ServedProduct>> callingOder;


  @override
  State<CallWaittingPage> createState() => _CallWaittingPage();
}

class _CallWaittingPage extends State<CallWaittingPage> {

  late Firestore collection;
  List<Product> productsList = [];

  
  Future<void> fetchServedProducts() async {
    Map<DateTime,List<ServedProduct>> fetchedProducts = await collection.getServedProduct(productsList);
    setState(() {
      widget.waitingOder = fetchedProducts;
    });
    
    debugPrint("q${fetchedProducts}");
  }

  Future<void> fetchProducts() async {
    List<Product> fetchedProducts = await collection.getProductList();
    setState(() {
      productsList = fetchedProducts;
    });
    
    debugPrint("k${fetchedProducts}");
  }
  void nullFunction(String a){

  }

  void getCallOder(DateTime time, List<ServedProduct> products){

    setState(() {
      widget.callingOder.addEntries([
        MapEntry(time, products),
      ]);
      widget.waitingOder.remove(time);
    });
      
  }

  void callingCustamer(DateTime time, List<ServedProduct> products){

    setState(() {
      widget.callingOder.remove(time);
    });
      
  }

  @override
  void initState() {
    super.initState();
      
    collection = Firestore();
    fetchProducts();
    fetchServedProducts();
    
  }

  
  
  @override
  Widget build(BuildContext context) {


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    

    


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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            WaitingCompletion(onKeyPressed: getCallOder, width: screenWidth*0.48, height: screenHeight*0.96, waitingOder: widget.waitingOder),
            Calling(onKeyPressed: callingCustamer, width: screenWidth*0.48, height: screenHeight*0.96, callingOder: widget.callingOder),
          ]
        ),
      ),
    );
  }
}