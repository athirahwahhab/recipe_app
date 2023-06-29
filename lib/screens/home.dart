import 'package:flutter/material.dart';
import 'package:recipes/screens/utils/class.dart';
import 'package:recipes/screens/utils/widgets.dart';
import 'package:recipes/screens/favorite.dart';

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
    isFavorite = FavoriteRecipes.isRecipeFavorite(widget.recipe);
  }

  @override
  Widget build(BuildContext context) {
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
                      top: 16.0,
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
                            FavoriteRecipes.addRecipeToFavorites(widget.recipe);
                          } else {
                            FavoriteRecipes.removeRecipeFromFavorites(widget.recipe);
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FavoritesPage()),
                          );
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
                    backgroundColor: Colors.green[200],
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
                    backgroundColor: Colors.green[200],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeSteps extends StatelessWidget {
  final List<String> steps;
  RecipeSteps({required this.steps});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: steps.length,
      padding: const EdgeInsets.all(0.0),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
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
            steps[index],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}

class IngredientsWidget extends StatelessWidget {
  final List<String>? ingredients;
  IngredientsWidget({this.ingredients});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        itemCount: ingredients!.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              backgroundColor: Theme.of(context).accentColor,
              label: Text(
                ingredients![index],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NutritionWidget extends StatelessWidget {
  final List<Nutrients>? nutrients;
  NutritionWidget({this.nutrients});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      width: double.infinity,
      child: Center(
        child: ListView.builder(
          itemCount: nutrients!.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return CircleIndicator(
              percent: nutrients![index].percent,
              nutrient: nutrients![index],
            );
          },
        ),
      ),
    );
  }
}