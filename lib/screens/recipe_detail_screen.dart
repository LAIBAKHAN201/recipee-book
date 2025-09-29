import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  // Track checked ingredients
  late List<bool> _checkedIngredients;

  @override
  void initState() {
    super.initState();
    _checkedIngredients =
        List.generate(widget.recipe.ingredients.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // 🔝 Collapsing Image AppBar
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.recipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  widget.recipe.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    widget.recipe.isFavorite = !widget.recipe.isFavorite;
                  });
                },
              )
            ],
          ),

          // 📋 Details Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.recipe.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Rating + Category + Time
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 18),
                      Text(
                        " ${widget.recipe.rating}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade700,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.recipe.category,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.schedule, color: Colors.white70, size: 18),
                      Text(
                        " ${widget.recipe.time} min",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 🥘 Ingredients
                  const Text(
                    "Ingredients",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(widget.recipe.ingredients.length, (index) {
                    final ingredient = widget.recipe.ingredients[index];
                    return CheckboxListTile(
                      value: _checkedIngredients[index],
                      onChanged: (val) {
                        setState(() {
                          _checkedIngredients[index] = val ?? false;
                        });
                      },
                      title: Text(
                        ingredient,
                        style: TextStyle(
                          color: Colors.white,
                          decoration: _checkedIngredients[index]
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.orange,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  // 📖 Instructions
                  const Text(
                    "Instructions",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(widget.recipe.instructions.length, (index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.orange,
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        widget.recipe.instructions[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),

      // 🔥 Bottom Buttons
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.black,
        child: Row(
          children: [
            // 🔥 Start Cooking Button
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Handle Start Cooking flow
                },
                icon:
                    const Icon(Icons.local_fire_department, color: Colors.white),
                label: const Text("Start Cooking"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C4DFF), // Purple
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // ✏️ Edit Button
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF7C4DFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/addRecipe',
                    arguments: widget.recipe, // 👈 pass current recipe
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
