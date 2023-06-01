import 'package:flutter/material.dart';

import 'package:s/screen2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List<dynamic>> fetchData() async {
    var url = Uri.parse(
        'https://api.thingspeak.com/channels/2171215/feeds.json?results=2');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data['feeds']);

      return data['feeds'];
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    // _loadData();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: reload(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text('Dashboard',
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 50.0),
              FutureBuilder<dynamic>(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // return Text(snapshot.data[0]['field1']);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              content_widget(
                                  text: "Power",
                                  text2: snapshot.data[0]['field1']),
                              content_widget(
                                  text: "Current",
                                  text2: snapshot.data[0]['field2']),
                              
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          content_widget(
                              text: "Voltage",
                              text2: snapshot.data[0]['field3'].replaceAll("\r\n\r\n" , " ")),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  }),
              const SizedBox(height: 10.0),
              // ElevatedButton(
              //     onPressed: () {
              //       fetchData();
              //     },
              //     child: const Text('Reload')),
            ],
          ),
        ),
      ),
    );
  }
}

class content_widget extends StatelessWidget {
  final String text;
  final String text2;
  const content_widget({
    super.key,
    required this.text,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
            text2,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
