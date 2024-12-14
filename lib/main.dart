import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  setup();
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

void setup() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<CartData>(CartData(amount: 0, row: 0, seat: 0));
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

class SeatSelectionScreen extends StatefulWidget {
  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final TextEditingController _rowController = TextEditingController();
  final TextEditingController _seatController = TextEditingController();

  @override
  void dispose() {
    _rowController.dispose();
    _seatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выбрать место')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://www.mirage.ru/images/bzal/z183.jpg',
              height: 350,
              width: 350,
              fit: BoxFit.cover,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            TextField(
              controller: _rowController,
              decoration: const InputDecoration(hintText: 'Ряд'),
              keyboardType: TextInputType.number,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            TextField(
              controller: _seatController,
              decoration: const InputDecoration(hintText: 'Место'),
              keyboardType: TextInputType.number,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () {
                int row = int.tryParse(_rowController.text) ?? 0;
                int seat = int.tryParse(_seatController.text) ?? 0;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeatData(
                      row: row,
                      seat: seat,
                      child: CartScreen(),
                    ),
                  ),
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



class SeatData extends InheritedWidget {
  final int row;
  final int seat;

  const SeatData({
    Key? key,
    required this.row,
    required this.seat,
    required Widget child,
  }) : super(key: key, child: child);

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
    final cartData = GetIt.instance<CartData>();

    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Выбрано место: ряд 1, место 2'),
            const Padding(padding: EdgeInsets.all(10)),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(hintText: 'Количество билетов'),
              keyboardType: TextInputType.number,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () {
                final int amount =
                    int.tryParse(_amountController.text) ?? 0;
                cartData.amount = amount;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingConfirmationScreen(),
                  ),
                );
              },
              child: const Text('Оплатить'),
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
    final cartData = GetIt.instance<CartData>();

    return Scaffold(
      appBar: AppBar(title: const Text('Оплата подтверждена')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Выбрано место: ряд 1, место 2"),
            Text("Количество билетов: ${cartData.amount}"),
            const Padding(padding: EdgeInsets.all(10)),
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

