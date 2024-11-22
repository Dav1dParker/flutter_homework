import 'package:flutter/material.dart';

void main() {
  runApp(TicketApp());
}

class TicketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema Tickets',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          HomeScreen(),
          MovieCatalogScreen(),
          UserProfileScreen(),
        ],
      ),
    );
  }
}

// Screen 1: Home Screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Welcome to Cinema App',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MovieCatalogScreen()),
              );
            },
            child: const Text('Browse Movies'),
          ),
        ],
      ),
    );
  }
}

// Screen 2: Movie Catalog
class MovieCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movies Catalog')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Movie 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MovieDetailScreen(movieName: 'Movie 1')),
              );
            },
          ),
          ListTile(
            title: Text('Movie 2'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MovieDetailScreen(movieName: 'Movie 2')),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Screen 3: Movie Details
class MovieDetailScreen extends StatelessWidget {
  final String movieName;

  MovieDetailScreen({required this.movieName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movieName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Details about $movieName'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen()),
                );
              },
              child: Text('Book Ticket'),
            ),
          ],
        ),
      ),
    );
  }
}

// Screen 4: Checkout Screen
class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Center(
        child: Text('Ticket Booking Details'),
      ),
    );
  }
}

// Screen 5: User Profile
class UserProfil  eScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Center(
        child: Text('User Information and Ticket History'),
      ),
    );
  }
}

