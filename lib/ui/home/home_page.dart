import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:vitrine/domain/entities/category.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/ui/category/category_page.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';
import 'package:vitrine/ui/product/product_page.dart';
import 'package:vitrine/ui/profile/profile_page.dart';
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

  Widget categories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
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
                      Text(
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
          Text(
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
            // title: Container(
            //   padding: EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       begin: Alignment.bottomCenter,
            //       end: Alignment.topCenter,
            //       colors: [
            //         Colors.black,
            //         Colors.transparent,
            //       ],
            //     ),
            //   ),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Text(
            //         product.title,
            //         textAlign: TextAlign.center,
            //       ),
            //       Text(
            //         product.overview,
            //         textAlign: TextAlign.center,
            //       ),
            //     ],
            //   ),
            // ),

            SliverToBoxAdapter(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
          ]
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: StreamBuilder<List<Product>?>(
              //         stream: _presenter.products,
              //         builder: (context, snapshot) {
              //           if (snapshot.data != null) {
              //             return ListView.separated(
              //               itemBuilder: (context, index) => Text("rs"),
              //               separatorBuilder: (context, int) => Divider(),
              //               itemCount: snapshot.data?.length ?? 0,
              //             );
              //           } else {
              //             return SizedBox();
              //           }
              //           // return Column(
              //           //   children: snapshot.data
              //           //           ?.map((e) => ItemCard(product: e))
              //           //           .toList() ??
              //           //       [],
              //           // );
              //         }),
              //   ),
              // ),
              // SizedBox(height: MediaQuery.of(context).padding.bottom),
              // ],
              // ),
              );
        });
  }
}
