import 'package:flutter/material.dart';
import 'package:oder_application/models/Product.dart';
import 'package:oder_application/models/ServedProduct.dart';
import 'package:oder_application/widgets/Calling.dart';
import 'package:oder_application/widgets/WaitingCompletion.dart';
import 'package:oder_application/firestore.dart';


class CallWaittingPage extends StatefulWidget {
  CallWaittingPage({super.key,required this.title, required this.waitingOder, required this.callingOder, required this.counter});

  final String title;
  Map<DateTime,List<ServedProduct>> waitingOder;
  Map<DateTime,List<ServedProduct>> callingOder;
  int counter;


  @override
  State<CallWaittingPage> createState() => _CallWaittingPage();
}

class _CallWaittingPage extends State<CallWaittingPage> {

  late Firestore collection;
  List<Product> productsList = [];

  
  

  Future<void> fetchProducts() async {
  try {
    List<Product> fetchedProducts = await collection.getProductList();
    
    // setState内でデータを反映
    setState(() {
      productsList = fetchedProducts;  // データがセットされたタイミングでデバッグ
    });
  } catch (e) {
    debugPrint('Error fetching products: $e');
  }
}


  void nullFunction(String a){

  }

  Future<void> fetchServedProducts() async {
    try{
      Map<DateTime,List<ServedProduct>> fetchedProducts = await collection.getCookingProducts(productsList, widget.counter);
      Map<DateTime,List<ServedProduct>> fetchedServeProducts = await collection.getServedProduct(productsList, widget.counter);
      setState(() {
        widget.waitingOder = fetchedProducts;
        widget.callingOder = fetchedServeProducts;
      });
      
      debugPrint("qa${fetchedProducts}");
      
    }catch(e){
      debugPrint('koko');
      debugPrint('fetchServedProductsError: $e');
    }
  }

  void getCallOder(DateTime time, List<ServedProduct> products){

    setState(() {
      widget.callingOder.addEntries([
        MapEntry(time, products),
      ]);
      widget.waitingOder.remove(time);
      collection.completeCooking(time, products, widget.counter);
    });
      
  }

  void callingCustamer(DateTime time, List<ServedProduct> products){

    setState(() {
      widget.callingOder.remove(time);
      collection.servedProduct(time,products,widget.counter);
    });
      
  }

  Future<void> fetchingCustomerCounte() async {
    try{
      int fetchedCounte = await collection.getCustomerCounte();
      setState(() {
        widget.counter = fetchedCounte;
      });
      
      debugPrint("qa${fetchedCounte}");
      
    }catch(e){
      debugPrint('fetchingCustomerCounteError: $e');
    }
  }

  @override
  void initState() {
    super.initState();
      
    collection = Firestore();
    _initializeData();
    
  }
///firebaseで登録したproductsを取ってくル。
  Future<void> _initializeData() async {
  await fetchProducts();  // fetchProductsが完了するのを待つ
  await fetchingCustomerCounte();
  // ここで`productsList`にデータがあることを保証
  if (productsList.isNotEmpty) {
    await fetchServedProducts();  // productsListを使う関数をその後に実行
  } else {
    debugPrint('Error: productsList is still empty');
  }
  
  
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
            WaitingCompletion(onKeyPressed: getCallOder, width: screenWidth*0.48, height: screenHeight*0.96, waitingOder: widget.waitingOder, customerCounter: widget.counter),
            Calling(onKeyPressed: callingCustamer, width: screenWidth*0.48, height: screenHeight*0.96, callingOder: widget.callingOder),
          ]
        ),
      ),
    );
  }
}