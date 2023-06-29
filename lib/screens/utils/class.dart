import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Nutrients {
  String name;
  String weight;
  double percent;
  Nutrients({required this.name, required this.weight, required this.percent});
}

class Recipe {
  String id, imageUrl, title;
  List<String> steps;
  List<String> ingredients;
  List<Nutrients> nutrients;
  Recipe(
      {required this.id,
        required this.title,
        required this.imageUrl,
        required this.steps,
        required this.ingredients,
        required this.nutrients});
}

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favourites'),
      ),
      body: ListView.builder(
        itemCount: FavoriteRecipes.favoriteRecipes.length,
        itemBuilder: (BuildContext context, int index) {
          Recipe recipe = FavoriteRecipes.favoriteRecipes[index];
          return ListTile(
            title: Text(recipe.title),
            // Add more details or actions for each favorite recipe
          );
        },
      ),
    );
  }
}

class FavoriteRecipes {
  static List<Recipe> favoriteRecipes = [];

  // Method to add a recipe to favorites
  static void addRecipeToFavorites(Recipe recipe) {
    favoriteRecipes.add(recipe);
  }

  // Method to remove a recipe from favorites
  static void removeRecipeFromFavorites(Recipe recipe) {
    favoriteRecipes.remove(recipe);
  }

  // Method to check if a recipe is in favorites
  static bool isRecipeFavorite(Recipe recipe) {
    return favoriteRecipes.contains(recipe);
  }

  // Method to get the list of favorite recipes
  static List<Recipe> getFavoriteRecipes() {
    return favoriteRecipes;
  }
}










