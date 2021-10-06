import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitrine/ui/design/components/vanilla_action_button.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';

class AddProductPage extends StatefulWidget {
  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  List<XFile>? _imageFileList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Adicionar produto",
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.copyWith(color: VanillaColorScheme.black),
              ),
              const SizedBox(height: 32),
              const VanillaTextField(labelText: "Nome do produto"),
              const SizedBox(height: 8),
              const VanillaTextField(labelText: "Descrição do produto"),
              const SizedBox(height: 8),
              const VanillaTextField(labelText: "Preço do produto"),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () async {
                  final pickedFileList = await _picker.pickMultiImage();
                  setState(() {
                    _imageFileList = pickedFileList;
                  });
                },
                child: Text(
                  "Selecionar imagens",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: VanillaColorScheme.secondary),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _imageFileList
                        ?.map(
                          (e) => FractionallySizedBox(
                            widthFactor: 0.2,
                            child: Image.file(File(e.path)),
                          ),
                        )
                        .toList() ??
                    [],
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  VanillaActionButton(
                    title: "Adicionar",
                    onPressed: () => Navigator.of(context).pushNamed("/auth"),
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

  final ImagePicker _picker = ImagePicker();
}

class VanillaTextField extends StatelessWidget {
  final String labelText;

  const VanillaTextField({
    Key? key,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      // enabled: !(loadingSnapshot.data == true),
      textInputAction: TextInputAction.next,
      // onChanged: _presenter.onEmailChange,
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
        // errorText: snapshot.data?.fold(
        //   (l) {
        //     switch (l) {
        //       case ValidationError.empty:
        //         return "Esse campo é obrigatório.";
        //       case ValidationError.invalid:
        //         return "Esse e-mail é inválido.";
        //       default:
        //         return null;
        //     }
        //   },
        //   (r) => null,
        // ),
        labelText: labelText,
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
    );
  }
}
