import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/models/product.dart';
import 'package:hunters_group_project/providers/product_provider.dart';
import 'package:hunters_group_project/screens/admin/product_page.dart';
import 'package:hunters_group_project/screens/admin_drawer.dart';
import 'package:hunters_group_project/screens/customer/product_detail.dart';
import 'package:hunters_group_project/screens/customer_drawer.dart';
import 'package:hunters_group_project/shared/functions.dart';
import 'package:hunters_group_project/shared/loading.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

DateTime today = DateTime.now();

class Products extends StatefulWidget {
  final Person person;
  final Product product;
  Products({this.product, this.person});
  static List<Product> products = new List<Product>();

  @override
  ProductsState createState() => ProductsState();
}

class ProductsState extends State<Products> {
  ProductProvider productProvider;
  int totalDebitValue;
  final totalDebitController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.loadAllProducts(widget.product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.blue[50],
      drawer: CustomerDrawer(person: widget.person),
      appBar: myAppBar(
        "All Products",
        false,
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: StreamBuilder<List<Product>>(
              stream: productProvider.products,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Product> products = snapshot.data ?? [];
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 7 / 8,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => ProductDetailPage(person: widget.person, product: products[index])));
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: boxDecoration(20, Colors.blue),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(8),
                                width: 120,
                                height: 120,
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(products[index].imageUrl),
                                  ),
                                ),
                              ),
                              Text(products[index].productName, style: TextStyle(fontSize: 16)),
                              Container(
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.fromLTRB(0, 4, 22, 0),
                                child: Text(products[index].unitPrice + " \$", style: TextStyle(fontSize: 14, color: Colors.orange[800])),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Loading();
                }
              },
            ),
          ),
          clipPath(),
        ],
      ),
    );
  }

  bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  showDialogDelete(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Delete Product",
            style: TextStyle(color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(8),
              child: Text("Are you sure \nyou want to delete product " + product.productCode.toUpperCase() + " ?"),
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
                    "NO",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    productProvider.removeProduct(product.productId);
                    Navigator.pop(context);

                    scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text(
                        "Product " + product.productCode.toUpperCase() + " has been deleted.",
                        style: TextStyle(color: Colors.white),
                      ),
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.red[700],
                    ));
                  },
                  color: Colors.green.shade700,
                  child: Text(
                    "YES",
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

  Widget productDetailLine(String text) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          color: Colors.blue[900],
        ),
      ),
    );
  }

  Widget line() {
    return Divider(
      indent: 20,
      endIndent: 20,
      thickness: 1,
    );
  }

  showDialogPitcureDetail(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            product.productCode.toUpperCase(),
            style: TextStyle(color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
          children: [
            Container(
              width: 190.0,
              height: 190.0,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage(
                      "https://cdn03.ciceksepeti.com/cicek/kc8106381-1/XL/brillant-siyah-beyaz-gecisli-zebra-perde-100x200-kc8106381-1-93d4843e214f4c1e8d3831405e194301.jpg"),
                ),
              ),
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
                    "CLOSE",
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

  Color createRandomColor() {
    return Color.fromRGBO(
      math.Random().nextInt(255),
      math.Random().nextInt(255),
      math.Random().nextInt(50),
      1,
    );
  }
}
