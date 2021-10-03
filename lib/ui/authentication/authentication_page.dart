import 'package:flutter/material.dart';
import 'package:vitrine/ui/authentication/signup_page.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late ScrollController _scrollController;
  bool isScrolledDown = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final newIsScrolledDown = _scrollController.offset <= 0;
        if (newIsScrolledDown != isScrolledDown) {
          setState(() {
            isScrolledDown = newIsScrolledDown;
          });
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: isScrolledDown ? 0 : 3,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: CircleAvatar(
              backgroundColor: VanillaColorScheme.medium.withOpacity(0.1),
              child: IconButton(
                color: VanillaColorScheme.black,
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.close),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: SignUpPage(),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
