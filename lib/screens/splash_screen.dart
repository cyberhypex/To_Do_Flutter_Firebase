
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro/screens/HomeScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    
    Future.delayed(Duration(seconds: 5),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomePage()));
    });
  }


  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    overlays: SystemUiOverlay.values
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      
      body: Center(
        child: Container(
          
          decoration: BoxDecoration(
           gradient: LinearGradient(colors: [Colors.deepPurpleAccent,Colors.lightBlue,Colors.deepPurple],
           begin: Alignment.topLeft,
             end: Alignment.bottomRight

           ),

         ),

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            child: Center(
              child: Center(
                child: AnimatedTextKit(animatedTexts: [
                  TypewriterAnimatedText(
                    'To-Do',
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width*0.14/**/,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 700),
                  )
                ],

                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 1000),
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
