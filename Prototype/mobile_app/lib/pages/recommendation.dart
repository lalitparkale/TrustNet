//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:pickeze/pages/biz.dart';
import '../model/profile_model.dart';
import '../model/recom_model.dart';
import '../model/search_model.dart';
import '../pages/screen_lib.dart';

//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

//create a stateless page to display the recommendations based on the search text
class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  @override
  void initState() {
    super.initState();
    //get the search text from the search model
    //SearchModel.getSearchText();
    readonlyTextController.text = SearchModel.getSearchText();
  }

  final readonlyTextController = TextEditingController(text: 'temp');

  @override
  Widget build(BuildContext context) {
    //get recommendations based on the search text

    //_getInitInfo(); //invocation not required after changing this to initState

    return Scaffold(
        appBar: AppBar(
          title: const Text('Recommendations'),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Searched for : ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                readOnly: true,
                controller: readonlyTextController,
                style: const TextStyle(
                  fontSize: 12,
                  //fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fillColor: Colors.grey.withOpacity(0.1),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  filled: true,
                ),
              ),
            ),
            const Expanded(
              child: RecommendationListView(),
            ),
          ],
        ),

        //add the bottom navigation bar to the page
        bottomNavigationBar: navBar(context));
  }
}

class BusinessCard extends StatelessWidget {
  final BusinessContact bizContact;
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
                      bizContact.bizName,
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
                      bizContact.headOfficeAddress,
                      style: const TextStyle(
                          fontSize: 12,
                          //fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                      //softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
            ]),
        const Row(
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

class RecommendationListView extends StatelessWidget {
  const RecommendationListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: RecommendationModel.getRecommendations().length,

      padding: const EdgeInsets.all(15),
      itemBuilder: (context, index) {
        return Container(
          height: 110,
          //width: 100,
          margin:
              const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
          //padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.indigoAccent.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                margin:
                    const EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 2),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CircleAvatar(
                  maxRadius: 12,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                        child: Text(
                            RecommendationModel.getRecommendations()[index]
                                .tradie
                                .bizName,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.feedback,
                        ),
                        iconSize: 20,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BizPage(
                                    cBizContact: RecommendationModel
                                            .getRecommendations()[index]
                                        .tradie)),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.phone,
                        ),
                        iconSize: 20,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.message,
                        ),
                        iconSize: 20,
                        onPressed: () {},
                      ),
                    ]),
                    const Row(children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'recommended by:',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                              RecommendationModel.getRecommendations()[index]
                                  .recommendedBy
                                  .fullName,
                              style: const TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.normal)),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.phone,
                        ),
                        iconSize: 15,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.message,
                        ),
                        iconSize: 15,
                        onPressed: () {},
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        );
        // return ListTile(
        //   leading: CircleAvatar(
        //     maxRadius: 12,
        //     child: Text(
        //       '${index + 1}',
        //       style: const TextStyle(
        //         fontSize: 12,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        //   title: Text(
        //     RecommendationModel.getRecommendations()[index].referee.fullName,
        //     style: const TextStyle(
        //       fontSize: 15,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        //   subtitle: Column(
        //     children: [
        //       const Row(
        //         children: [
        //           Padding(
        //             padding: EdgeInsets.all(10),
        //             child: Text('recommended by:',
        //                 style: TextStyle(
        //                     fontSize: 9, fontStyle: FontStyle.italic)),
        //           ),
        //         ],
        //       ),
        //       Row(
        //         children: [
        //           Container(
        //             //width: 100,
        //             margin: const EdgeInsets.only(
        //                 left:
        //                     10), //left alinging with the 'recommended by' text above
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10),
        //               color: Colors.indigo.shade100.withOpacity(0.3),
        //             ),
        //             child: Row(
        //               children: [
        //                 Text(
        //                   RecommendationModel.getRecommendations()[index]
        //                       .recommender
        //                       .fullName,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        //   trailing: Container(
        //     //height: 150,
        //     width: 120,

        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Colors.indigo.shade100.withOpacity(0.3),
        //     ),
        //     child: Row(
        //       children: [
        //         IconButton(
        //           icon: const Icon(
        //             Icons.feedback,
        //           ),
        //           iconSize: 20,
        //           onPressed: () {},
        //         ),
        //         IconButton(
        //           icon: const Icon(
        //             Icons.phone,
        //           ),
        //           iconSize: 20,
        //           onPressed: () {},
        //         ),
        //         IconButton(
        //           icon: const Icon(
        //             Icons.message,
        //           ),
        //           iconSize: 20,
        //           onPressed: () {},
        //         ),
        //       ],
        //     ),
        //   ),
        // );
      },
    );
  }
}
