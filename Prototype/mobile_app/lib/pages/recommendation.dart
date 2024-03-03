//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mobile_app/model/profile_model.dart';
import 'package:mobile_app/model/recom_model.dart';
import 'package:mobile_app/model/search_model.dart';
import 'package:mobile_app/pages/screen_lib.dart';

//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

//create a stateless page to display the recommendations based on the search text
class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

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
        body: SingleChildScrollView(
          child: Column(
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
                physics: const NeverScrollableScrollPhysics(),
                itemCount: RecommendationModel.getRecommendations().length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
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
                      color: Colors.indigoAccent.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Flexible(
                          child: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(''),
                                Text('Referred :',
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  //'Almighty Universe',
                                  RecommendationModel.getRecommendations()[
                                          index]
                                      .recommender
                                      .fullName,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                    RecommendationModel.getRecommendations()[
                                            index]
                                        .referee
                                        .fullName,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo)),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Tooltip(
                              message: 'Second level connection',
                              child: IconButton(
                                  icon: const Icon(Icons.looks_two_outlined),
                                  color: Colors.blueAccent,
                                  onPressed: () => {
                                        //invoke mobile call function
                                      }),
                            ),
                            IconButton(
                              icon: const Icon(Icons.stars),
                              color: Colors.blueAccent,
                              onPressed: () => {
                                //invoke mobile call function
                              },
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.call_rounded),
                              color: Colors.indigo,
                              onPressed: () => {
                                //invoke mobile call function
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.call_rounded),
                              color: Colors.indigo,
                              onPressed: () => {
                                //invoke mobile call function
                              },
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.message_outlined),
                              color: Colors.indigo,
                              onPressed: () => {
                                //invoke mobile call function
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.message_outlined),
                              color: Colors.indigo,
                              onPressed: () => {
                                //invoke mobile call function
                              },
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(null),
                            if (RecommendationModel.getRecommendations()[index]
                                    .referee
                                    .businessContact !=
                                null)
                              IconButton(
                                icon: const Icon(Icons.arrow_drop_down),
                                color: Colors.indigo,
                                onPressed: () => {
                                  //invoke mobile call function
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Business Contact'),
                                      content: Container(
                                        //width: 150,
                                        height: 200,
                                        // color: Colors.indigoAccent
                                        //     .withOpacity(0.3),
                                        child: BusinessCard(
                                          bizContact: RecommendationModel
                                                  .getRecommendations()[index]
                                              .referee,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          //style:
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.indigoAccent),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Close',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                }, //onPressed: () => {AlertDialog()},
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        //add the bottom navigation bar to the page
        bottomNavigationBar: navBar(context));
  }
}

class BusinessCard extends StatelessWidget {
  final UserContact bizContact;
  const BusinessCard({
    super.key,
    required this.bizContact,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxis0Alignment: CrossAxisAlignment.stretch,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name :',
                    style: TextStyle(
                        fontSize: 10,
                        //fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                    softWrap: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Address :',
                    style: TextStyle(
                        fontSize: 10,
                        //fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                    softWrap: true,
                  ),
                ],
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bizContact.businessContact!.businessName,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                      //softWrap: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      bizContact.businessContact!.headOfficeAddress,
                      style: const TextStyle(
                          fontSize: 12,
                          //fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                      //softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
            ]),
        Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'google map will render business location here!',
                  style: TextStyle(
                      fontSize: 10,
                      //fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                  softWrap: true,
                ),
                // GoogleMap(
                //     mapType: MapType.normal,
                //     initialCameraPosition: CameraPosition(
                //       target: LatLng(-33.852, 151.211),
                //       zoom: 13.0,
                //     )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
