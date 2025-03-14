import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/recippe_model.dart';
import 'package:flutter_application_1/providers/recipes_provider.dart';
import 'package:provider/provider.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipesData;
  const RecipeDetail({super.key, required this.recipesData});

  @override
  RecipeDetailState createState() => RecipeDetailState();
}

class RecipeDetailState extends State<RecipeDetail> with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this,
      duration: Duration(milliseconds: 300)
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),

    )..addStatusListener((status){
      if(status == AnimationStatus.completed){
        controller.reverse();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipesProvider>(
      context,
      listen: false,
    ).favoriteRecipe.contains(widget.recipesData);
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipesData.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<RecipesProvider>(
                context,
                listen: false,
              ).toggleFavoritesStatus(widget.recipesData);
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: ScaleTransition(
              scale: scaleAnimation,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,                
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Image.network(widget.recipesData.image_link),
            SizedBox(height: 8),
            Text(widget.recipesData.name),
            SizedBox(height: 8),
            Text("by ${widget.recipesData.author}"),
            SizedBox(height: 8),
            const Text('Recipe steaps: '),
            for (var step in widget.recipesData.recipeSteps) Text("- $step"),
          ],
        ),
      ),
    );
  }
}
