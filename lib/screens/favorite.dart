import 'package:flutter/material.dart';
import 'package:recipes/screens/utils/class.dart';
import 'package:recipes/screens/details.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Recipe> favoriteRecipes = FavoriteRecipes.getFavoriteRecipes();

    if (favoriteRecipes.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
          backgroundColor: Colors.green[200],
        ),
        body: Center(
          child: Text(
            'No favorite recipes yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Colors.green[200],
      ),
      body: ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (BuildContext context, int index) {
          Recipe recipe = favoriteRecipes[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              recipe.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => DetailsPage(recipe: recipe),

              ),
              );// Handle tapping on a favorite recipe
              // You can navigate to the recipe details page or perform any desired action
            },
          );
        },
      ),
    );
  }
}
