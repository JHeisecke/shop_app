import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product.dart';
import '../../providers/products_state.dart';

class ProductFormScreen extends StatefulWidget {
  static const routeName = "/products-form";
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'imageUrl': '',
    'price': '',
  };
  var _product = Product(
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
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _product = Provider.of<ProductsState>(context, listen: false)
            .findById(productId);
        _initValues = {
          'title': _product.title,
          'description': _product.description,
          'imageUrl': '',
          'price': _product.price.toString(),
        };
        _imageUrlController.text = _product.imageUrl;
        _isInit = false;
      }
    }
    super.didChangeDependencies();
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
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_product.id == null) {
      Provider.of<ProductsState>(
        context,
        listen: false,
      ).addProduct(
        _product,
      );
    } else {
      Provider.of<ProductsState>(
        context,
        listen: false,
      ).updateProduct(
        _product,
      );
    }

    Navigator.of(context).pop();
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
                          _product = Product(
                            id: _product.id,
                            isFavorite: _product.isFavorite,
                            title: _product.title,
                            description: _product.description,
                            price: _product.price,
                            imageUrl: imagen,
                          );
                        },
                        validator: (url) {
                          if (url == null || url.isEmpty) {
                            return 'Url es obligatoria.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(labelText: 'Título'),
                  textInputAction: TextInputAction.next,
                  onSaved: (titulo) {
                    _product = Product(
                      id: _product.id,
                      isFavorite: _product.isFavorite,
                      title: titulo,
                      description: _product.description,
                      price: _product.price,
                      imageUrl: _product.imageUrl,
                    );
                  },
                  validator: (titulo) {
                    if (titulo == null || titulo.isEmpty) {
                      return 'Título es obligatorio.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(labelText: 'Precio'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onSaved: (precio) {
                    _product = Product(
                      id: _product.id,
                      isFavorite: _product.isFavorite,
                      title: _product.title,
                      description: _product.description,
                      price: double.parse(precio),
                      imageUrl: _product.imageUrl,
                    );
                  },
                  validator: (precio) {
                    if (precio == null || precio.isEmpty) {
                      return 'Debe agregar un precio.';
                    }
                    if (double.tryParse(precio) == null ||
                        double.parse(precio) < 0) {
                      return 'Debe ingresar un precio válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(labelText: 'Descripción'),
                  textInputAction: TextInputAction.done,
                  maxLines: 3,
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  onSaved: (description) {
                    _product = Product(
                      id: _product.id,
                      isFavorite: _product.isFavorite,
                      title: _product.title,
                      description: description,
                      price: _product.price,
                      imageUrl: _product.imageUrl,
                    );
                  },
                  validator: (descripcion) {
                    if (descripcion == null || descripcion.isEmpty) {
                      return 'Descripción es obligatorio.';
                    }
                    return null;
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
