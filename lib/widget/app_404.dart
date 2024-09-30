import 'package:flutter/material.dart';

class App404 extends StatelessWidget {
  const App404({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.content_paste_search_rounded,
            color: Color(0xFF98a6ad),
            size: 70,
          ),
          SizedBox(height: 10),
          Text("Data Tidak Ditemukan")
        ],
      ),
    );
  }
}
