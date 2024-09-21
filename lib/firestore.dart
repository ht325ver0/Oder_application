import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oder_application/models/ServedProduct.dart';
import 'package:oder_application/models/Product.dart';
import 'package:intl/intl.dart';




class Firestore{

  final db = FirebaseFirestore.instance;

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

    var snapshot =  await db.collection('servedProduct').doc(todayDate).collection('2').get();
    debugPrint('c');
    snapshot.docChanges.forEach((element){
      var name = element.doc.get('productName');
      for(int i = 0; i < products.length; i++){
        if(name == products[i].name){
          object = products[i];
        }
      }
      Timestamp timestamp = element.doc.get('time');  // Firestoreから取得したタイムスタンプ
      DateTime dateTime = timestamp.toDate();
      if(waitingOder[dateTime] == null){
        waitingOder[dateTime] = [(ServedProduct(object: object, optionNumber: element.doc.get('option'), oderPieces: element.doc.get('quantity'), memo: null, time: null))];
      }else{
        waitingOder[dateTime]!.add(ServedProduct(object: object, optionNumber: element.doc.get('option'), oderPieces: element.doc.get('quantity'), memo: null, time: null));
      }
      debugPrint('z$waitingOder');
    });

    

  

    debugPrint('b');




    final p = await db.collection('servedProduct').doc(todayDate);
    return waitingOder;
  }
}