
import 'package:hunters_group_project/models/product.dart';
import 'package:hunters_group_project/services/firebase_services.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  final firestoreService = FirebaseServices();
  String _productId;
  String _productName;
  String _productDescription;
  String _imageUrl;
  int _rating;
  String _productCode;
  String _productUnit;
  String _unitPrice;
  bool _hasStock;
  var uuid = Uuid();

  String get productId => _productId;
  String get productName => _productName;
  String get productDescription => _productDescription;
  String get imageUrl => _imageUrl;
  int get rating => _rating;
  String get productCode => _productCode;
  String get productUnit => _productUnit;
  String get unitPrice => _unitPrice;
  Stream<List<Product>> get products => firestoreService.getProducts();

  set productId(String value) => _productId = value;
  set productName(String value) => _productName = value;
  set productDescription(String value) => _productDescription = value;
  set imageUrl(String value) => _imageUrl = value;
  set rating(int value) => _rating = value;
  set productCode(String value) => _productCode = value;
  set productUnit(String value) => _productUnit = value;
  set unitPrice(String value) => _unitPrice = value;

  set changeHasStock(bool hasStock) {
    _hasStock = hasStock;
    notifyListeners();
  }

  set changeProductCode(String productCode) {
    _productCode = productCode;
    notifyListeners();
  }

  set changeProductName(String productName) {
    _productName = productName;
    notifyListeners();
  }

  set changeProductDescription(String productDescription) {
    _productDescription = productDescription;
    notifyListeners();
  }

  set changeImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
    notifyListeners();
  }

  set changeRating(int rating) {
    _imageUrl = imageUrl;
    notifyListeners();
  }

  set changeProductUnit(String productUnit) {
    _productUnit = productUnit;
    notifyListeners();
  }

  set changeUnitPrice(String unitPrice) {
    _unitPrice = unitPrice;
    notifyListeners();
  }

  loadAllProducts(Product product) {
    if (product != null) {
      _productId = product.productId;
      _productName = product.productName;
      _productDescription = product.productDescription;
      _imageUrl = product.imageUrl;
      _rating = product.rating;
      _productCode = product.productCode;
      _productUnit = product.productUnit;
      _unitPrice = product.unitPrice;
      _hasStock = product.hasStock;
    } else {
      _productId = null;
      _productName = null;
      _productDescription = null;
      _imageUrl = "";
      _rating = null;
      _unitPrice = null;
      _productCode = null;
      _productUnit = null;
      _hasStock = null;
    }
  }

  saveProduct() {
    if (_productId == null) {
      // Add
      var newProduct = new Product(productId: uuid.v1(), productCode: _productCode, productName: _productName, productDescription: _productDescription, imageUrl: _imageUrl, rating: _rating, productUnit: _productUnit, unitPrice: _unitPrice, hasStock: _hasStock);
      firestoreService.setProduct(newProduct);
    } else {
      // Update
      var updatedProduct = new Product(productId: _productId, productCode: _productCode, productName: _productName, productDescription: _productDescription, imageUrl: _imageUrl, rating: _rating, productUnit: _productUnit, unitPrice: _unitPrice, hasStock: _hasStock);
      firestoreService.setProduct(updatedProduct);
    }
  }

  removeProduct(String productId) {
    firestoreService.deleteProduct(productId);
  }
}
