import 'package:flutter/material.dart';

class screen2 extends StatelessWidget {
  const screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          backgroundColor: Colors.green.shade50,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50.0),
              const Text("Peak Power: "),
              const SizedBox(height: 50.0),
              const Text("Least Power: "),
              const SizedBox(height: 80.0),
              ElevatedButton(
                  onPressed: () {}, child: const Text("Home Appliances")),
              const SizedBox(height: 30.0),
              ElevatedButton(onPressed: () {}, child: const Text("Storage")),
              const SizedBox(height: 30.0),
              ElevatedButton(onPressed: () {}, child: const Text("Car (EV)")),
            ],
          ),
        ),
      ),
    );
  }
}
