import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:vitrine/data/services/firestore/firestore_product_service.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/entities/shop.dart';
import 'package:vitrine/domain/error/domain_error.dart';
import 'package:vitrine/ui/product/product_page.dart';
import 'package:vitrine/ui/profile/profile_page.dart';

import 'package:vitrine/view_model/stream_controller/strem_controller_view_model/stream_controller_view_model.dart';

class _ShopState {
  bool? isLoading;
  Shop? shop;
  List<Product>? products;
}

class ShopPagePresenter extends StreamControllerViewModel<_ShopState> {
  final _state = _ShopState();
  final _datasource = FirestoreProductsDatasource();

  Stream<Shop?> get shop =>
      controller.stream.map((state) => state.shop).distinct();
  Stream<bool?> get isLoading =>
      controller.stream.map((state) => state.isLoading).distinct();
  Stream<List<Product>?> get products =>
      controller.stream.map((state) => state.products).distinct();

  @override
  _ShopState get state => _state;

  Future<void> fetchProducts() async {
    final shop = _state.shop;
    if (shop != null) {
      final result = await _datasource.findByShop(shop: shop, page: 1);
      result.fold((error) => null, (products) {
        setState(() => _state.products = products.toList());
      });
    }
  }

  Future<void> fetchFutureShop(
    Future<Either<DomainError, Shop>> futureShop,
  ) async {
    setState(() => _state.isLoading = true);
    final result = await futureShop;
    result.fold(
      (error) => null,
      (shop) {
        setState(() {
          _state.shop = shop;
          _state.isLoading = false;
        });
        fetchProducts();
      },
    );
  }
}

bool isCollapsed = false;

class ShopPage extends StatefulWidget {
  final Future<Either<DomainError, Shop>> futureShop;

  const ShopPage({super.key, required this.futureShop});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final ShopPagePresenter _presenter = ShopPagePresenter();

  @override
  void initState() {
    super.initState();
    _presenter.fetchFutureShop(widget.futureShop);
  }

  Widget appbar(Shop shop) => SliverLayoutBuilder(
        builder: (context, constraints) {
          // offset = constraints.scrollOffset;
          return SliverAppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black54,
                    foregroundColor: Colors.white,
                    radius: 12,
                    child: Icon(Icons.chevron_left),
                  ),
                ),
              ],
            ),
            expandedHeight: MediaQuery.of(context).size.height * 2 / 3,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.white,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                isCollapsed = constraints.biggest.height < 200;
                return FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  title: Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: isCollapsed
                          ? null
                          : const LinearGradient(
                              colors: [
                                Colors.black54,
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const Spacer(),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                shop.name,
                                style: isCollapsed
                                    ? DefaultTextStyle.of(context)
                                        .style
                                        .copyWith(color: Colors.black)
                                    : null,
                              ),
                              const SizedBox(height: 8),
                              if (!isCollapsed) ...{
                                Opacity(
                                  opacity: 0.7,
                                  child: Text(
                                    shop.overview,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              },
                            ],
                          ),
                        ),
                        // const Spacer(),
                      ],
                    ),
                  ),
                  stretchModes: const [
                    StretchMode.blurBackground,
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                  ],
                  background: CachedNetworkImage(
                    imageUrl: shop.media.url,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        BlurHash(hash: shop.media.blurHash),
                  ),
                );
              },
            ),
          );
        },
      );

  Widget body(Shop shop) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [appbar(shop)],
      body: Container(
        margin: const EdgeInsets.all(16),
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 40,
              offset: Offset(0, 20),
              color: Colors.black12,
            ),
          ],
        ),
        child: StreamBuilder<List<Product>?>(
          stream: _presenter.products,
          builder: (context, productsSnapshot) {
            final products = productsSnapshot.data;
            return products == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    padding: const EdgeInsets.only(top: 16),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MaterialButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductPage(product: products[index]),
                            ),
                          ),
                          child: ItemCard(product: products[index]),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: products.length,
                  );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: _presenter.isLoading,
      builder: (context, isLoadingSnapshot) {
        return StreamBuilder<Shop?>(
          stream: _presenter.shop,
          builder: (context, shopSnapshot) {
            return Scaffold(
              body: (shopSnapshot.data != null)
                  ? body(shopSnapshot.data!)
                  : const Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }
}
