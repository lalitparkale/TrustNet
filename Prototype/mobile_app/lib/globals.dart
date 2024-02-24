library globals;

import 'package:mobile_app/model/profile_model.dart';

//create a static variable for userprofile
final UserProfile globalUserProfile = UserProfile(isVerified: 0);

final List<UserContact> globalSharedContacts = getSharedContacts();
