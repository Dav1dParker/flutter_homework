import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:url_launcher/url_launcher.dart';

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

  String _getPlatform() {
    if (kIsWeb) {
      return "Running on Web";
    } else if (Platform.isAndroid) {
      return "Running on Android";
    } else if (Platform.isIOS) {
      return "Running on iOS";
    } else if (Platform.isMacOS) {
      return "Running on macOS";
    } else if (Platform.isWindows) {
      return "Running on Windows";
    } else if (Platform.isLinux) {
      return "Running on Linux";
    } else {
      return "Running on UFO";
    }
  }

  void _platformSpecificAction() async {
    if (kIsWeb) {
      final url = Uri.parse("https://online-edu.mirea.ru");
      //if (await canLaunchUrl(url)) {
      //  await launchUrl(url, mode: LaunchMode.externalApplication);
      //}
    } else if (Platform.isAndroid) {
      Fluttertoast.showToast(
        msg: "I think I am an android app",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else if (Platform.isIOS) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("This action is specific to iOS")),
      );
    } else if (Platform.isMacOS) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("macOS Action"),
          content: Text("This action is specific to macOS."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else if (Platform.isWindows) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Windows Action"),
          content: Text("I think I run on windows."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else if (Platform.isLinux) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Linux Action"),
          content: Text("This action is specific to Linux."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie List - ${_getPlatform()}'),
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
              separatorBuilder: (context, index) => Divider(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _platformSpecificAction,
              child: Text("Platform Specific Action"),
            ),
          ),
        ],
      ),
    );
  }
}
