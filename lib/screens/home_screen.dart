import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/recipes_provider.dart';
import 'package:flutter_application_1/screens/recipe_detail.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RecipesProvider>(context, listen: false).fetchRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: Consumer<RecipesProvider>(        
        builder: (context, provider, child){
          if(provider.isLoading){
            return const Center(child: CircularProgressIndicator());
          } else if(provider.recipes.isEmpty){
            return Center(child: Text(AppLocalizations.of(context)!.noRecipes));
          } else {
            return ListView.builder(
              itemCount: provider.recipes.length,
              itemBuilder: (context, index) {
                return recipesCard(context, provider.recipes[index]);
              }
            );
          }          
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showBottom(context);
        },
      ),
    );
  }

  Future<void> _showBottom(BuildContext contexto) {
    return showModalBottomSheet(
      context: contexto,
      isScrollControlled: true,
      builder: (contexto) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(contexto).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 650,
          width: MediaQuery.of(contexto).size.width,
          child: const RecipeForm(),
        ),
      ),
    );
  }

  Widget recipesCard(BuildContext context, dynamic recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => RecipeDetail(recipesData: recipe)
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: Card(
            child: Row(
              children: [
                SizedBox(
                  height: 125,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      recipe.image_link,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 26),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: const TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                    const SizedBox(height: 4),
                    Container(height: 2, width: 75, color: Colors.amber),
                    Text(
                      recipe.author,
                      style: const TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final TextEditingController recipeName = TextEditingController();
    final TextEditingController recipeAuthor = TextEditingController();
    final TextEditingController recipeIMG = TextEditingController();
    final TextEditingController recipeDescription = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Agregar Nueva Receta',
                style: TextStyle(color: Colors.orange, fontSize: 24),
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: recipeName,
                label: 'Nombre de la Receta',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre de la receta';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: recipeAuthor,
                label: 'Autor',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el autor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: recipeIMG,
                label: 'URL de la Imagen',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la URL de la imagen';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextField(
                maxLines: 4,
                controller: recipeDescription,
                label: 'Descripción de la Receta',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la descripción de la receta';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context, {
                        'nombre': recipeName.text,
                        'autor': recipeAuthor.text,
                        'imagen': recipeIMG.text,
                        'descripcion': recipeDescription.text,
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Guardar Receta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontFamily: 'Quicksand', color: Colors.orange),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      maxLines: maxLines,
      validator: validator,
    );
  }
}
