import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oder_application/models/ServedProduct.dart';
import 'package:oder_application/models/Product.dart';
import 'package:intl/intl.dart';




class Firestore{

  final db = FirebaseFirestore.instance;
  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<int> getCustomerCounte() async {

    var todayData = await db.collection('servedProduct').doc(today).get();

    int counte;

    if(todayData.exists){
      counte = todayData.get('oderCounter');
    }else{
      counte = 0;
    }

    return counte;
  }

  void addCounter() {

  }

    bool isWithin5Seconds(DateTime a, DateTime b) {
      return (a.difference(b).inSeconds).abs() <= 5;
    }

    void addServedProductToMap(Map<DateTime, List<ServedProduct>> map, DateTime dateTime, ServedProduct servedProduct) {
      DateTime? matchingKey;

      // 既存のキーの中から5秒以内のものを探す
      for (var key in map.keys) {
        if (isWithin5Seconds(key, dateTime)) {
          matchingKey = key;
          break;
        }
      }

      if (matchingKey != null) {
        // 既存のキーに追加
        map[matchingKey]!.add(servedProduct);
      } else {
        // 新しいキーとして追加
        map[dateTime] = [servedProduct];
      }
    }


  Future<List<Product>> getProductList() async {
    try {
      CollectionReference collectionRef = db.collection('productCollection');
      QuerySnapshot querySnapshot = await collectionRef.get();

      if (querySnapshot.docs.isEmpty) {
        debugPrint('No documents found in the collection');
      }

      List<Product> productList = querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();

      return productList;
    } catch (e) {
      
      debugPrint('Error1: $e');
      return [];
    }
  }

  Future<Map<DateTime,List<ServedProduct>>> getServedProduct(List<Product> products, int counter) async {
    try{
      Map<DateTime,List<ServedProduct>> serveOder = {};
      int servedCounter;
      Product? object;
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      DocumentReference todayData = db.collection('servedProduct').doc(today);

      debugPrint('Getting document for today: $today');

      for(int i = 1; i <= counter; i++){
        CollectionReference customer = todayData.collection('${i}');
        QuerySnapshot customerSnapshot = await customer.get();

        int oderAmount = customerSnapshot.size;

        DocumentSnapshot sta = await customer.doc('Info').get();

        debugPrint('${sta}');


        int id = 0;

        if(sta.exists){
          id = sta.get('id');
        }

        debugPrint('id = ${id}');


        for (QueryDocumentSnapshot doc in customerSnapshot.docs) {
          // ドキュメントIDを取得
          String docId = doc.id;
          // ドキュメントデータを取得
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          
          // 取得した情報を表示
          print('Document ID: $docId');
          print('Document Data: $data');

          if(docId != 'Info'){
            if(sta.get('cooked') == true && sta.get('served') == false){
              debugPrint('eene');
              Timestamp timestamp = data['time'];
              DateTime dateTime = timestamp.toDate();
              var name = data['productName'];
              for(var p in products){
                if(p.name == name){
                  object = p;
                } 
              }
              if(object == null){
                object = Product(name: "non", stock: 0, price: 0, options: []);
              }
            
              addServedProductToMap(serveOder, dateTime, ServedProduct(
                object: object, 
                optionNumber: data['option'],
                oderPieces: data['quantity'], 
                memo: '',
                time: dateTime,
                counter: id,
              ));
            }
          }

        
        }///ここの処理から受け渡し待ちの商品の状態を確認して取得する。


          
        }
        return serveOder;
      }

      
     catch(e) {

      debugPrint('Error: ${e}');
      return {};
    }
  }


  

  Future<Map<DateTime,List<ServedProduct>>> getCookingProducts(List<Product> products, int counter) async { 
    try {
      Map<DateTime,List<ServedProduct>> waitingOder = {};
      int servedCounter;
      Product? object;
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      DocumentReference todayData = db.collection('servedProduct').doc(today);

      
      debugPrint('Getting document for today: $today');

      for(int i = 0; i < counter; i++){
        CollectionReference customer = todayData.collection('${i}');
        QuerySnapshot customerSnapshot = await customer.get();

        int oderAmount = customerSnapshot.size;

        DocumentSnapshot sta = await customer.doc('Info').get();

        debugPrint('${sta}');

        var servedState;
        int id = 0;

        
        debugPrint('id = ${id}');

        if(sta.exists){
          servedState = sta.get('cooked');
          id = sta.get('id');
        }

        debugPrint('id = ${id}');

        for (QueryDocumentSnapshot doc in customerSnapshot.docs) {
          // ドキュメントIDを取得
          String docId = doc.id;
          // ドキュメントデータを取得
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          
          // 取得した情報を表示
          print('Document ID: $docId');
          print('Document Data: $data');

          if(docId != 'Info'){
            if(servedState == false){
              debugPrint('eene');
              Timestamp timestamp = data['time'];
              DateTime dateTime = timestamp.toDate();
              var name = data['productName'];
              for(var p in products){
                if(p.name == name){
                  object = p;
                } 
              }
              if(object == null){
                object = Product(name: "non", stock: 0, price: 0, options: []);
              }
            
              addServedProductToMap(waitingOder, dateTime, ServedProduct(
                object: object, 
                optionNumber: data['option'],
                oderPieces: data['quantity'], 
                memo: '',
                time: dateTime,
                counter: id,
              ));
            }
          }

        
        }
      }
      /** 

      ///ここでデータが取れてないのが原因らしい(10／20)
      DocumentSnapshot todayDocSnapshot = await todayData.get();
      if(todayDocSnapshot.exists){
        debugPrint('ok');
      }else{
        debugPrint('no');
      }

      ///ここバグ(10／20)Error occurred: TypeError: null: type 'Null' is not a subtype of type 'Map<String, dynamic>'
      Map<String, dynamic> data = todayDocSnapshot.data() as Map<String, dynamic>;
      if (!data.containsKey('servedCounter')) {
        debugPrint('servedCounter not found, setting to 1');
        await todayData.set({
          'servedCounter': 1,
        });
        servedCounter = 1;
      } else {
        servedCounter = todayDocSnapshot.get('servedCounter');
        debugPrint('servedCounter found: $servedCounter');
      }
      
      int oderCounter = todayDocSnapshot.get('oderCounter');
      debugPrint('oderCounter: $oderCounter');

      for (int j = servedCounter; j < oderCounter; j++) {
        debugPrint('Fetching collection for index: $j');
        var snapshot = await todayData.collection('$j').get();
        debugPrint('Snapshot size: ${snapshot.docs.length}');

        if (snapshot.docs.isEmpty) {
          debugPrint('No documents found in the collection at index $j');
          break;
        }
        
        if (products.isEmpty) {
          debugPrint('No products found');
          break;
        }
        
        for (var element in snapshot.docs) {         
          var name = element.get('productName');
          debugPrint('Processing product name: $name');

          for (var i in products) {
            if (name == i.name) {
              debugPrint('Match found: $name');
              object = i;
            }
          }

          Timestamp timestamp = element.get('time');
          DateTime dateTime = timestamp.toDate();
          debugPrint('Adding served product to map for date: $dateTime');
          
          addServedProductToMap(waitingOder, dateTime, ServedProduct(
            object: object, 
            optionNumber: element.get('option'), 
            oderPieces: element.get('quantity'), 
            memo: null, 
            time: null
          ));
        }
      }

      for (var entry in waitingOder.entries) {
        debugPrint('Date: ${entry.key}');
        for (var i in entry.value) {
          debugPrint('Served Product: ${i.object}');
        }
      }
      */

    return waitingOder;
      
    } catch (e, stackTrace) {
      debugPrint('Error occurred: $e');
      debugPrint('Stack Trace: $stackTrace');
      return {};
    }
  }

  ///dbの受け取り待ち(served)の状態を変える.引数{counter:何番目の客かで判定}
  
  Future<void> servedProduct(DateTime date, List<ServedProduct> p, int counter) async {
    try{
      int co = p[0].counter;
      debugPrint('co = ${co}');
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      DocumentReference todayData = db.collection('servedProduct').doc(today);
      for(int i = 1; i <= counter; i++){
        DocumentReference customer = todayData.collection('${i}').doc('Info');
        DocumentSnapshot customerData = await customer.get();
        int oderId = 0;
        if(customerData.exists){
          debugPrint('ex');
          oderId = customerData.get('id');
        }
        debugPrint('oderid = ${oderId}');
        if(oderId == co){
          customer.update({'served': true});
        }
        
        debugPrint('${customerData.get('served')}');
      }
    } catch(e) {
      debugPrint('ChangeServedStateError:${e}');
    }
  }
  
  Future<void> completeCooking(DateTime date, List<ServedProduct> p, int counter) async {
    try{
      int co = p[0].counter;
      debugPrint('co = ${co}');
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      DocumentReference todayData = db.collection('servedProduct').doc(today);
      for(int i = 1; i <= counter; i++){
        DocumentReference customer = todayData.collection('${i}').doc('Info');
        DocumentSnapshot customerData = await customer.get();
        int oderId = 0;
        if(customerData.exists){
          debugPrint('ex');
          oderId = customerData.get('id');
        }
        debugPrint('oderid = ${oderId}');
        if(oderId == co){
          customer.update({'cooked': true});
        }
        
        debugPrint('${customerData.get('cooked')}');
      }
    } catch(e) {
      debugPrint('ChangeCookedStateError:${e}');
    }

  }
  
  

}