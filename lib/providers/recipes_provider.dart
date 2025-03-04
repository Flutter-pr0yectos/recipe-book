import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/recippe_model.dart';

import 'package:http/http.dart' as http;

class RecipesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Recipe> recipes = [];

  Future<void> fetchRecipes() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('http://10.0.2.2:1234/recipes');
    try {
      final response = await http.get(url);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        recipes += List<Recipe>.from(data['recipes']
        .map((recipe) => Recipe.fromJSON(recipe)));
      }else{
        print('Error ${response.statusCode}');
        recipes = [];
      }
    } catch(e){
      print('Error in request');
      recipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }         
  }
}