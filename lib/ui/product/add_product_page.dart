// ignore_for_file: use_setters_to_change_properties

import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:vitrine/domain/entities/product.dart';

import 'package:vitrine/main/factory/domain/usecases/add_product_factory.dart';
import 'package:vitrine/ui/design/components/vanilla_action_button.dart';
import 'package:vitrine/ui/design/components/vanilla_text_field.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';
import 'package:vitrine/view_model/stream_controller/strem_controller_view_model/stream_controller_view_model.dart';

class _AddProductState {
  String name = "";
  String description = "";
  double price = 0;
  List<File> images = [];
  bool isLoading = false;
  bool get isFormValid => [
        name.length > 2,
        description.length > 2,
        price > 0,
        images.isNotEmpty,
      ].every((element) => element == true);
}

class AddProductViewModel extends StreamControllerViewModel<_AddProductState> {
  final addProduct = AddProductFactory.factory;

  Stream<bool?> get isLoading =>
      controller.stream.map((state) => state.isLoading).distinct();
  Stream<bool?> get isFormValid =>
      controller.stream.map((state) => state.isFormValid).distinct();

  void onNameChange(String name) {
    setState(() {
      state.name = name;
    });
  }

  void onDescriptionChange(String description) {
    setState(() {
      state.description = description;
    });
  }

  void onPriceChange(String price) {
    setState(() {
      state.price = double.tryParse(price) ?? 0;
    });
  }

  void onFilesChange(List<XFile> files) {
    setState(() {
      state.images = files.map((e) => File(e.path)).toList();
    });
  }

  Future<void> submit(void Function() callback) async {
    setState(() {
      state.isLoading = true;
    });
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
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
      // addProduct.addProduct(
      //   Product(
      //     name: state.name,
      //     description: state.description,
      //     price: state.price,
      //     images: images,
      //     ownerId: userId,
      //   ),
      // );
      setState(() {
        state.isLoading = false;
      });
      callback();
    }
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
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
                          StreamBuilder<bool?>(
                              stream: _presenter.isFormValid,
                              builder: (context, formValidSnapshot) {
                                return StreamBuilder<bool?>(
                                    stream: _presenter.isLoading,
                                    builder: (context, loadingSnapshot) {
                                      return VanillaActionButton(
                                        enabled: loadingSnapshot.data != true &&
                                            formValidSnapshot.data == true,
                                        title: "Adicionar",
                                        onPressed: () async {
                                          await _presenter.submit(() {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        colorScheme: Brightness.dark,
                                      );
                                    });
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();
}
