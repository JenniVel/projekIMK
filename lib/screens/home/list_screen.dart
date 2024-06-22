import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projek/screens/awalan/masuk_screen.dart';
import 'package:projek/screens/home/edit_screen.dart';

import 'package:projek/screens/widgets/list_widget.dart';

class DestinationListScreen extends StatefulWidget {
  const DestinationListScreen({super.key});

  @override
  State<DestinationListScreen> createState() => _DestinationListScreenState();

  static Future<void> confirmSignOut(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Keluar',
            style: Theme.of(context).textTheme.headline6),
        content: Text('Apakah Anda yakin ingin keluar?',
            style: Theme.of(context).textTheme.bodyText1),
        actions: [
          TextButton(
            child: Text('Tidak', style: Theme.of(context).textTheme.bodyText1),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Ya', style: Theme.of(context).textTheme.bodyText1),
            onPressed: () async {
              Navigator.pop(context);
              await _signOut(context);
            },
          ),
        ],
      ),
    );
  }

  static Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MasukScreen()),
          (Route<dynamic> route) => false,
        );
      });
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}

class _DestinationListScreenState extends State<DestinationListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 10),
            const Text('Destinations'),
            const Spacer(),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                onPressed: () => DestinationListScreen.confirmSignOut(context),
                child: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const DestinationList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DestinationEditScreen(),
              ));
        },
        tooltip: 'Add Destination',
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      
    theme: ThemeData(
      primaryColor: Colors.blueAccent,
      textTheme: const TextTheme(
        headline6: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(color: Colors.black),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    home: const DestinationListScreen(),
  ));
}
