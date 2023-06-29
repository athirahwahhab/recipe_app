import 'package:flutter/material.dart';
import 'package:recipes/screens/LoginForm.dart';
import 'package:recipes/screens/utils/class.dart';
import 'package:recipes/screens/details.dart';
import 'package:recipes/screens/recipe_search.dart';
import 'package:recipes/screens/utils/data.dart';
import 'package:recipes/screens/utils/widgets.dart';
import 'package:recipes/screens/favorite.dart';

import '../main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Recipes'),
        backgroundColor: Colors.green[200],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeSearch()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[200],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color:Colors.green[200],),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
                // Navigate to the Profile page or perform any desired action
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite, color:Colors.red,),
              title: Text('Favorites'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesPage()),
                );
                // Navigate to the Favorites page or perform any desired action
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined, color:Colors.green[200]),
              title: Text('Log Out'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginForm()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        shrinkWrap: false,
        itemCount: Data.recipes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          Recipe recipe = Data.recipes[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      recipe: recipe,
                    ),
                  ),
                );
              },
              child: Card(
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          child: Hero(
                            tag: recipe.id,
                            child: FadeInImage(
                              image: NetworkImage(recipe.imageUrl),
                              fit: BoxFit.cover,
                              placeholder: AssetImage('assets/images/loading.gif'),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          recipe.title,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// our data
const name = 'name';
const email = "email";
const phone = "no-phone"; // not real number :)



class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green[200],

      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green[200],
            ),
            Text(
              "Name",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.green[200],
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Source Sans Pro"),
            ),
            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.green[200],
              ),
            ),
            InfoCard(text: phone, icon: Icons.phone, onPressed: () async {}),
            InfoCard(text: name, icon: Icons.person, onPressed: () async {}),
            InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
          ],
        ),
      ),
    );
  }
}

