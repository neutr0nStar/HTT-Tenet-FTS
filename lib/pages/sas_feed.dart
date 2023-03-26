import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/pages/home.dart';

class SASFeed extends StatefulWidget {
  const SASFeed({Key? key}) : super(key: key);

  @override
  State<SASFeed> createState() => _SASFeedState();
}

class _SASFeedState extends State<SASFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.pink[200]),
      child: ListView(children: [
        const SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Column(children: const [
              Text("Updates about",
                  style: TextStyle(fontSize: 24, color: Colors.white)),
              SizedBox(height: 8),
              Text(
                "Shikha Aggarwal Sharma",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              )
            ])),
        const SizedBox(
          height: 20,
        ),
        Post(
          name: "IIFA Awards",
          imgSrc: "assets/iifa.jpeg",
          avtrSrc: "assets/sas.jpg",
          desc:
              "The Dream that comes true For the biggest Brand in Diet and Nutrition Shikha Aggarwal Sharma Fat To Slim",
          strRat: 0,
          height: 580.0,
        ),
        Post(
          name: "Padma Shree",
          imgSrc: "assets/padmaShree.jpeg",
          avtrSrc: "assets/sas.jpg",
          desc:
              "It is an honor for Shikha Aggarwal Sharma, our  internationally renowned dietitian and nutritionist, to be invited as a Shark Tank Featured Celebrity. She has been recognized for her remarkable achievements and contributions to the field of nutrition and has been awarded the Padam Shri Award, which is one of India's most prestigious awards.",
          strRat: 0,
          height: 600.0,
        ),
      ]),
    );
  }
}
