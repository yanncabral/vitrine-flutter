import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/infra/models/firestore/firestore_product.dart';

class _HomeViewModelState {
  List<Product>? products;
}

class StreamControllerHomeViewModel {
  final _state = _HomeViewModelState();
  final _controller = StreamController<_HomeViewModelState>.broadcast();

  Stream<List<Product>?> get products =>
      _controller.stream.map((state) => state.products).distinct();

  Future<void> getProducts() async {
    final products =
        await FirebaseFirestore.instance.collection("products").get();
    _state.products = products.docs
        .map(
          (e) => FirestoreProduct.fromJson(e.data()),
        )
        .toList();
    _controller.add(_state);
  }
}
