import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CinemaApp());
}

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

class SessionSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выбрать фильм')),
      body: Center(
        child: ListView(
          children: <Widget>[
            // First movie
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 500,
                    width: 300,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/afa2cfdb-3cdc-4daf-961c-134a68533d30/orig',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Матрица', style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeatSelectionScreen()),
                          );
                        },
                        child: const Text('Купить'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Second movie
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 500,
                    width: 300,
                    child: Image.network(
                      'https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/b9f543bb-c955-49ce-8d71-0ab5b81a40ed/orig',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Скотт Пилигрим против всех', style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeatSelectionScreen()),
                          );
                        },
                        child: const Text('Купить'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Third movie
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 500,
                    width: 300,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/afa2cfdb-3cdc-4daf-961c-134a68533d30/orig',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Фильм 3', style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeatSelectionScreen()),
                          );
                        },
                        child: const Text('Купить'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SeatSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выбрать место')),
      body: Center(
        // Image then two fields for row and seat number then confirm button
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //image in lib/imageZal.png
            Image.asset('assets/imageZal.png'),
            const Padding(padding: EdgeInsets.all(10)),
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
              MaterialPageRoute(
                  builder: (context) => BookingConfirmationScreen()),
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
