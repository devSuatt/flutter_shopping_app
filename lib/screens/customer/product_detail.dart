import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hunters_group_project/models/order.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/models/product.dart';
import 'package:hunters_group_project/screens/customer/purchase_page.dart';
import 'package:hunters_group_project/services/db_services.dart';
import 'package:hunters_group_project/shared/functions.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetailPage extends StatefulWidget {
  final Person person;
  final Product product;
  ProductDetailPage({this.person, this.product});
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  var rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.productName, style: TextStyle(color: Colors.orange[900], fontWeight: FontWeight.w200)),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      // drawer: CustomerDrawer(person: widget.person),
      body: Container(
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            productImage(widget.product.imageUrl),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Text(widget.product.productName, style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w300)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 13, vertical: 3),
              child: Text("Code: " + widget.product.productCode, style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w200)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: starRating(),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              child: Text(widget.product.unitPrice + " \$", style: TextStyle(fontSize: 30, color: Colors.purple[800], fontWeight: FontWeight.w300)),
            ),
            SizedBox(height: 10),
            purchaseButtons(),
            SizedBox(height: 20),
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: productFeatures(widget.product.productDescription).length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Divider(endIndent: 20, indent: 20, thickness: 0.5),
                      Text(productFeatures(widget.product.productDescription)[index], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
                    ],
                  );
                },
              ),
            ),
            Divider(endIndent: 20, indent: 20, thickness: 0.7),
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text("Description: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.orange[900])),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: productDescription(widget.product.productDescription) ?? Text(""),
            ),
          ],
        ),
      ),
    );
  }

  Widget productImage(String imageUrl) {
    return Container(
      margin: EdgeInsets.all(8),
      width: 200,
      height: 200,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        image: new DecorationImage(
          fit: BoxFit.contain,
          image: new NetworkImage(imageUrl),
        ),
      ),
    );
  }

  Widget starRating() {
    return SmoothStarRating(
      rating: 4,
      isReadOnly: false,
      size: 30,
      color: Colors.orange[400],
      borderColor: Colors.orange[400],
      filledIconData: Icons.star,
      halfFilledIconData: Icons.star_half,
      defaultIconData: Icons.star_border,
      starCount: 5,
      allowHalfRating: true,
      spacing: 2.0,
      onRated: (value) {
        print("rating value -> $value");
        // print("rating value dd -> ${value.truncate()}");
      },
    );
  }

  List<String> productFeatures(String description) {
    List<String> features = description.split(' (+) ');
    String featureHeader = features[0];
    List<String> featureElements = featureHeader.split(' , ');
    return featureElements;
  }

  productDescription(String description) {
    List<String> features = description.split(' (+) ');
    return Text(features[1], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300));
  }

  Widget purchaseButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      SizedBox(
        width: 140,
        child: TextButton(
          child: Text("Add to cart".toUpperCase(), style: TextStyle(fontSize: 14)),
          style: purchaseButtonStyle(Colors.white, Colors.orange[800], Colors.orange[800]),
          onPressed: () async {
            Order basketOrder = new Order(
              orderId: "",
              customerName: widget.person.userName,
              customerId: widget.person.personId,
              productName: widget.product.productName,
              productId: widget.product.productId,
              orderDate: DateTime.now().toString(),
              price: widget.product.unitPrice,
              status: "basket",
            );
            // await DatabaseServices(uid: widget.person.personId).setOrder(basketOrder);
            
          },
        ),
      ),
      SizedBox(width: 10),
      Container(
        margin: EdgeInsets.only(right: 12),
        width: 140,
        child: ElevatedButton(
            child: Text("Buy now".toUpperCase(), style: TextStyle(fontSize: 14)),
            style: purchaseButtonStyle(Colors.orange[800], Colors.white, Colors.orange[800]),
            onPressed: () async {
              Order newOrder = new Order(
                orderId: "",
                customerName: widget.person.userName,
                customerId: widget.person.personId,
                productName: widget.product.productName,
                productId: widget.product.productId,
                orderDate: DateTime.now().toString(),
                price: widget.product.unitPrice,
                status: "purchased",
              );
              showDialogOrder(context, newOrder);
            }),
      )
    ]);
  }

  showDialogOrder(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.orange[700],
          title: Text(
            "ORDER",
            style: TextStyle(color: Colors.red[50], fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          children: [
            Divider(color: Colors.white, endIndent: 10, indent: 10),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.all(8),
              child: Text(
                "Are you sure you want to buy?",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
            Divider(color: Colors.white, endIndent: 10, indent: 10),
            textTemplate("Product: " + order.productName),
            textTemplate("Price: " + order.price),
            textTemplate("Date: " + formatDate(DateTime.parse(order.orderDate), [dd, '/', mm, '/', yyyy])),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: purchaseButtonStyle(Colors.red, Colors.red, Colors.white),
                    child: Text(
                      "NO",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      await DatabaseServices(uid: widget.person.personId).setOrder(order);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PurchasePage(order: order, person: widget.person)));
                    },
                    style: purchaseButtonStyle(Colors.green, Colors.green, Colors.white),
                    child: Text(
                      "YES",
                      style: TextStyle(
                        color: Colors.white,
                      ),
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

  Widget textTemplate(String text) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(5),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
      ),
    );
  }
}
