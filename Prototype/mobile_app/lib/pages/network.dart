import 'package:flutter/material.dart';
import 'package:pickeze/pages/recommendation.dart';

//statefull page
class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key, required this.title});

  final String title;

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: const Center(child: Text('Coming soon...')),
      //body: const RecommendationListView(),
    );
  }
}
