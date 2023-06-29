import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/screens/utils/class.dart' as Utils;
import 'package:recipes/screens/utils/class.dart';

import 'home.dart';

class DetailsPage extends StatefulWidget {
  final Recipe recipe;
  DetailsPage({required this.recipe});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = Utils.FavoriteRecipes.isRecipeFavorite(widget.recipe);
  }

  @override
  Widget build(BuildContext context) {
    List<Recipe> favoriteRecipes = Utils.FavoriteRecipes.getFavoriteRecipes();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.green[200],
              title: Text(widget.recipe.title),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: widget.recipe.id,
                      child: FadeInImage(
                        image: NetworkImage(widget.recipe.imageUrl),
                        fit: BoxFit.cover,
                        placeholder: AssetImage('assets/images/loading.gif'),
                      ),
                    ),
                    Positioned(
                      top: 20.0,
                      right: 16.0,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });

                          if (isFavorite) {
                            Utils.FavoriteRecipes.addRecipeToFavorites(widget.recipe);
                          } else {
                            void _onFavoriteButtonTapped() {
                              setState(() {
                                isFavorite = !isFavorite;
                              });

                              if (isFavorite) {
                                Utils.FavoriteRecipes.addRecipeToFavorites(widget.recipe);
                              } else {
                                Utils.FavoriteRecipes.removeRecipeFromFavorites(widget.recipe);
                              }
                            }
                            Utils.FavoriteRecipes.removeRecipeFromFavorites(widget.recipe);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Text(
                  'Nutrition',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                NutritionWidget(
                  nutrients: widget.recipe.nutrients,
                ),
                Divider(
                  color: Colors.white,
                  endIndent: 40.0,
                  indent: 40.0,
                ),
                Text(
                  'Ingredients',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                IngredientsWidget(
                  ingredients: widget.recipe.ingredients,
                ),
                Divider(
                  color: Colors.white,
                  endIndent: 40.0,
                  indent: 40.0,
                ),
                Text(
                  'Steps',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                RecipeSteps(
                  steps: widget.recipe.steps,
                ),
                Divider(
                  color: Colors.white,
                  endIndent: 40.0,
                  indent: 40.0,
                ),
                ListView.builder(
                  itemCount: favoriteRecipes.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Recipe favoriteRecipe = favoriteRecipes[index];
                    return ListTile(
                      title: Text(favoriteRecipe.title),
                      // Add any additional widgets or information for each favorite recipe
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
