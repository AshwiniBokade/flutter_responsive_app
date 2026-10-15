import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';

class ResponsiveScreen extends StatefulWidget {
  const ResponsiveScreen({super.key});
  @override
  State<ResponsiveScreen> createState() => _ResponsiveScreen();
}

class _ResponsiveScreen extends State<ResponsiveScreen> {


 final List<Map<String, dynamic>> meals = const [
    {'name': 'Pasta', 'icon': Icons.dinner_dining},
    {'name': 'Pizza', 'icon': Icons.local_pizza},
    {'name': 'Salad', 'icon': Icons.eco},
    {'name': 'Burger', 'icon': Icons.lunch_dining},
    {'name': 'Soup', 'icon': Icons.soup_kitchen},
    {'name': 'Dessert', 'icon': Icons.cake},
    {'name': 'Biryani', 'icon': Icons.rice_bowl},
    {'name': 'Sandwich', 'icon': Icons.breakfast_dining}];


  @override
  Widget build(BuildContext context) { // MediaQuery: get screen dimensions and orientation.
    final screenSize = MediaQuery.sizeOf(context);
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    final isTablet = screenSize.shortestSide >= 600;
    final isLargeScreen = screenSize.width >= 1000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Recipes'),
        centerTitle: false,
      ),
      body: Row(
        children: [
          // Adaptive navigation for larger screens.
          if (isLargeScreen)
            NavigationRail(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite_outline),
                  label: Text('Favorites'),
                ),
              ],
            ),

          // Main content.
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // LayoutBuilder: use the available width.
                final width = constraints.maxWidth;

                int columns;

                if (width < 450) {
                  columns = 1;
                } else if (width < 700) {
                  columns = 2;
                } else if (width < 1100) {
                  columns = 3;
                } else {
                  columns = 4;
                }

                final padding = width < 600 ? 12.0 : 24.0;
                final spacing = width < 600 ? 12.0 : 20.0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Discover Recipes',
                            style: TextStyle(
                              fontSize: width < 600 ? 22 : 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isLargeScreen
                                ? 'Explore recipes on your desktop'
                                : isTablet
                                    ? 'Explore recipes on your tablet'
                                    : isLandscape
                                        ? 'Explore recipes in landscape'
                                        : 'Explore recipes on your phone',
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.all(padding),
                        itemCount: meals.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: spacing,
                          mainAxisSpacing: spacing,
                          childAspectRatio: 0.95,
                        ),
                        itemBuilder: (context, index) {
                          final meal = meals[index];

                          return Card(
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${meal['name']} selected',
                                      ),
                                    ),
                                  );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      meal['icon'] as IconData,
                                      size: width < 600 ? 40 : 56,
                                      color: Theme.of(context)
                                          .colorScheme.primary,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      meal['name'] as String,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize:
                                            width < 600 ? 16 : 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}