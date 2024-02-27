import 'package:flutter/material.dart';
import 'package:mobile_app/model/profile_model.dart';
import 'package:mobile_app/model/recom_model.dart';
import 'package:mobile_app/model/search_model.dart';
import 'package:mobile_app/pages/screen_lib.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                    // child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           const Text('By : '),
                    //           Text(
                    //             //'Almighty Universe',
                    //             RecommendationModel.getRecommendations()[index]
                    //                 .recommender
                    //                 .fullName,
                    //             style: const TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.black),
                    //           ),
                    //           IconButton(
                    //             icon: const Icon(Icons.call_rounded),
                    //             color: Colors.green,
                    //             onPressed: () => {
                    //               //invoke mobile call function
                    //               // launchUrl(
                    //               //   Uri(
                    //               //     scheme: 'tel',
                    //               //     path: RecommendationModel
                    //               //             .getRecommendations()[index]
                    //               //         .recommender
                    //               //         .mobile,
                    //               //   ), //invoke mobile call function
                    //               // ),
                    //             },
                    //           ),
                    //           IconButton(
                    //             icon: const Icon(Icons.message_rounded),
                    //             color: Colors.indigo,
                    //             onPressed: () => {
                    //               //invoke mobile call function
                    //             },
                    //           ),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           const Text('Plumber : '),
                    //           //Text('Andy Plumber',
                    //           Text(
                    //               RecommendationModel.getRecommendations()[
                    //                       index]
                    //                   .referee
                    //                   .fullName,
                    //               style: const TextStyle(
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.bold,
                    //                   color: Colors.indigo)),
                    //           IconButton(
                    //             icon: const Icon(Icons.call_rounded),
                    //             color: Colors.green,
                    //             onPressed: () => {
                    //               //invoke mobile call function
                    //             },
                    //           ),
                    //           IconButton(
                    //             icon: const Icon(Icons.message_rounded),
                    //             color: Colors.indigo,
                    //             onPressed: () => {
                    //               //invoke mobile call function
                    //             },
                    //           ),
                    //         ],
                    //       ),
                    //     ]),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Recommender:'),
                            Text('Referred :'),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                            Text(
                                RecommendationModel.getRecommendations()[index]
                                    .referee
                                    .fullName,
                                style: const TextStyle(
                                    fontSize: 16,
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.indigo)),
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
                                        height: 200,
                                        child: BusinessCard(
                                          bizContact: RecommendationModel
                                                  .getRecommendations()[index]
                                              .referee,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close'),
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
    return Container(
      //height: 100,
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Business Name : ',
                  style: TextStyle(
                      fontSize: 12,
                      //fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
                Text(
                  'Address : ',
                  style: TextStyle(
                      fontSize: 12,
                      //fontWeight: FontWeight.bold,
                      color: Colors.indigo),
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                  Text(
                    bizContact.businessContact!.headOfficeAddress,
                    style: const TextStyle(
                        fontSize: 16,
                        //fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                ]),
            // const Column(
            //   children: [
            //     GoogleMap(
            //         mapType: MapType.normal,
            //         initialCameraPosition: CameraPosition(
            //           target: LatLng(-33.852, 151.211),
            //           zoom: 14.0,
            //         )),
            //   ],
            // ),
          ]),
        ],
      ),
    );
  }
}
