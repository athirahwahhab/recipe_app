import 'package:flutter/material.dart';
import 'package:recipes/screens/details.dart';
import 'package:recipes/screens/utils/data.dart';
import 'package:recipes/screens/utils/class.dart';

class RecipeSearch extends StatefulWidget {
  @override
  _RecipeSearchState createState() => _RecipeSearchState();
}

class _RecipeSearchState extends State<RecipeSearch> {
  List<Recipe> displayedRecipes = List.from(Data.recipes);
  TextEditingController _searchController = TextEditingController();

  void searchRecipes(String query) {
    setState(() {
      displayedRecipes = Data.recipes
          .where((recipe) =>
          recipe.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Search'),
        backgroundColor: Colors.green[200],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: searchRecipes,
              decoration: InputDecoration(
                labelText: 'Search Recipes',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedRecipes.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(displayedRecipes[index].title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          recipe: displayedRecipes[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
