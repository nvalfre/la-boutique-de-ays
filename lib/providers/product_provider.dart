import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:la_boutique_de_a_y_s_app/domain/product.dart';

class ProductProvider {
  static ProductProvider _instance;
  final _repository = FirebaseFirestore.instance.collection('products');
  final categoryCovariant = "category";

  ProductProvider._internal();

  static ProductProvider getState() {
    if (_instance == null) {
      _instance = ProductProvider._internal();
    }

    return _instance;
  }

  Stream<Product> getProduct(id) => getProductQuerySnap(id)
      .map((product) => Product.fromQuerySnapshot(product));

  Stream<QuerySnapshot> getProductQuerySnap(String uid) =>
      _repository.where('id', isEqualTo: uid).snapshots();

  Stream<List<Product>> getProducts() =>
      _repository.snapshots().map((snap) => toProductList(snap.docs));

  List<Product> toProductList(List<DocumentSnapshot> documents) {
    List<Product> list = [];
    documents.forEach((document) {
      Product product = Product.fromSnapshot(document);
      list.add(product);
    });
    return list;
  }

  List<Product> toProductListFromQuery(QuerySnapshot snapshot) {
    List<Product> list = [];
    snapshot.docs.forEach((document) {
      Product product = Product.fromQueryDocSnapshot(document);
      list.add(product);
    });
    return list;
  }

  Stream<Product> loadProductStreamBy(key, covariant) {
    return _repository
        .where(key, isEqualTo: covariant)
        .snapshots()
        .map((product) => Product.fromQuerySnapshot(product));
  }

  Product findById(String productId) => Product();

}
