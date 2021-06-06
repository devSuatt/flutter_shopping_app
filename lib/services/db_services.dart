import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hunters_group_project/models/order.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/models/user.dart';
import 'package:uuid/uuid.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices({this.uid});
  var uuid = Uuid();

  FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future setUserData(Person person) async {
    return await usersCollection.doc(uid).set(person.toMap());
  }

  Stream<Person> get userData {
    return usersCollection.doc(uid).snapshots().map((DocumentSnapshot snapshot) => Person.fromJson(snapshot.data()));
  }

  Future setOrder(Order order) async {
    print("setOrder...");
    if (order.orderId == "" || order.orderId == null) {
      order.orderId = uuid.v1();
      await usersCollection.doc(uid).collection('orders').doc(order.orderId).set(order.toMap()).then((value) {
        print("order has been added");
      });
    } else {
      await usersCollection.doc(uid).collection('orders').doc(order.orderId).set(order.toMap()).then((value) {
      print("order has been updated");
    });
    }
    
  }

  Stream<List<Order>> get orders {
    return usersCollection
      .doc(uid)
      .collection('orders') 
      .orderBy('orderDate', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => Order.fromJson(doc.data())).toList()
      );
  }

  Stream<List<Order>> get allOrders {
    return FirebaseFirestore.instance
    .collectionGroup('orders')
    .snapshots()
    .map((snapshot) => snapshot.docs
    .map((doc) => Order.fromJson(doc.data())).toList()
      );
  }

  Future changeOrdersReadyState(Order order) async {
    Order updatedOrder = Order(orderId: order.orderId, customerName: order.customerName, 
    orderDate: order.orderDate, customerId: order.customerId, 
    price: order.price, productId: order.orderId, productName: order.productName, status: "ready");

    return await usersCollection
    .doc(order.customerId)
    .collection('orders')
    .doc(updatedOrder.orderId)
    .set(updatedOrder.toMap())
    .then((value) => print("order is ready"));
  
  }

}
