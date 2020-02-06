import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/models/product.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class EditProductsScreen extends StatefulWidget {
  static const routeName = '/editProducts';
  @override
  _State createState() => _State();
}

class _State extends State<EditProductsScreen> {
  final _price = FocusNode();
  final _desc = FocusNode();
  final _imageUrl = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  var _editProduct =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');
  var _isInit = true;
  var _isInitValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  @override
  void initState() {
    _imageUrl.addListener(_updateImageurl);
    super.initState();
  }

  // to avoid the memory leak and to dispose the state
  @override
  void dispose() {
    _imageUrl.removeListener(_updateImageurl);
    _price.dispose();
    _desc.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageurl() {
    if (!_imageUrl.hasFocus) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var id = ModalRoute.of(context).settings.arguments as String;
      if (id != null) {
        var product =
            Provider.of<Products>(context, listen: false).findById(id);
        _editProduct = product;
        _isInitValues = {
          'title': product.title,
          'description': product.description,
          'price': product.price.toString(),
          'imageUrl': ''
        };
        _imageUrlController.text = _editProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _submitForm() {
    final isValid = _formState.currentState.validate();
    if (!isValid) {
      return null;
    }
    _formState.currentState.save();
    if (_editProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateItems(_editProduct.id, _editProduct);
      Navigator.of(context).pop();
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editProduct);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _submitForm)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formState,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _isInitValues['title'],
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_price);
                  },
                  onSaved: (value) {
                    _editProduct = Product(
                        title: value,
                        id: _editProduct.id,
                        isFavorite: _editProduct.isFavorite,
                        price: _editProduct.price,
                        description: _editProduct.description,
                        imageUrl: _editProduct.imageUrl);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Provide The Value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _isInitValues['price'],
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _price,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_desc);
                  },
                  onSaved: (value) {
                    _editProduct = Product(
                        isFavorite: _editProduct.isFavorite,
                        title: _editProduct.title,
                        id: _editProduct.id,
                        price: double.parse(value),
                        description: _editProduct.description,
                        imageUrl: _editProduct.imageUrl);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Provide The Value';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please Enter Valid Price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _isInitValues['description'],
                  decoration: InputDecoration(labelText: 'Description'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  onSaved: (value) {
                    _editProduct = Product(
                        title: _editProduct.title,
                        id: _editProduct.id,
                        price: _editProduct.price,
                        description: value,
                        isFavorite: _editProduct.isFavorite,
                        imageUrl: _editProduct.imageUrl);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Provide The Description';
                    }
                    if (value.length < 10) {
                      return 'Description Length Should Be 10 Charcters Long';
                    }
                    return null;
                  },
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Image Url')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                              )),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image Url'),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        focusNode: _imageUrl,
                        onFieldSubmitted: (_) {
                          _submitForm();
                        },
                        onSaved: (value) {
                          _editProduct = Product(
                              title: _editProduct.title,
                              isFavorite: _editProduct.isFavorite,
                              id: _editProduct.id,
                              price: _editProduct.price,
                              description: _editProduct.description,
                              imageUrl: value);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Provide The Value';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
