import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework/cart_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

final cartStore = CartStore();

void main() {
  runApp(CinemaApp());
}

class CinemaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema Tickets App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

void setup() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<CartData>(CartData(amount: 0, row: 0, seat: 0));
}



class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

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
  const SessionSelectionScreen({super.key});

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
                  SizedBox(
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
                  SizedBox(
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
                  SizedBox(
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
  final TextEditingController _rowController = TextEditingController();
  final TextEditingController _seatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Seat')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _rowController,
              decoration: const InputDecoration(hintText: 'Enter row'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _seatController,
              decoration: const InputDecoration(hintText: 'Enter seat'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final int row = int.tryParse(_rowController.text) ?? 0;
                final int seat = int.tryParse(_seatController.text) ?? 0;
                cartStore.updateSeat(row, seat);
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}




class SeatData extends InheritedWidget {
  final int row;
  final int seat;

  const SeatData({
    super.key,
    required this.row,
    required this.seat,
    required super.child,
  });

  static SeatData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SeatData>();
  }

  @override
  bool updateShouldNotify(covariant SeatData oldWidget) {
    return row != oldWidget.row || seat != oldWidget.seat;
  }
}


class CartData{
  int amount;
  int row;
  int seat;

  CartData({required this.amount, required this.row, required this.seat});
}


class CartScreen extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Observer(
              builder: (_) => Text(
                'Selected Seat: Row ${cartStore.row}, Seat ${cartStore.seat}',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(hintText: 'Enter ticket amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final int amount = int.tryParse(_amountController.text) ?? 0;
                cartStore.updateAmount(amount);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingConfirmationScreen()),
                );
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}




class BookingConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Confirmed')),
      body: Center(
        child: Observer(
          builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Selected Seat: Row ${cartStore.row}, Seat ${cartStore.seat}'),
              Text('Tickets: ${cartStore.amount}'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


