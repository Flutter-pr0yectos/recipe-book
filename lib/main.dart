import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/recipes_provider.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:provider/provider.dart';

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
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Recipe Books'),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [Tab(icon: Icon(Icons.home), text: "Home")]
          ),
        ),
        body: TabBarView(children: [HomeScreen()]),
      ),
    );
  }
}
