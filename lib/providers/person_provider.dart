
import 'package:flutter/cupertino.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/services/firebase_services.dart';
import 'package:uuid/uuid.dart';

class PersonProvider with ChangeNotifier {
  final firebaseService = FirebaseServices();
  String _personId;
  String _userName;
  String _email;
  String _address;
  String _imageUrl;
  bool _isAdmin;
  String _password;
  var uuid = Uuid();

  String get userName => _userName;
  String get personId => _personId;
  String get email => _email;
  String get address => _address;
  String get imageUrl => _imageUrl;
  bool get isAdmin => _isAdmin;
  String get password => _password;
  Stream<List<Person>> get users => firebaseService.getPersons();

  set personId(String value) => _personId = value;

  set changeUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  set changeAddress(String address) {
    _address = address;
    notifyListeners();
  }

  set changeEmail(String email) {
    _email = email;
    notifyListeners();
  }

  set changePassword(String password) {
    _password = password;
    notifyListeners();
  }

  loadAllPersons(Person person) {
    if (person != null) {
      _personId = person.personId;
      _userName = person.userName;
      _email = person.email;
      _isAdmin = person.isAdmin;
      _imageUrl = person.imageUrl;
      _address = person.address;
      _password = person.password;
    
    } else {
      _personId = "";
      _userName = "";
      _email = "";
      _isAdmin = false;
      _imageUrl = "";
      _address = "";
      _password = "";
    }
  }

  savePerson() {
    if(_personId == null) {
      print("newwwwwww");
      var newPerson = new Person(personId: uuid.v1(), userName: _userName, address: _address, email: _email, imageUrl: _imageUrl, isAdmin: _isAdmin, password: _password);
      firebaseService.setPerson(newPerson);
    } else {
      print("updateeeeee");
      var updatePerson = new Person(personId: _personId, userName: _userName, address: _address, email: _email, imageUrl: _imageUrl, isAdmin: _isAdmin, password: _password);
      firebaseService.setPerson(updatePerson);
    }
  }

  removePerson(String personId) {
    firebaseService.deletePerson(personId);
  }

}
