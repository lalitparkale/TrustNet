import 'package:flutter/material.dart';
//import 'dart:async';

//import 'package:url_launcher/url_launcher.dart';
import 'package:mobile_app/model/recom_model.dart';
import 'package:mobile_app/model/search_model.dart';
import 'package:mobile_app/pages/screen_lib.dart';

//create a stateless page to display the recommendations based on the search text
class RecommendationPage extends StatelessWidget {
  const RecommendationPage({Key? key}) : super(key: key);

  void _getInitInfo() {
    //get the search text from the search model
    //SearchModel.getSearchText();
  }

  @override
  Widget build(BuildContext context) {
    //get recommendations based on the search text
    _getInitInfo();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Recommendations'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Recommendations for : ${SearchModel.getSearchText()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.separated(
              itemCount: RecommendationModel.getRecommendations().length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(
                height: 25,
              ),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              itemBuilder: (context, index) {
                return Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('By : '),
                            Text(
                              //'Almighty Universe',
                              RecommendationModel.getRecommendations()[index]
                                  .recommender
                                  .fullName,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            IconButton(
                              icon: const Icon(Icons.call_rounded),
                              color: Colors.green,
                              onPressed: () => {
                                //invoke mobile call function
                                // launchUrl(
                                //   Uri(
                                //     scheme: 'tel',
                                //     path: RecommendationModel
                                //             .getRecommendations()[index]
                                //         .recommender
                                //         .mobile,
                                //   ), //invoke mobile call function
                                // ),
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.message_rounded),
                              color: Colors.indigo,
                              onPressed: () => {
                                //invoke mobile call function
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Plumber : '),
                            //Text('Andy Plumber',
                            Text(
                                RecommendationModel.getRecommendations()[index]
                                    .referee
                                    .fullName,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo)),
                            IconButton(
                              icon: const Icon(Icons.call_rounded),
                              color: Colors.green,
                              onPressed: () => {
                                //invoke mobile call function
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.message_rounded),
                              color: Colors.indigo,
                              onPressed: () => {
                                //invoke mobile call function
                              },
                            ),
                          ],
                        ),
                      ]),
                );
              },
            ),
          ],
        ),

        //add the bottom navigation bar to the page
        bottomNavigationBar: navBar(context));
  }
}
