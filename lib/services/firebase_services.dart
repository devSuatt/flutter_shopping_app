
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/models/product.dart';

class FirebaseServices {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Stream<List<Product>> getProducts() {
    return _firestore
      .collection('products')
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => Product.fromJson(doc.data())).toList()
      );
  }

  // Create-Update(Upsert)
  Future<void> setProduct(Product product) async{
    var options = SetOptions(merge: true);
    return await _firestore
      .collection('products')
      .doc(product.productId)
      .set(product.toMap(), options)
      .then((value) => print(product.productCode.toString()+" product eklendi/güncellendi"));
  }

  // Delete
  Future<void> deleteProduct(String productId) async{
    return await _firestore
      .collection('products')
      .doc(productId)
      .delete()
      .then((value) => print(productId.toString()+" silindi"));
  }

  Stream<List<Person>> getPersons() {
    return _firestore
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => Person.fromJson(doc.data())).toList()
      );
  }

  // Create-Update(Upsert)
  Future<void> setPerson(Person person) async{
    var options = SetOptions(merge: true);
    return await _firestore
      .collection('users')
      .doc(person.personId)
      .set(person.toMap(), options)
      .then((value) => print(person.personId.toString()+" user added / updated"));
  }

  // Delete
  Future<void> deletePerson(String personId) async{
    return await _firestore
      .collection('users')
      .doc(personId)
      .delete()
      .then((value) => print(personId.toString()+" deleted"));
  }

}