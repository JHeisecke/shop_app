import 'package:flutter/material.dart';

import '../../providers/product.dart';

class ProductFormScreen extends StatefulWidget {
  static const routeName = "/manage-products";
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var product = Product(
    id: null,
    title: '',
    description: '',
    imageUrl: '',
    price: 0.0,
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fomurlario de Productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Escriba una URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Url de Imagen'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.next,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onSaved: (imagen) {
                          product = Product(
                            id: null,
                            title: product.title,
                            description: product.description,
                            price: product.price,
                            imageUrl: imagen,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Título'),
                  textInputAction: TextInputAction.next,
                  onSaved: (titulo) {
                    product = Product(
                      id: null,
                      title: titulo,
                      description: product.description,
                      price: product.price,
                      imageUrl: product.imageUrl,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Precio'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onSaved: (precio) {
                    product = Product(
                      id: null,
                      title: product.title,
                      description: product.description,
                      price: double.parse(precio),
                      imageUrl: product.imageUrl,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Descripción'),
                  textInputAction: TextInputAction.done,
                  maxLines: 3,
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  onSaved: (description) {
                    product = Product(
                      id: null,
                      title: product.title,
                      description: description,
                      price: product.price,
                      imageUrl: product.imageUrl,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
