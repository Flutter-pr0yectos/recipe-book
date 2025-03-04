import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/recippe_model.dart';
import 'package:flutter_application_1/providers/recipes_provider.dart';
import 'package:flutter_application_1/screens/recipe_detail.dart';
import 'package:provider/provider.dart';

class FavoritesRecipes extends StatelessWidget {  
  const FavoritesRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<RecipesProvider>(
        builder: (context, recipesProvider, child) {
          final favoriteRecipes = recipesProvider.favoriteRecipe;
          print('favoriteRecipes: $favoriteRecipes');
          return favoriteRecipes.isEmpty ?
            Center(child: Text('No favorites reciper'))
            : ListView.builder(                            
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index){
                final recipe = favoriteRecipes[index];
                return FavoriteRecipesCard(recipe: recipe);
              },
            );            
        },     
      ),
    );
  } 
}

class FavoriteRecipesCard extends StatelessWidget {
  final Recipe recipe;
  const FavoriteRecipesCard({super.key,required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetail(recipesData: recipe)));
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(recipe.name),
            Text(recipe.author)
          ],
        ),
      ),
    );
  }
}