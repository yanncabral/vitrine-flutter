import 'package:flutter/material.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           snap: true,
//           floating: true,
//           expandedHeight: 281.0,
//           elevation: 4,
//           pinned: true,
//           backgroundColor: VanillaColorScheme.dark,
//           stretch: true,
//           flexibleSpace: FlexibleSpaceBar(
//             centerTitle: false,
//             title: const Text(
//               '@dizyann',
//             ),
//             titlePadding: const EdgeInsets.all(16),
//             background: Stack(
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   height: double.infinity,
//                   child: Image.asset(
//                     "assets/perfil.jpg",
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.transparent,
//                         Colors.black.withOpacity(0.8),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(child: Container(color: VanillaColorScheme.light)),
            Expanded(
              child:
                  Container(color: Theme.of(context).scaffoldBackgroundColor),
            )
          ],
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: VanillaColorScheme.light,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                    ),
                  ),
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
                              "Yann Cabral",
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
                      const SizedBox(width: 16),
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                            color: VanillaColorScheme.secondary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 40,
                                color: VanillaColorScheme.secondary
                                    .withOpacity(0.25),
                                offset: const Offset(0, 20),
                              )
                            ]),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: VanillaColorScheme.light,
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(32),
                    ),
                  ),
                ),
              ),
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
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          runSpacing: 18,
                          children: const [
                            ItemCard(),
                            ItemCard(),
                            ItemCard(),
                            ItemCard(),
                            ItemCard(),
                            ItemCard(),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).padding.bottom),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: VanillaColorScheme.light,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/perfil.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "RAY-BAN 2180",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "R\$149,90",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: VanillaColorScheme.secondary,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text("Home rsrs"),
//     );
//   }
// }
