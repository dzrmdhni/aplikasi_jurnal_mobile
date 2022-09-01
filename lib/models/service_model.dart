import 'package:aplikasi_journal_2/models/journal_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchJournalList {
  var data = [];
  List<Journal> results = [];
  String urlList = 'https://serpapi.com/search.json?engine=google_scholar&q=biology&api_key=44f74c6cf10a1aca892c7fde4d47c959a537f0f36af9420041a409d744c6d07f';


Future<List<Journal>> getJournalData({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
      
        data = json.decode(response.body);
        results = data.map((e) => Journal.fromJson(e)).toList();
        if (query!= null){
          results = results.where((element) => element.title.toLowerCase().contains((query.toLowerCase()))).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}