import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/infra/models/firestore/firestore_product.dart';

class _HomeViewModelState {
  List<Product>? products;
}

abstract class StreamControllerViewModel<State> {
  late State _state;
  final _controller = StreamController<State>.broadcast();

  void setState(Function() action) {
    action();
    _controller.add(_state);
  }

  void dispose() => _controller.close();
}

class StreamControllerHomeViewModel
    extends StreamControllerViewModel<_HomeViewModelState> {
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
