import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'rating_stars.dart';
import 'badge.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onFavoriteToggle;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/recipeDetail', arguments: recipe);
      },
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                children: [
              
                  Image.network(
                    recipe.imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
      
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 120,
                        color: Colors.grey[800],
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.orange),
                        ),
                      );
                    },
                    
            
                    // errorBuilder: (context, error, stackTrace) {
                    //   return Container(
                    //     height: 120,
                    //     color: Colors.grey[800],
                    //     child: const Center(
                    //       child: Icon(Icons.broken_image, color: Colors.white70, size: 40),
                    //     ),
                    //   );
                    // },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Icon(
                        recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: recipe.isFavorite ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 📄 Recipe Info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  RatingStars(rating: recipe.rating),
                  const SizedBox(height: 4),
                  BadgeWidget(text: "${recipe.time}m"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
