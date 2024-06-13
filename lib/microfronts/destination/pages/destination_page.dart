import 'package:flutter/material.dart';
import 'package:quind_demo_project/core/components/simple_appbar.dart';

class DestinationPage extends StatefulWidget {
   static const routeName = "/destination";
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:PreferredSize(preferredSize: Size.fromHeight(0), child: SimpleAppbar(message: 'Destination')) ,
      body: SafeArea(child: Column(),),
    );
  }
}