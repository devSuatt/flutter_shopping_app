import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/models/product.dart';
import 'package:hunters_group_project/providers/product_provider.dart';
import 'package:hunters_group_project/screens/admin/product_page.dart';
import 'package:hunters_group_project/screens/admin_drawer.dart';
import 'package:hunters_group_project/shared/functions.dart';
import 'package:hunters_group_project/shared/loading.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

DateTime today = DateTime.now();

class ProductList extends StatefulWidget {
  final Product product;
  final Person person;
  ProductList({this.product, this.person});
  static List<Product> productList = new List<Product>();

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<ProductList> {
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
      drawer: AdminDrawer(person: widget.person),
      appBar: myAppBar(
        "Product List",
        true,
        onTap: () {
          Navigator.pushNamed(context, 'ProductPage');
        },
        myIcon: Icons.add,
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
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 4, left: 5, right: 5, bottom: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blue, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ExpansionTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: GestureDetector(
                              onTap: () {
                                showDialogPitcureDetail(context, products[index]);
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(products[index].imageUrl),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_down),
                          title: Text(
                            products[index].productName.toUpperCase(),
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Container(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              "Product Code = ${products[index].productCode}",
                              style: TextStyle(color: Colors.pink[800]),
                            ),
                          ),
                          children: [
                            line(),
                            productDetailLine("Unit Price: ${products[index].unitPrice} \$"),
                            line(),
                            productDetailLine("Stock Status: ${products[index].hasStock ? "YES" : "NO"}"),
                            line(),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 120,
                                  child: FlatButton(
                                    onPressed: () {
                                      showDialogDelete(context, snapshot.data[index]);
                                      setState(() {});
                                    },
                                    color: Colors.red,
                                    child: Text("DELETE"),
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ProductPage(product: snapshot.data[index]),
                                        ),
                                      );
                                    },
                                    color: Colors.green,
                                    child: Text("UPDATE"),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
