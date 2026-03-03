import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();

  List<Movie> _allMovies = [];
  List<Movie> _trendingMovies = [];
  List<Movie> _popularMovies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final List<Map<String, dynamic>> _allMoviesData = await _apiService.getAllMovies();
    final List<Map<String, dynamic>> _trendingMoviesData = await _apiService.getTrendingMovies();
    final List<Map<String, dynamic>> _popularMoviesData = await _apiService.getPopularMovies();

  setState(() {
    _allMovies = _allMoviesData.map((e) => Movie.fromJson(e)).toList();
    _trendingMovies = _trendingMovies.map((e) => Movie.fromJson(e)).toList();
    _popularMovies = _popularMovies.map((e) => Movie.fromJson(e)).toList();
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilem'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMoviesList('All Movies', _allMovies),
            _buildMoviesList('Trending Movies', _trendingMovies),
            _buildMoviesList('Popular Movies', _popularMovies),
          ],
        ),
      ),
    );
  }

Widget _buildMoviesList(String title, List<Movie> movies){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
      padding: const EdgeInsets.all(8.0),
      child : Text(
        title,
        style: const TextStyle(fontSize : 20, fontWeight : FontWeight.bold),
      ),
      ),
      SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index){
            final Movie movie = movies[index];
            return Column(
              children: [
                Image.network('https//image.tmbd.org/t/p/w500${movie.posterPath}',
                height: 150,
                width: 100,
                fit: BoxFit.cover,
                ),
                Text(movie.title)
              ],
            );
          },
        ),
      )
    ],
  );
}

}
