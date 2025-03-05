import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/recipes_provider.dart';
import 'package:flutter_application_1/screens/favorites_recipes.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) =>  RecipesProvider())
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate
          ],
          debugShowCheckedModeBanner: false,
          title: 'Hi everyone',
          home: RecipeBook(),
        )
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Recipe Books'),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.favorite), text: "Favoritos")
            ]
          ),
        ),
        body: TabBarView(children: [HomeScreen(), FavoritesRecipes()]),
      ),
    );
  }
}
