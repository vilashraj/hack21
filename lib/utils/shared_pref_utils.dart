import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Meditab Software Inc. CONFIDENTIAL
/// __________________
/// 
///  [2018] Meditab Software Inc.
///  All Rights Reserved.
/// 
/// NOTICE:  All information contained herein is, and remains
/// the property of Meditab Software Inc. and its suppliers,
/// if any.  The intellectual and technical concepts contained
/// herein are proprietary to Meditab Software Incorporated
/// and its suppliers and may be covered by U.S. and Foreign Patents,
/// patents in process, and are protected by trade secret or copyright law.
/// Dissemination of this information or reproduction of this material
/// is strictly forbidden unless prior written permission is obtained
/// from Meditab Software Incorporated.

/// <h1>shared_pref_utils</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 1:03 pm
/// 
enum SharedPrefKey {
  userId,
  email,
}
class SharedPrefUtils {


  static final SharedPrefUtils _singleton = SharedPrefUtils._internal();

  SharedPrefUtils._internal();

  factory SharedPrefUtils() {
    return _singleton;
  }

  setValue({SharedPrefKey key, var value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case String:
        prefs.setString(describeEnum(key), value);
        break;
      case int:
        prefs.setInt(describeEnum(key), value);
        break;
      case bool:
        prefs.setBool(describeEnum(key), value);
        break;
      case double:
        prefs.setDouble(describeEnum(key), value);
        break;
    }
  }

  getValue({SharedPrefKey key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(describeEnum(key));
  }

  clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }


}