import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/infra/models/firestore/firestore_product.dart';
import 'package:vitrine/view_model/stream_controller/strem_controller_view_model/stream_controller_view_model.dart';

class _HomeViewModelState {
  List<Product>? products;
}

class StreamControllerHomeViewModel
    extends StreamControllerViewModel<_HomeViewModelState> {
  Stream<List<Product>?> get products =>
      controller.stream.map((state) => state.products).distinct();

  Future<void> getProducts() async {
    final products =
        await FirebaseFirestore.instance.collection("products").get();
    state.products = products.docs
        .map(
          (e) => FirestoreProduct.fromJson(e.data()),
        )
        .toList();
    controller.add(state);
  }
}
