import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> categories = [];

  void addCategories(String categoryName) {
    categories.add(categoryName);
    setState(() {});
  }

  void removeCategories(String categoryName) {
    categories.remove(categoryName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chip Widget'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Wrap(
                  spacing: 24,
                  children: categories.map(
                    (category) {
                      return Chip(
                        onDeleted: () {
                          removeCategories(category);
                        },
                        deleteIcon: const Icon(Icons.remove_circle),
                        label: Text(category),
                      );
                    },
                  ).toList(),
                ),
                if (categories.isEmpty)
                  const Center(
                    child: Text('No Categories available!'),
                  ),
                const SizedBox(height: 64),
                const Text(
                  'Enter your Category name and press enter to add it.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onSubmitted: (category) {
                    addCategories(category);
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: 'Enter Category Name',
                    hintText: 'Enter Category Name',
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
