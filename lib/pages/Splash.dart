import 'package:ctse_medicine_reminder_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class  Splash extends StatefulWidget {
  const Splash ({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState(){
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 5000), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: Container(
  //         child: Text('Splash Screen', style: TextStyle(
  //           fontSize: 24,
  //           fontWeight: FontWeight.bold
  //         ),),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
              Lottie.network(
              'https://assets4.lottiefiles.com/packages/lf20_otmfyizb.json'),
              Image.network('')
            ],
      ),
    );

  }
}
