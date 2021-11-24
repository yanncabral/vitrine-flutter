import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/entities/profile.dart';
import 'package:vitrine/domain/value_objects/person_name.dart';
import 'package:vitrine/infra/models/firestore/firestore_product.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';
import 'package:vitrine/ui/product/product_page.dart';

class _ProfileViewModelState {
  Profile? profile;
}

class StreamControllerProfileViewModel {
  final _controller = StreamController<_ProfileViewModelState>.broadcast();
  final state = _ProfileViewModelState();
  Stream<Profile?> get profile =>
      _controller.stream.map((state) => state.profile).distinct();

  Future<void> getProfile(String userId) async {
    final user = await FirebaseFirestore.instance
        .collection("profiles")
        .doc(userId)
        .get();
    final data = user.data();
    final products = await _getProducts(userId);
    state.profile = Profile(
      id: userId,
      name: PersonName(data!["name"] as String),
      description: data["description"] as String,
      imageUrl: (data["imageUrl"] ?? "") as String,
      products: products,
    );
    _controller.add(state);
  }

  Future<List<Product>> _getProducts(String userId) async {
    final products = await FirebaseFirestore.instance
        .collection("profiles")
        .doc(userId)
        .collection("products")
        .get();
    return products.docs
        .map(
          (e) => FirestoreProduct.fromJson(e.data()),
        )
        .toList();
  }
}

class ProfilePage extends StatefulWidget {
  final String? userId;

  const ProfilePage({Key? key, this.userId}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static final _presenter = StreamControllerProfileViewModel();

  Future<void> getProducts() async {
    if (widget.userId != null) {
      await _presenter.getProfile(widget.userId!);
    } else {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await _presenter.getProfile(uid);
    }
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Profile?>(
        stream: _presenter.profile,
        builder: (context, snapshot) {
          return SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/perfil.jpg",
                            width: 80,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data?.name() ?? "Yann",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Opacity(
                                opacity: 0.8,
                                child: Text(
                                  snapshot.data?.description ??
                                      "Desenvolvedor mais brabo do brasil!!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Produtos",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.black),
                          ),
                          const SizedBox(height: 16),
                          if (snapshot.data?.products.isNotEmpty == true) ...{
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                runSpacing: 18,
                                children: snapshot.data?.products
                                        .map((e) => ItemCard(product: e))
                                        .toList() ??
                                    [],
                              ),
                            ),
                          } else ...{
                            const Center(
                              child: Text("Não há nada aqui por enquanto..."),
                            )
                          },
                          SizedBox(
                              height: MediaQuery.of(context).padding.bottom),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ItemCard extends StatelessWidget {
  final Product product;
  const ItemCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 116,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Hero(
              tag: product.medias.first.blurHash,
              child: Image.network(
                product.medias.first.url,
                fit: BoxFit.cover,
                width: 87,
                height: 116,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  product.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                // const SizedBox(height: 8),
                Opacity(
                  opacity: 0.7,
                  child: Text(
                    product.overview,
                    maxLines: 2,
                  ),
                ),
                // Spacer(),
                Row(
                  children: [
                    Text(
                      "R\$${product.price.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: VanillaColorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: VanillaColorScheme.error,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return CupertinoButton(
  //     onPressed: () {
  //       Navigator.of(context).push(
  //         MaterialPageRoute(
  //           builder: (context) => ProductPage(
  //             product: product,
  //           ),
  //         ),
  //       );
  //     },
  //     padding: EdgeInsets.zero,
  //     child: FractionallySizedBox(
  //       widthFactor: 0.5,
  //       child: Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 8),
  //         decoration: BoxDecoration(
  //           color: VanillaColorScheme.light,
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.circular(12),
  //                 child: Image.network(
  //                   product.medias.first.url,
  //                   fit: BoxFit.cover,
  //                   // height: 100,
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(12.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     product.title,
  //                     style: Theme.of(context)
  //                         .textTheme
  //                         .headline4
  //                         ?.copyWith(color: Colors.black),
  //                   ),
  //                   const SizedBox(height: 4),
  //                   Text(
  //                     "R\$${product.price.toStringAsFixed(2).replaceFirst(".", ',')}",
  //                     style: Theme.of(context).textTheme.bodyText2?.copyWith(
  //                           color: VanillaColorScheme.secondary,
  //                         ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
