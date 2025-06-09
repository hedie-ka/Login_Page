import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'FirstPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentsDir = await getApplicationCacheDirectory();
  Hive.init(documentsDir.path);
  await Hive.openBox('Storage');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        );
      },
    );
  }
}
