import 'dart:convert';
import 'package:llama/models/results_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPage extends StatefulWidget {
  const ApiPage({Key key}) : super(key: key);
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  Future<List<User>> _listaUsers;
  Future<List<User>> _obtenerUsers() async {
    List<User> users = [];
    final respose =
        await http.get(Uri.parse('https://randomuser.me/api/?results=25'));
    if (respose.statusCode == 200) {
      String body = utf8.decode(respose.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData['results']) {
        users.add(User(
            name: item['name']['first'],
            last: item['name']['last'],
            picture: item['picture']['large'],
            ciudad: item['location']['city']));
      }
    } else {
      throw Exception('Fallo la llamada a la API');
    }
    return users;
  }

  @override
  void initState() {
    super.initState();
    _listaUsers = _obtenerUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange, title: Text('Llamada a API- alexis')),
      body: Center(
        child: FutureBuilder(
          future: _listaUsers,
          initialData: List<User>.empty(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: _listadoUsers(snapshot.data),
              );
            } else if (snapshot.error) {
              print(snapshot.error);
              print('Error al conectar a la API');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _listadoUsers(List<User> data) {
    List<Widget> userList = [];
    for (var user in data) {
      userList.add(Card(
          child: Column(
        children: [
          CircleAvatar(
            radius: 75,
            backgroundImage: NetworkImage(
              user.picture,
            ),
          ),
          Text(
            'Nombre: ' + user.name + ' ' + user.last,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.orange),
          ),
          Text(
            'Ciudad: ' + user.ciudad,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blueAccent),
          )
        ],
      )));
    }
    return userList;
  }
}
