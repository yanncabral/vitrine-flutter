// import 'package:flutter/gestures.dart';
import 'dart:math';

import 'package:hue_rotation/hue_rotation.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/ui/design/components/vanilla_action_button.dart';
import 'package:vitrine/ui/profile/profile_page.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key? key, required this.product}) : super(key: key);
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  late AnimationController _animationController;

  double dragOffset = 0;
  double get dragOffsetGetter => dragOffset;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              if (dragOffset > 150) {
                Navigator.of(context).pop();
              } else {
                final tween = Tween<double>(
                  begin: dragOffset,
                  end: 0,
                ).animate(_animationController);
                tween.addListener(() {
                  setState(() {
                    dragOffset = tween.value;
                  });
                });
                _animationController.reset();
                _animationController.forward();
              }
            },
            onVerticalDragUpdate: (details) {
              dragOffset += details.delta.dy;
              setState(() {
                dragOffset = max(dragOffset, 0);
              });
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Transform(
                  transform: Matrix4.identity()
                    ..setRotationY(-dragOffset / 300),
                  child: Transform.scale(
                    scale: 1 - dragOffset / 1000,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: PageView(
                        controller: _pageController,
                        children: widget.product.medias
                            .map(
                              (e) => HueRotation(
                                degrees: dragOffset,
                                child: Hero(
                                  tag: e.blurHash,
                                  child: backgroundImage(e.url),
                                ),
                              ),
                            )
                            .toList(),
                        onPageChanged: (int index) {
                          _currentPageNotifier.value = index;
                        },
                      ),
                    ),
                  ),
                ),
                ProductPageInterface(
                  product: widget.product,
                  pageNotifier: _currentPageNotifier,
                  itemCount: widget.product.medias.length,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const CircleAvatar(
                          backgroundColor: Colors.black54,
                          foregroundColor: Colors.white,
                          radius: 12,
                          child: Icon(Icons.chevron_left),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container backgroundImage(String url) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ProductPageInterface extends StatelessWidget {
  final ValueNotifier<int> pageNotifier;
  final int itemCount;
  final Product product;

  const ProductPageInterface({
    Key? key,
    required this.pageNotifier,
    required this.itemCount,
    required this.product,
  })  : assert(itemCount > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Colors.black54,
            Colors.transparent,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Apple",
            //   style: Theme.of(context)
            //       .textTheme
            //       .headline4
            //       ?.copyWith(color: Colors.white.withOpacity(0.8)),
            // ),
            const SizedBox(height: 8),
            Text(
              product.title,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              product.overview,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.white.withOpacity(0.8)),
            ),
            const SizedBox(height: 16),
            CirclePageIndicator(
              currentPageNotifier: pageNotifier,
              itemCount: itemCount,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.zero,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ExternalProfile(product: product),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Ver loja",
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                VanillaActionButton(
                  title:
                      "R\$${product.price.toStringAsFixed(2).replaceFirst('.', ',')}",
                  onPressed: () async {
                    // TODO: Change to correct url
                    await launch("https://instagram.com/${product.ownerId}");
                  },
                  colorScheme: Brightness.light,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExternalProfile extends StatelessWidget {
  const ExternalProfile({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("@dizyann"),
        titleTextStyle: Theme.of(context).textTheme.headline3?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            ProfilePage(userId: product.ownerId),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 60,
                  child: VanillaActionButton(
                    title:
                        "R\$${product.price.toStringAsFixed(2).replaceFirst('.', ',')}",
                    onPressed: () async {
                      await launch("https://instagram.com/${product.ownerId}");
                    },
                    colorScheme: Brightness.dark,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
