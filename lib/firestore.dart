import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oder_application/models/ServedProduct.dart';
import 'package:oder_application/models/Product.dart';
import 'package:intl/intl.dart';




class Firestore{

  final db = FirebaseFirestore.instance;

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
      debugPrint('Fetching data from Firestore...');
      QuerySnapshot querySnapshot = await collectionRef.get();
      debugPrint('Data fetched successfully');

      if (querySnapshot.docs.isEmpty) {
        debugPrint('No documents found in the collection');
      }

      List<Product> productList = querySnapshot.docs.map((doc) {
        debugPrint('Document data: ${doc.data()}');
        return Product.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();

      debugPrint('Product list length: ${productList.length}');
      return productList;
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }



  Future<Map<DateTime,List<ServedProduct>>> getServedProduct(List<Product> products) async { 
    Map<DateTime,List<ServedProduct>> waitingOder = {};
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    Product object = Product(name: "", stock: 0, price: 0, options: []);


    //ここのjは DBのServedProduct/今日の日付/コレクションの番号<-これに対応している。
    for(int j = 1; j < 30; j++){
      var snapshot =  await db.collection('servedProduct/$todayDate/$j').get();
      debugPrint('${j}m');
      if (snapshot.docs.isEmpty) {
        debugPrint('No documents found in the collection11');
        break;
      }
      try{
      for (var element in snapshot.docs) {
        
        var name = element.get('productName');
        
        ///ここバグ原因
        for(int i = 0; i < products.length; i++){
          debugPrint('a${name}');
          if(name == products[i].name){
              debugPrint("pp$name");
              object = products[i];
          }
        }
        Timestamp timestamp = element.get('time');  // Firestoreから取得したタイムスタンプ
        DateTime dateTime = timestamp.toDate();
        addServedProductToMap(waitingOder, dateTime, ServedProduct(
          object: object, 
          optionNumber: element.get('option'), 
          oderPieces: element.get('quantity'), 
          memo: null, 
          time: null
        ));
        
          
            
          
        };
      }catch(e){
        debugPrint('$e');
        continue;
      }
      

    }
    try{
    for (var entry in waitingOder.entries){
      debugPrint('${entry.key}');
      for(var i in entry.value){
        debugPrint('${i.object}');
      }
    }
    }catch(e){
      debugPrint('$e');
    }

    final p = await db.collection('servedProduct').doc(todayDate);
    return waitingOder;
  }
}