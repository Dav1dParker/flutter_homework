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
        // column with 3 buttons with padding between them
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SeatSelectionScreen()),
                );
              },
              child: const Text('The Matrix'),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SeatSelectionScreen()),
                );
              },
              child: const Text('La La Land'),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SeatSelectionScreen()),
                );
              },
              child: const Text('Oppenheimer'),
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



