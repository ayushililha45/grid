import 'dart:convert';
import 'package:http/http.dart';
import 'package:grid/model/apimodel.dart';

class ApiService {
  List<Todolist> list = [];
  Future<List<Todolist>> getData() async {
    var url = Uri.https(
      'jsonplaceholder.typicode.com',
      '/todos',
    );
    // var url =
    //     Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
    var response = await get(url);
    List<dynamic> values = [];
    values = json.decode(response.body);
    print(values.length);
    for (int i = 0; i < values.length; i++) {
      Map<String, dynamic> map = values[i];
      list.add(Todolist.fromJson(map));
    }
    return list;
  }
}
