library globals;

import 'package:mobile_app/model/profile_model.dart';

//create a static variable for userprofile
UserProfile globalUserProfile = UserProfile(isVerified: 0);

List<UserContact> globalSharedContacts =
    List<UserContact>.empty(growable: true);
