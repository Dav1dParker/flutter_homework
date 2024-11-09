import 'package:flutter/material.dart';

void main() {
  runApp(MovieListApp());
}

class MovieListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieListScreen(),
    );
  }
}

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final List<String> _movies = [];
  final TextEditingController _controller = TextEditingController();

  void _addMovie() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _movies.add(_controller.text);
      });
      _controller.clear();
    }
  }

  void _removeMovie(int index) {
    setState(() {
      _movies.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter movie name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addMovie,
                ),
              ),
              onSubmitted: (_) => _addMovie(),
            ),
          ),
          Flexible(
            child: ListView.separated(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_movies[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeMovie(index),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(), // Separator
            ),
          ),
        ],
      ),
    );
  }
}
