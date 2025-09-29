import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/add_edit_recipe_screen.dart';
import 'screens/category_browser_screen.dart';
import 'models/recipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CookBook",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case '/favorites':
            final args = settings.arguments as List<Recipe>;
            return MaterialPageRoute(
              builder: (_) => FavoritesScreen(favoriteRecipes: args),
            );
          case '/recipeDetail':
            final recipe = settings.arguments as Recipe;
            return MaterialPageRoute(
              builder: (_) => RecipeDetailScreen(recipe: recipe),
            );
          case '/settings':
            return MaterialPageRoute(builder: (_) => const SettingsScreen());
          case '/addRecipe':
            return MaterialPageRoute(builder: (_) => const AddEditRecipeScreen());
          case '/categories':
            return MaterialPageRoute(builder: (_) => const CategoryBrowserScreen());
          default:
            return null;
        }
      },
    );
  }
}
