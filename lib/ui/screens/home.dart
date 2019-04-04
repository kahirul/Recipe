import 'package:flutter/material.dart';
import 'package:recipe/model/recipe.dart';
import 'package:recipe/model/state.dart';
import 'package:recipe/state_widget.dart';
import 'package:recipe/ui/screens/login.dart';
import 'package:recipe/ui/widgets/recipe_card.dart';
import 'package:recipe/utils/store.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  StateModel appState;
  List<Recipe> recipes = getRecipes();
  List<String> favorites = getFavoriteIDs();

  DefaultTabController _buildTabView({Widget body}) {
    double _iconSize = 20.0;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 2.0,
            bottom: TabBar(
              labelColor: Theme.of(context).indicatorColor,
              tabs: [
                Tab(icon: Icon(Icons.restaurant, size: _iconSize)),
                Tab(icon: Icon(Icons.local_drink, size: _iconSize)),
                Tab(icon: Icon(Icons.favorite, size: _iconSize)),
                Tab(icon: Icon(Icons.settings, size: _iconSize)),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: body,
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (appState.isLoading) {
      return _buildTabView(
        body: _buildLoadingIndicator(),
      );
    } else if (!appState.isLoading && appState.user == null) {
      return new LoginScreen();
    } else {
      return _buildTabView(
        body: _buildTabsContent(),
      );
    }
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: new CircularProgressIndicator(),
    );
  }

  TabBarView _buildTabsContent() {
    Padding _buildRecipes(List<Recipe> recipes) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (BuildContext context, int index) {
                  Recipe recipe = recipes[index];
                  return RecipeCard(
                    recipe: recipe,
                    inFavorites: favorites.contains(recipe.id),
                    onFavoriteButtonPressed: _handleFavoriteListChanged,
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return TabBarView(
      children: [
        _buildRecipes(
            recipes.where((recipe) => recipe.type == RecipeType.food).toList()),
        _buildRecipes(recipes
            .where((recipe) => recipe.type == RecipeType.drink)
            .toList()),
        _buildRecipes(
            recipes.where((recipe) => favorites.contains(recipe.id)).toList()),
        Center(child: Icon(Icons.settings)),
      ],
    );
  }

  void _handleFavoriteListChanged(String recipeID) {
    setState(() {
      if (favorites.contains(recipeID)) {
        favorites.remove(recipeID);
      } else {
        favorites.add(recipeID);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    return _buildContent();
  }
}
