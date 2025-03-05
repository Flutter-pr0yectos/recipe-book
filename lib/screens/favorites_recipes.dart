import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/recippe_model.dart';
import 'package:flutter_application_1/providers/recipes_provider.dart';
import 'package:flutter_application_1/screens/recipe_detail.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            Center(child: Text(AppLocalizations.of(context)!.noRecipes))
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
      child: Semantics(
        label: 'Tarjeta de recetas',
        hint: 'Toca para ver detalle de receta ${recipe.name}',
        child: Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Card(
            color: Colors.white,
            child: Row(
              children: [
                Column(                    
                  crossAxisAlignment: CrossAxisAlignment.start,                
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Text(recipe.name),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4, left: 15, right: 15),
                      child: Text('by ${recipe.author}'),
                    ),         
                  ],
                ),
                Spacer(),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      recipe.image_link,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      )
      )
    );
  }
}