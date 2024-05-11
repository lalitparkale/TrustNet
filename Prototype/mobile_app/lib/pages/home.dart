import 'package:flutter/material.dart';
import '../model/search_model.dart';
import 'screen_lib.dart';
import 'recommendation.dart';
import '../globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome ${gUserProfile.name}!'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(40),
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  width: 112,
                ),
              ),
              const Text('Tap into the power of your friends network',
                  style: TextStyle(
                    fontSize: 12,
                    //fontWeight: FontWeight.bold,
                  )),
              //add expanded widget
              // Expanded(
              //   //create grid view with 2 columns and 2 rows
              //   child: GridView.count(
              //     crossAxisCount: 2,
              //     children: const <Widget>[
              //       //add container widget
              //       HomeTile(
              //         icon: Icons.people,
              //         title: 'Trusted Contacts',
              //         value: '101',
              //       ),

              //       HomeTile(
              //         icon: Icons.star,
              //         title: 'Trusted Providers',
              //         value: '101',
              //       ),

              //       HomeTile(
              //         icon: Icons.circle_outlined,
              //         title: 'Friends of Friends',
              //         value: '10,000+',
              //       ),

              //       HomeTile(
              //         icon: Icons.book,
              //         title: 'Categories',
              //         value: '11',
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelText: 'Search',
                    hintText: 'search for services, like "fix leaking pipe"',
                    hintStyle: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),

                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        //invoke textfield onsubmitted event
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RecommendationPage()),
                        );
                      },
                    ),
                    //on change event to set the search text
                  ),
                  onChanged: (value) => SearchModel().searchText = value,
                  onSubmitted: (value) {
                    SearchModel().searchText = value;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecommendationPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: navBar(context));
  }
}

class HomeTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const HomeTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.indigoAccent.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            icon,
            size: 36,
            color: Colors.white,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.indigo,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
