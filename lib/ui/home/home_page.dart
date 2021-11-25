import 'dart:async';
import 'dart:ui';

import 'package:bye_bye_localization/bye_bye_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:vitrine/domain/entities/category.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/ui/category/category_page.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';
import 'package:vitrine/ui/product/product_page.dart';
import 'package:vitrine/ui/profile/profile_page.dart';
import 'package:vitrine/ui/util/cached_translated_text.dart';
import 'package:vitrine/ui/util/category_info.dart';
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

  Widget promotedProductSection(Product product) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        FirebaseAuth.instance.signOut();
      },
      child: Container(
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
              "assets/produto.jpg",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage("assets/mareza.jpg"),
              ),
              title: CachedTranslatedText(
                "TORNOZELEIRA BUZIOS".toUpperCase(),
              ),
              subtitle: CachedTranslatedText(
                "MAREZA ARTESANATO".toUpperCase(),
                // style: Theme.of(context).textTheme.ti,
              ),
              trailing: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
      ),
    );
  }

  Widget categories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CachedTranslatedText(
            "Categorias",
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.black),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            const SizedBox(width: 16),
            ...Category.values.map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: MaterialButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(category: category),
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Hero(
                        tag: category.title,
                        child: CircleAvatar(
                          radius: 36,
                          backgroundImage: AssetImage(category.imagePath),
                        ),
                      ),
                      const SizedBox(height: 8),
                      CachedTranslatedText(
                        category.title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              );
            }).toList()
          ]),
        ),
      ],
    );
  }

  Widget recommended() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CachedTranslatedText(
            "Recomendados pra você",
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>?>(
      stream: _presenter.products,
      builder: (context, snapshot) {
        final product = snapshot.data?.first ?? ProductSample.sample;
        return CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: promotedProductSection(product),
              ),
              categories(),
              recommended(),
            ]),
          ),
          if (snapshot.data != null) ...{
            SliverSafeArea(
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Column(
                    children: [
                      MaterialButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(product: snapshot.data![index]),
                          ),
                        ),
                        child: ItemCard(product: snapshot.data![index]),
                      ),
                      const Divider(),
                    ],
                  ),
                  childCount: snapshot.data!.length,
                ),
              ),
            )
          }
        ]);
      },
    );
  }
}
