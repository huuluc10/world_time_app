import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = 'loading';

  void setupTime() async {
    //function to get the time
    WorldTime instance = WorldTime(
      location: 'Ho Chi Minh',
      flag: 'vn.png',
      url: 'Asia/Ho_Chi_Minh',
    );

    await instance.getTime();
    // print(instance.time);
    // setState(() {
    //   time = instance.time;
    // });
    new Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDaytime': instance.isDayTime,
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Choose a location'),
      //   backgroundColor: Colors.blue[900],
      //   elevation: 0,
      //   centerTitle: true,
      // ),
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
