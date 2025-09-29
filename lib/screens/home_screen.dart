import 'package:flutter/material.dart';
import '../utils/sample_data.dart';
import '../widgets/recipe_card.dart';
import '../widgets/chip_filter.dart';
import '../widgets/section_header.dart';
import '../models/recipe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";
  final categories = ["All", "Breakfast", "Lunch", "Dinner", "Dessert"];

  // ✅ Filtered list based on category
  List<Recipe> get filteredRecipes {
    if (selectedCategory == "All") return sampleRecipes;
    return sampleRecipes.where((r) => r.category == selectedCategory).toList();
  }

  // ✅ Toggle favorite
  void toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("CookBook"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              final favorites =
                  sampleRecipes.where((r) => r.isFavorite).toList();
              Navigator.pushNamed(
                context,
                '/favorites',
                arguments: favorites,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings), // ⚙ Settings button
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade900,
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  hintText: "Search recipes...",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // 🔖 Category Chips
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: categories.map((cat) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChipFilter(
                      label: cat,
                      isSelected: selectedCategory == cat,
                      onTap: () {
                        setState(() => selectedCategory = cat);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            // ⭐ Featured Section
            const SectionHeader(title: "Featured"),
            RecipeCard(
              recipe: sampleRecipes.first,
              onFavoriteToggle: () => toggleFavorite(sampleRecipes.first),
            ),

            // 🔥 Popular Recipes
            const SectionHeader(title: "Popular Recipes"),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                return RecipeCard(
                  recipe: filteredRecipes[index],
                  onFavoriteToggle: () =>
                      toggleFavorite(filteredRecipes[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
