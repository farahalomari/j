import 'dart:convert';
import 'models/model.dart';
import 'package:http/http.dart' as http;

class ApiHandler{
  final String baseUri="https://localhost:7128/api/user";

  Future<List<User>> getUserData() async {
    List <User> data = [];

    final uri = Uri.parse(baseUri);
    try {
      final response = await http.get(
        uri,
        headers: <String,String>{
          'Content-type':'aplication/json ; charset=UTF-8'
        },
      );
      if(response.statusCode >= 200 && response.statusCode <=299){
        final List <dynamic> jsonData = json.decode(response.body);
        data = jsonData.map((json)=> User.fromJson(json)).toList();
      }
    } catch(e){

    }
    return data;

  }
  Future<http.Response> addUser({required User user}) async{
    final uri = Uri.parse(baseUri);
    late http.Response response;
    try{
      response = await http.post(uri,
        headers: <String,String>{
          'Content-type':'aplication/json ; charset=UTF-8'
        },
        body: json.encode(user),
      );
    }catch(e){
      return response;
    }
    return response;
  }

  Future<http.Response> forgetPass({required String phoneNumber}) async{
    final uri = Uri.parse(baseUri);
    late http.Response response;
    try{
      response = await http.post(uri,
        headers: <String,String>{
          'Content-type':'aplication/json ; charset=UTF-8'
        },
        body: json.encode(phoneNumber),
      );
    }catch(e){
      return response;
    }
    return response;
  }

  Future <http.Response> deleteUser({required int userID}) async{
    final uri = Uri.parse("$baseUri/$userID");
    late http.Response response;
    try{
      response = await http.delete(uri,
        headers: <String,String>{
          'Content-type':'aplication/json ; charset=UTF-8'
        },
      );
    }catch(e){
      return response;
    }
    return response;
  }

  Future<http.Response> changePass({required String phoneNumber}) async{
    final uri = Uri.parse(baseUri);
    late http.Response response;
    try{
      response = await http.post(uri,
        headers: <String,String>{
          'Content-type':'aplication/json ; charset=UTF-8'
        },
        body: json.encode(phoneNumber),
      );
    }catch(e){
      return response;
    }
    return response;
  }

}