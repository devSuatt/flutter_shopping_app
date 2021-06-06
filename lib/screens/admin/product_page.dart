import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/product.dart';
import 'package:hunters_group_project/providers/product_provider.dart';
import 'package:hunters_group_project/screens/admin/product_list.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  ProductPage({this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final productNameController = TextEditingController();
  final productUnitController = TextEditingController();
  final productCodeController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  final unitPriceController = TextEditingController();
  ProductProvider productProvider;

  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    if (widget.product != null) {
      // Edit
      productNameController.text = widget.product.productName;
      productUnitController.text = widget.product.productUnit;
      productCodeController.text = widget.product.productCode;
      productDescriptionController.text = widget.product.productDescription;
      imageUrlController.text = widget.product.imageUrl;
      unitPriceController.text = widget.product.unitPrice;
      productProvider.loadAllProducts(widget.product);
    } else {
      // Add
      productProvider.loadAllProducts(null);
    }
    super.initState();
  }

  @override
  void dispose() {
    productNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[600],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.product == null ? Text("New Product") : Text("Edit"),
            Row(
              children: [
                (widget.product != null)
                    ? Container(
                        width: 50,
                        margin: EdgeInsets.only(left: 7, top: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                          border: Border.all(color: Colors.white, width: 0.8),
                        ),
                        child: IconButton(
                          highlightColor: Colors.yellow,
                          color: Colors.white,
                          icon: Icon(
                            Icons.delete,
                            size: 30,
                          ),
                          onPressed: () {
                            showDialogDelete(context, productProvider.productCode, productProvider.productId);
                          },
                        ),
                      )
                    : Container(),
                Container(
                  width: 50,
                  margin: EdgeInsets.only(left: 7, top: 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(color: Colors.white, width: 0.8),
                  ),
                  child: IconButton(
                    highlightColor: Colors.yellow,
                    color: Colors.white,
                    icon: Icon(
                      Icons.save,
                      size: 30,
                    ),
                    onPressed: () {
                      productProvider.changeHasStock = true;
                      productProvider.saveProduct();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: ListView(children: <Widget>[
            Container(
              height: 13,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  productProvider.changeProductName = value;
                },
                controller: productNameController,
                style: TextStyle(fontSize: 19),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue[50],
                  labelText: "Product Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  productProvider.changeProductCode = value;
                },
                controller: productCodeController,
                style: TextStyle(fontSize: 19),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue[50],
                  labelText: "Product Code",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  productProvider.changeProductUnit = value;
                },
                controller: productUnitController,
                style: TextStyle(fontSize: 19),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue[50],
                  labelText: "Product Unit",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  productProvider.changeUnitPrice = value;
                },
                controller: unitPriceController,
                style: TextStyle(fontSize: 19),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue[50],
                  labelText: "Unit Price",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  productProvider.changeImageUrl = value;
                },
                controller: imageUrlController,
                style: TextStyle(fontSize: 19),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue[50],
                  labelText: "Product Image URL",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                maxLines: 3,
                onChanged: (String value) {
                  productProvider.changeProductDescription = value;
                },
                controller: productDescriptionController,
                style: TextStyle(fontSize: 19),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue[50],
                  labelText: "Product Description",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  showDialogDelete(BuildContext context, String name, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Not Kaydını Sil",
            style: TextStyle(color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(8),
              child: Text(name.toUpperCase() + " isimli ürünün kaydını \nsilmek istediğinize emin misiniz?"),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.red.shade700,
                  child: Text(
                    "Hayır",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    productProvider.removeProduct(id);
                    Navigator.pop(context);

                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProductList()),
                    );
                  },
                  color: Colors.green.shade700,
                  child: Text(
                    "Evet",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
