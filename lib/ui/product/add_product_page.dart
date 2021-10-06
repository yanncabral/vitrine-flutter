// ignore_for_file: use_setters_to_change_properties

import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:uuid/uuid.dart';
import 'package:vitrine/main/factory/domain/usecases/add_product_factory.dart';
import 'package:vitrine/ui/design/components/vanilla_action_button.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';

class _AddProductState {
  String name = "";
  String description = "";
  double price = 0;
  List<File> images = [];
}

class AddProductViewModel {
  final state = _AddProductState();
  final addProduct = AddProductFactory.factory;

  void onNameChange(String name) {
    state.name = name;
  }

  void onDescriptionChange(String description) {
    state.description = description;
  }

  void onPriceChange(String price) {
    state.price = double.tryParse(price) ?? 0;
  }

  void onFilesChange(List<XFile> files) {
    state.images = files.map((e) => File(e.path)).toList();
  }

  Future<void> submit() async {
    final List<String> images = [];
    const uuid = Uuid();
    for (final e in state.images) {
      final saved = await FirebaseStorage.instance
          .ref()
          .child('images')
          .child(uuid.v4())
          .putFile(e);
      images.add(await saved.ref.getDownloadURL());
    }

    addProduct.addProduct(Product(
      name: state.name,
      description: state.description,
      price: state.price,
      images: images,
    ));
  }
}

class AddProductPage extends StatefulWidget {
  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  List<XFile>? _imageFileList;
  static final _presenter = AddProductViewModel();

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
              VanillaTextField(
                labelText: "Nome do produto",
                onChange: _presenter.onNameChange,
              ),
              const SizedBox(height: 8),
              VanillaTextField(
                labelText: "Descrição do produto",
                onChange: _presenter.onDescriptionChange,
              ),
              const SizedBox(height: 8),
              VanillaTextField(
                labelText: "Preço do produto",
                onChange: _presenter.onPriceChange,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () async {
                  final pickedFileList = await _picker.pickMultiImage();
                  setState(() {
                    _imageFileList = pickedFileList;
                    if (_imageFileList != null) {
                      _presenter.onFilesChange(_imageFileList!);
                    }
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
                    onPressed: () {
                      _presenter.submit();
                    },
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
  final void Function(String text) onChange;

  const VanillaTextField({
    Key? key,
    required this.labelText,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      // enabled: !(loadingSnapshot.data == true),
      textInputAction: TextInputAction.next,
      onChanged: onChange,
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
