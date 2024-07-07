import 'dart:convert';
import 'models/model2.dart';
import 'package:http/http.dart' as http;

class ApiHandler2{
  final String baseUri="https://localhost:7128/api/Routes";

  Future<List<Route>> GetRoute() async {
    List <Route> data = [];

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
        data = jsonData.map((json)=> Route.fromJson(json)).toList();
      }
    } catch(e){

    }
    return data;

  }
  Future<http.Response> PostRoute({required Route route}) async{
    final uri = Uri.parse(baseUri);
    late http.Response response;
    try{
      response = await http.post(uri,
        headers: <String,String>{
          'Content-type':'aplication/json ; charset=UTF-8'
        },
        body: json.encode(route),
      );
    }catch(e){
      return response;
    }
    return response;
  }


  Future <http.Response> DeleteRoute({required int routeID}) async{
    final uri = Uri.parse("$baseUri/$routeID");
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

}