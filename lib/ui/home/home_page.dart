import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/ui/profile/profile_page.dart';
import 'package:vitrine/view_model/stream_controller/stream_controller_home_viewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final _presenter = StreamControllerHomeViewModel();

  Future<void> getProducts() async {
    await _presenter.getProducts();
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recomendados pra você",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: StreamBuilder<List<Product>?>(
                  stream: _presenter.products,
                  builder: (context, snapshot) {
                    return Wrap(
                      runSpacing: 18,
                      children: snapshot.data
                              ?.map((e) => ItemCard(product: e))
                              .toList() ??
                          [],
                    );
                  }),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
