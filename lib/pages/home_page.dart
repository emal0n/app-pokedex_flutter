import 'package:flutter/material.dart';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/adaptive_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  int _selectedIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: 'POKEDEX',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have pushed the button this many times:',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$_counter',
              style: GoogleFonts.poppins(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: AdaptiveBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ).build(),
    );
  }
}





