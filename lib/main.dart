import 'package:flutter/material.dart';

void main() {
  runApp(CinemaApp());
}

//global variables
int selectedMovie = 0;

class CinemaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кинотеатр',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    MoviesScreen(),
    SessionSelectionScreen(),
    CartScreen(),
    BookingConfirmationScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cinema Tickets App')),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Фильмы'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Корзина'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}


class MoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SessionSelectionScreen()),
            );
          },
          child: const Text('Выбрать фильм'),
        ),
      ),
    );
  }
}


Future<Image> loadPosterImage() {
  return Future.delayed(
    const Duration(seconds: 3),
        () {
      String url;
      if (selectedMovie == 0) {
        url =
        'https://i.pinimg.com/736x/29/c6/d9/29c6d9314178119ce86099e3c66a328d.jpg';
      } else {
        url = 'https://cdn1.ozone.ru/s3/multimedia-v/6698423299.jpg';
      }
      return Image.network(url, width: 250, height: 400);
    },
  );
}

Future<Image> loadSeatsImage() async {
  await Future.delayed(const Duration(seconds: 3));
  const url = 'https://www.mirage.ru/images/bzal/z183.jpg';
  return Image.network(url, width: 540, height: 400);
}




class SessionSelectionScreen extends StatefulWidget {
  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SessionSelectionScreen> {
  Image? _posterImage;
  Image? _seatsImage;

  @override
  void initState() {
    super.initState();
    _loadPosterAndSeats();
  }

  void _loadPosterAndSeats() {
    // Load poster image using Future API
    loadPosterImage().then((image) {
      setState(() {
        _posterImage = image;
      });
    });

    // Load seats image using async/await
    loadSeatsImage().then((image) {
      setState(() {
        _seatsImage = image;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выбрать место')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_posterImage != null) _posterImage! else const CircularProgressIndicator(),
            const SizedBox(height: 20),
            if (_seatsImage != null) _seatsImage! else const CircularProgressIndicator(),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(hintText: 'Ряд'),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            const TextField(
              decoration: InputDecoration(hintText: 'Место'),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: const Text('Добавить в корзину'),
            ),
          ],
        ),
      ),
    );
  }
}







// cart screen
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookingConfirmationScreen()),
            );
          },
          child: const Text('Оплатить'),
        ),
      ),
    );
  }
}



class BookingConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Оплата подтверждена')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Назад'),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('На главный экран'),
            ),
          ],
        ),
      ),
    );
  }
}



