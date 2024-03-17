import 'package:flutter/material.dart';
import 'package:vitrine/data/services/firestore/firestore_product_service.dart';
import 'package:vitrine/domain/entities/category.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/ui/product/product_page.dart';
import 'package:vitrine/ui/profile/profile_page.dart';
import 'package:vitrine/ui/util/category_info.dart';
import 'package:vitrine/view_model/stream_controller/strem_controller_view_model/stream_controller_view_model.dart';

class _CategoryPresenterState {
  List<Product>? products;
  bool? isLoading;
}

class CategoryPagePresenter
    extends StreamControllerViewModel<_CategoryPresenterState> {
  final _state = _CategoryPresenterState();
  final _datasource = FirestoreProductsDatasource();

  @override
  _CategoryPresenterState get state => _state;

  Stream<List<Product>?> get products =>
      controller.stream.map((state) => state.products).distinct();

  Future<void> fetchProducts(Category category) async {
    setState(() => _state.isLoading = true);
    final result = await _datasource.findBy(category: category, page: 1);

    setState(() {
      result.fold(
        (error) => null,
        (products) => _state.products = products.toList(),
      );
      _state.isLoading = false;
    });
  }
}

class CategoryPage extends StatefulWidget {
  final Category category;

  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _presenter = CategoryPagePresenter();

  @override
  void initState() {
    super.initState();
    _presenter.fetchProducts(widget.category);
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.dispose();
  }

  double offset = 0.0;

  Widget appbar() => SliverLayoutBuilder(
        builder: (context, constraints) {
          offset = constraints.scrollOffset;
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
            expandedHeight: MediaQuery.of(context).size.height / 3,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              title: Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black54,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    Text(widget.category.title),
                    const Spacer(),
                  ],
                ),
              ),
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: Hero(
                tag: widget.category.title,
                child: Image.asset(
                  widget.category.imagePath,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Product>?>(
        stream: _presenter.products,
        builder: (context, snapshot) => NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [appbar()],
          body: snapshot.data == null
              ? const Center(child: CircularProgressIndicator())
              : Container(
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
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 16),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Column(
                      mainAxisSize: MainAxisSize.min,
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
                      ],
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: snapshot.data!.length,
                  ),
                ),
        ),
      ),
    );
  }
}
