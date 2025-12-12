import 'package:flutter/material.dart';
// import file dashboard lain
import 'dashboard_all.dart';
import 'dashboard_matematika.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selected = "Semuanya"; // default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF7FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selected,
                    items: const [
                      DropdownMenuItem(value: "Semuanya", child: Text("Semuanya")),
                      DropdownMenuItem(value: "Matematika", child: Text("Matematika")),
                      DropdownMenuItem(value: "Bahasa", child: Text("Bahasa")),
                    ],
                    onChanged: (val) {
                      setState(() {
                        selected = val!;
                      });
                    },
                  )
                ],
              ),
            ),

            // Konten berdasarkan dropdown
            Expanded(
              child: _getDashboard(selected),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDashboard(String value) {
    switch (value) {
      case "Matematika":
        return DashboardMatematika();
      case "Semuanya":
      default:
        return const DashboardAll();
    }
  }
}
