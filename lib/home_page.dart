
import 'package:flutter/material.dart';
import 'movie.dart';
import 'movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchText = '';
  bool isGrid = false;
  int discount = 20;

  @override
  Widget build(BuildContext context) {
    final filteredMovies = movies.where((movie) {
      final title = movie.title.toLowerCase();
      final genre = movie.genre.toLowerCase();
      final query = searchText.toLowerCase();

      return title.contains(query) || genre.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Library'),
        actions: [
          IconButton(
            tooltip: isGrid ? 'List View' : 'Grid View',
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
            icon: Icon(
              isGrid ? Icons.view_list : Icons.grid_view,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredMovies.isEmpty
                ? const Center(
                    child: Text(
                      'No movies found',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : isGrid
                    ? GridView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: filteredMovies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.58,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                        itemBuilder: (context, index) {
                          return MovieCard(
                            movie: filteredMovies[index],
                            discount: discount,
                            isGrid: true,
                            onDiscountTap: () {
                              setState(() {
                                if (discount > 0) {
                                  discount--;
                                }
                              });
                            },
                          );
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: filteredMovies.length,
                        itemBuilder: (context, index) {
                          return MovieCard(
                            movie: filteredMovies[index],
                            discount: discount,
                            onDiscountTap: () {
                              setState(() {
                                if (discount > 0) {
                                  discount--;
                                }
                              });
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
