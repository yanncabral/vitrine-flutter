import 'package:flutter/material.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: VanillaColorScheme.medium.withOpacity(0.1),
                    foregroundColor: VanillaColorScheme.black,
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                "Entrar",
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.copyWith(color: VanillaColorScheme.black),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: VanillaColorScheme.medium.withOpacity(0.2),
                    foregroundColor: VanillaColorScheme.black,
                    child: Image.asset(
                      "assets/icons/apple.png",
                      height: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: VanillaColorScheme.medium.withOpacity(0.2),
                    foregroundColor: VanillaColorScheme.black,
                    child: Image.asset(
                      "assets/icons/google.png",
                      height: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: VanillaColorScheme.medium.withOpacity(0.2),
                    foregroundColor: VanillaColorScheme.black,
                    child: Image.asset(
                      "assets/icons/facebook.png",
                      height: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                "Ou com email",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: VanillaColorScheme.medium),
              ),
              const SizedBox(height: 32),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: VanillaColorScheme.black,
                    ),
                cursorColor: VanillaColorScheme.dark,
                decoration: InputDecoration(
                  labelText: "Nome",
                  labelStyle: Theme.of(context).textTheme.caption?.copyWith(
                        color: VanillaColorScheme.black.withOpacity(0.4),
                      ),
                  filled: true,
                  fillColor: VanillaColorScheme.light,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: VanillaColorScheme.error,
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: VanillaColorScheme.light,
                      width: 0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: VanillaColorScheme.light,
                      width: 0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: VanillaColorScheme.black,
                    ),
                cursorColor: VanillaColorScheme.dark,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: Theme.of(context).textTheme.caption?.copyWith(
                        color: VanillaColorScheme.black.withOpacity(0.4),
                      ),
                  filled: true,
                  fillColor: VanillaColorScheme.light,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: VanillaColorScheme.error,
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: VanillaColorScheme.light,
                      width: 0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: VanillaColorScheme.light,
                      width: 0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: VanillaColorScheme.black,
                    ),
                cursorColor: VanillaColorScheme.dark,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: Theme.of(context).textTheme.caption?.copyWith(
                        color: VanillaColorScheme.black.withOpacity(0.4),
                      ),
                  filled: true,
                  fillColor: VanillaColorScheme.light,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: VanillaColorScheme.error,
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: VanillaColorScheme.light,
                      width: 0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: VanillaColorScheme.light,
                      width: 0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "Já tem uma conta?",
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: VanillaColorScheme.medium,
                        ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Entre",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: VanillaColorScheme.secondary,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
