import 'dart:convert';
import 'models/model3.dart';
import 'package:http/http.dart' as http;

class ApiHandler2{
  final String baseUri="https://localhost:5432/api/Card";

  Future<List<Card>> getCard() async {
    List <Card> data = [];

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
        data = jsonData.map((json)=> Card.fromJson(json)).toList();
      }
    } catch(e){

    }
    return data;

  }
  Future<http.Response> addCard({required Card card}) async{
    final uri = Uri.parse(baseUri);
    late http.Response response;
    try{
      response = await http.post(uri,
        headers: <String,String>{
          'Content-type':'aplication/json ; charset=UTF-8'
        },
        body: json.encode(card),
      );
    }catch(e){
      return response;
    }
    return response;
  }


  Future <http.Response> deleteRoute({required int cardID}) async{
    final uri = Uri.parse("$baseUri/$cardID");
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