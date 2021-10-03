import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:vitrine/domain/error/domain_error.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/domain/value_objects/password.dart';
import 'package:vitrine/main/factory/domain/view_models/signin_view_model_factory.dart';
import 'package:vitrine/ui/design/components/vanilla_action_button.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';
import 'package:vitrine/ui/util/domain_error_messages.dart';

class SignInPage extends StatelessWidget {
  final void Function() onSwitchPress;
  final _presenter = SignInViewModelFactory.factory;

  SignInPage({Key? key, required this.onSwitchPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<bool>(
            stream: _presenter.isLoadingState,
            builder: (context, isLoadingSnapshot) {
              return isLoadingSnapshot.data == true
                  ? LinearProgressIndicator(
                      color: VanillaColorScheme.secondary,
                      backgroundColor:
                          VanillaColorScheme.secondary.withOpacity(0.4),
                    )
                  : const SizedBox(height: 4);
            }),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Entrar",
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.copyWith(color: VanillaColorScheme.black),
              ),
              const SizedBox(height: 32),
              socialLoginButtons(),
              const SizedBox(height: 32),
              Text(
                "Ou com email",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: VanillaColorScheme.medium),
              ),
              const SizedBox(height: 32),
              form(context),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "Ainda não tem uma conta?",
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: VanillaColorScheme.medium,
                        ),
                  ),
                  TextButton(
                    onPressed: onSwitchPress,
                    child: Text(
                      "Cadastre-se",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: VanillaColorScheme.secondary,
                          ),
                    ),
                  ),
                ],
              ),
              StreamBuilder<DomainError?>(
                  stream: _presenter.formError,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return ListTile(
                        leading: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        title: Text(snapshot.data!.message()),
                      );
                    } else {
                      return const SizedBox(height: 0);
                    }
                  }),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
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
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: VanillaColorScheme.secondary,
                                    ),
                          ),
                        ]),
                  ),
                ),
              ),
              actionButton(),
            ],
          ),
        ),
      ],
    );
  }

  StreamBuilder<DomainError?> actionButton() {
    return StreamBuilder<DomainError?>(
      stream: _presenter.formError,
      builder: (context, formErrorSnapshot) {
        return StreamBuilder<bool?>(
          stream: _presenter.isFormValidState,
          builder: (context, formValidSnapshot) {
            return StreamBuilder<bool>(
              stream: _presenter.isLoadingState,
              builder: (context, snapshot) {
                return VanillaActionButton(
                  title: "Continuar",
                  enabled: snapshot.data != true &&
                      formValidSnapshot.data == true &&
                      formErrorSnapshot.data == null,
                  onPressed: _presenter.submit,
                  colorScheme: Brightness.dark,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget form(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _presenter.isLoadingState,
        builder: (context, loadingSnapshot) {
          return Column(
            children: [
              StreamBuilder<Either<ValidationError, EmailAddress>?>(
                  stream: _presenter.emailState,
                  builder: (context, snapshot) {
                    return TextField(
                      enabled: !(loadingSnapshot.data == true),
                      textInputAction: TextInputAction.next,
                      onChanged: _presenter.onEmailChange,
                      keyboardType: TextInputType.emailAddress,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: VanillaColorScheme.black,
                          ),
                      cursorColor: VanillaColorScheme.dark,
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: VanillaColorScheme.light,
                            width: 0,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: VanillaColorScheme.error,
                            width: 0,
                          ),
                        ),
                        errorText: snapshot.data?.fold(
                          (l) {
                            switch (l) {
                              case ValidationError.empty:
                                return "Esse campo é obrigatório.";
                              case ValidationError.invalid:
                                return "Esse e-mail é inválido.";
                              default:
                                return null;
                            }
                          },
                          (r) => null,
                        ),
                        labelText: "Email",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(
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
                    );
                  }),
              const SizedBox(height: 8),
              StreamBuilder<Either<ValidationError, Password>?>(
                  stream: _presenter.passwordState,
                  builder: (context, snapshot) {
                    return TextField(
                      enabled: !(loadingSnapshot.data == true),
                      onEditingComplete: FocusScope.of(context).unfocus,
                      onChanged: _presenter.onPasswordChange,
                      obscureText: true,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: VanillaColorScheme.black,
                          ),
                      cursorColor: VanillaColorScheme.dark,
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: VanillaColorScheme.light,
                            width: 0,
                          ),
                        ),
                        errorText: snapshot.data?.fold(
                          (l) {
                            switch (l) {
                              case ValidationError.empty:
                                return "Esse campo é obrigatório.";
                              case ValidationError.invalid:
                                return "Senha inválida.";
                              case ValidationError.tooShort:
                                return "Senha curta demais.";
                            }
                          },
                          (r) => null,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: VanillaColorScheme.error,
                            width: 0,
                          ),
                        ),
                        labelText: "Senha",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(
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
                    );
                  }),
            ],
          );
        });
  }

  Row socialLoginButtons() {
    return Row(
      children: [
        MaterialButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          minWidth: 0,
          child: CircleAvatar(
            radius: 24,
            backgroundColor: VanillaColorScheme.medium.withOpacity(0.2),
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
            backgroundColor: VanillaColorScheme.medium.withOpacity(0.2),
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
            backgroundColor: VanillaColorScheme.medium.withOpacity(0.2),
            foregroundColor: VanillaColorScheme.black,
            child: Image.asset(
              "assets/icons/facebook.png",
              height: 20,
            ),
          ),
        ),
      ],
    );
  }
}
