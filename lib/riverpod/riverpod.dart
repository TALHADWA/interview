import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview/Model/model.dart';

import 'package:http/http.dart'as http;

import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class GetData extends ChangeNotifier {
  List<Data> dataa = [];
  bool isLoading = false;
  String? errorMessage;

  /// Fetch data based on the country name
  Future<void> getData(String text) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse("https://restcountries.com/v3.1/name/$text"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse.isNotEmpty) {
          dataa = jsonResponse.map((e) => Data.fromJson(e)).toList();
        } else {
          dataa = [];
          errorMessage = "No countries found.";
        }
      } else {
        errorMessage = "Error: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage = "An error occurred: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}



final provider=ChangeNotifierProvider((red)=>GetData());

// final cv=FutureProvider((cv){
//   final text=cv.watch(state);
// return cv.read(provider).getData(text);
// });

// final state=StateProvider((ref)=>"");