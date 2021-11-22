import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';
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

  Widget promotedProductSection() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 40,
            offset: Offset(0, 20),
            color: Colors.black12,
          )
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/perfil.jpg",
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage("assets/perfil.jpg"),
            ),
            title: Text(
              "TORNOZELEIRA BUZIOS".toUpperCase(),
            ),
            subtitle: Text(
              "MAREZA ARTESANATO".toUpperCase(),
              // style: Theme.of(context).textTheme.ti,
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: VanillaColorScheme.light,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "R\$12",
                style: TextStyle(
                  color: VanillaColorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            promotedProductSection(),
            const SizedBox(height: 32),
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
