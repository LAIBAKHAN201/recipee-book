import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Recipe> favoriteRecipes;

  const FavoritesScreen({super.key, required this.favoriteRecipes});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<Recipe> displayedFavorites;
  String selectedSort = "Cook time (low → high)";

  @override
  void initState() {
    super.initState();
    displayedFavorites = List.from(widget.favoriteRecipes);
    _sortRecipes(); // default sort
  }

  void _sortRecipes() {
    setState(() {
      if (selectedSort == "Rating (high → low)") {
        displayedFavorites.sort((a, b) => b.rating.compareTo(a.rating));
      } else if (selectedSort == "Cook time (low → high)") {
        displayedFavorites.sort((a, b) => a.time.compareTo(b.time));
      } else if (selectedSort == "Title (A → Z)") {
        displayedFavorites.sort((a, b) => a.title.compareTo(b.title));
      }
    });
  }

  void _openSortOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Sort by",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: Colors.grey),
                  ListTile(
                    title: const Text("Rating (high → low)",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      setState(() => selectedSort = "Rating (high → low)");
                      _sortRecipes();
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(color: Colors.grey),
                  ListTile(
                    title: const Text("Cook time (low → high)",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      setState(() => selectedSort = "Cook time (low → high)");
                      _sortRecipes();
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(color: Colors.grey),
                  ListTile(
                    title: const Text("Title (A → Z)",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      setState(() => selectedSort = "Title (A → Z)");
                      _sortRecipes();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: Colors.black,
        actions: [
          TextButton.icon(
            onPressed: _openSortOptions,
            icon: const Icon(
              Icons.filter_list,
              color: Colors.purple, // 🔥 Purple icon
            ),
            label: Text(
              selectedSort,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: displayedFavorites.isEmpty
          ? const Center(
              child: Text(
                "No favorites yet!",
                style: TextStyle(color: Colors.white),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: displayedFavorites.length,
              itemBuilder: (context, index) {
                return RecipeCard(
                  recipe: displayedFavorites[index],
                  onFavoriteToggle: () {
                    setState(() {
                      displayedFavorites[index].isFavorite =
                          !displayedFavorites[index].isFavorite;
                      displayedFavorites = displayedFavorites
                          .where((r) => r.isFavorite)
                          .toList();
                    });
                  },
                );
              },
            ),
    );
  }
}
