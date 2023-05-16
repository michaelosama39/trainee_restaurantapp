import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../../generated/l10n.dart';
import '../widgets/about_app_screen_content.dart';


class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {



  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: TransparentAppBar(
          title: Translation.of(context).about_app,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AboutAppScreenContent(),
      );
  }
}
