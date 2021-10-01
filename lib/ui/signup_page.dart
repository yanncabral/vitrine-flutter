import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vitrine/ui/design/components/vanilla_action_button.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';

// class PersonName {
//   final String _value;
//   PersonName(this._value);
//   @override
//   String toString() => _value;
// }

// class SignUpPresenter {}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: CircleAvatar(
              backgroundColor: VanillaColorScheme.medium.withOpacity(0.1),
              child: IconButton(
                color: VanillaColorScheme.black,
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Registrar",
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.copyWith(color: VanillaColorScheme.black),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    minWidth: 0,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor:
                          VanillaColorScheme.medium.withOpacity(0.2),
                      foregroundColor: VanillaColorScheme.black,
                      child: Image.asset(
                        "assets/icons/apple.png",
                        height: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  MaterialButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    minWidth: 0,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor:
                          VanillaColorScheme.medium.withOpacity(0.2),
                      foregroundColor: VanillaColorScheme.black,
                      child: Image.asset(
                        "assets/icons/google.png",
                        height: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  MaterialButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    minWidth: 0,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor:
                          VanillaColorScheme.medium.withOpacity(0.2),
                      foregroundColor: VanillaColorScheme.black,
                      child: Image.asset(
                        "assets/icons/facebook.png",
                        height: 20,
                      ),
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
                keyboardType: TextInputType.name,
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
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextButton(
                      onPressed: () {},
                      child: RichText(
                        text: TextSpan(
                            text: "Eu concordo com os ",
                            style: Theme.of(context).textTheme.caption,
                            children: [
                              TextSpan(
                                text: "Termos de Uso",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      color: VanillaColorScheme.secondary,
                                    ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  VanillaActionButton(
                    title: "Continuar",
                    onPressed: () {},
                    colorScheme: Brightness.dark,
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
