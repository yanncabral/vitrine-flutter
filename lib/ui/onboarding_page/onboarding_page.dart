import 'package:flutter/material.dart';
import 'package:vitrine/ui/design/components/vanilla_action_button.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget background() => SizedBox.expand(
          child: Image.asset(
            "assets/onboarding.jpg",
            fit: BoxFit.cover,
            color: Colors.blue.withOpacity(0.8),
            colorBlendMode: BlendMode.dstATop,
            alignment: Alignment.topCenter,
          ),
        );

    return Scaffold(
      backgroundColor: const Color(0xff0000ff),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          background(),
          OnboardingInterface(),
        ],
      ),
    );
  }
}

class OnboardingInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
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
            FractionallySizedBox(
              widthFactor: 0.5,
              child: Text(
                "Finalmente você chegou ao Vitrine",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Descubra produtos que te merecem oferecidos por gente como a gente",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white.withOpacity(0.8)),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.zero,
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Explorar ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white),
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
                  title: "Entrar",
                  onPressed: () => Navigator.of(context).pushNamed("/auth"),
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
