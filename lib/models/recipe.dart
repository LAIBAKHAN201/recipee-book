class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final String category;
  final double rating;
  final int time;
  final List<String> ingredients;
  final List<String> instructions;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.time,
    required this.ingredients,
    required this.instructions,
    this.isFavorite = false,
  });
}
