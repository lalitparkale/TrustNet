//import 'dart:html';

import 'package:aad_b2c_webview/aad_b2c_webview.dart';
import 'package:flutter/material.dart';
//import '../pages/home.dart';

onRedirect(BuildContext context) {
  Navigator.of(context)
      .pushNamedAndRemoveUntil('/myappname', (Route<dynamic> route) => false);
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? jwtToken;
  String? refreshToken;

  @override
  Widget build(BuildContext context) {
    const aadB2CClientID = "70d3f1a7-4794-47ce-9004-b914cd635dac";
    const aadB2CRedirectURL =
        //"https://TrustNetB2COrg.b2clogin.com/oauth2/nativeclient";
        //"https://com.trustnet.pickeze/myappname";
        "https://com.pickeze/myappname";
    const aadB2CUserFlowName = "B2C_1_Trustnetsignin";
    const aadB2CScopes = ['openid', 'offline_access'];
    const aadB2TenantName = "TrustNetB2COrg";
    const aadB2CUserAuthFlow =
        "https://$aadB2TenantName.b2clogin.com/$aadB2TenantName.onmicrosoft.com";

    return Scaffold(
      // appBar: AppBar(
      // title: Text(widget.title),
      // ),
      body: ADB2CEmbedWebView(
        tenantBaseUrl: aadB2CUserAuthFlow,
        userFlowName: aadB2CUserFlowName,
        clientId: aadB2CClientID,
        redirectUrl: aadB2CRedirectURL,
        scopes: aadB2CScopes,
        onAnyTokenRetrieved: (Token anyToken) {
          onRedirect;
        },
        onIDToken: (Token token) {
          jwtToken = token.value;
        },
        onAccessToken: (Token token) {
          onRedirect;
        },
        onRefreshToken: (Token token) {
          refreshToken = token.value;
        },
        optionalParameters: const [],
        onRedirect: onRedirect,
        onErrorOrCancel: (context) => onRedirect(context),
        //userAgent: ,
      ),
      //create standard login page with 2 text fields and a button and oauth providers
      //       Center(
      // child: Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Padding(
      //         padding: EdgeInsets.all(40),
      //         child: Image(
      //           image: AssetImage('assets/logo.png'),
      //           width: 64,
      //         ),
      //       ),
      // const Text('Login',
      //     style: TextStyle(
      //       fontSize: 24,
      //       fontWeight: FontWeight.bold,
      //     )),
      // const SizedBox(height: 20),
      // //add text field widget
      // const TextField(
      //   decoration: InputDecoration(
      //     border: OutlineInputBorder(),
      //     labelText: 'Email',
      //   ),
      //   //validate format of email
      //   keyboardType: TextInputType.emailAddress,
      // ),
      // const SizedBox(height: 20),
      // //add text field widget
      // const TextField(
      //   decoration: InputDecoration(
      //     border: OutlineInputBorder(),
      //     labelText: 'Password',
      //   ),
      // ),
      // const SizedBox(height: 20),
      // //add button widget
      // ElevatedButton(
      //   //decorate the button
      //   style: ElevatedButton.styleFrom(
      //     backgroundColor: Colors.indigoAccent.withOpacity(0.5),
      //     foregroundColor: Colors.white,
      //   ),
      //   onPressed: () {
      //     //navigate to home page
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => const HomePage(title: 'TrustNet')),
      //     );
      //   },
      //   child: const Text('Login'),
      // ),
      // const SizedBox(height: 10),
      // const Divider(),
      // //add oauth providers
      // const Text('Or login with:',
      //     style: TextStyle(
      //       fontSize: 14,
      //       fontWeight: FontWeight.bold,
      //     )),

      // Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[
      //add icon button widget
      // IconButton(
      //   icon: const Image(
      //     image: AssetImage('assets/images/logoMicrosoft.png'),
      //     width: 72,
      //     //height: 24,
      //   ),
      //   onPressed: () {
      //     //navigate to home page

      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) =>
      //               const HomePage(title: 'TrustNet')),
      //     );
      //   },
      // ),
      // //add icon button widget
      // IconButton(
      //   icon: const Image(
      //     image: AssetImage('assets/images/logoG.png'),
      //     width: 72,
      //     //height: 24,
      //   ),
      //   onPressed: () {
      //     //navigate to home page
      //     //Navigator.pushNamed(context, '/home');
      //   },
      // ),

      // AADLoginButton(
      //   userFlowUrl: aadB2CUserAuthFlow,
      //   clientId: aadB2CClientID,
      //   userFlowName: aadB2CUserFlowName,
      //   redirectUrl: aadB2CRedirectURL,
      //   context: context,
      //   scopes: aadB2CScopes,
      //   onAnyTokenRetrieved: (Token anyToken) {},
      //   onIDToken: (Token token) {
      //     jwtToken = token.value;
      //   },
      //   onAccessToken: (Token token) {},
      //   onRefreshToken: (Token token) {
      //     refreshToken = token.value;
      //   },
      //   onRedirect: (context) => onRedirect(context),
      // ),

      //],
      //         ),
      //       ],
      //     ),
      //   ),
      // )
    );
  }
}
