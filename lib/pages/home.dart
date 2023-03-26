import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.pink[200]),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 10),
              child: const Text(
                "Popular",
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Post(
              name: "Jyoti Nandan",
              imgSrc: "assets/franchiseHead.jpeg",
              strRat: 2,
              desc: "Starting new position as Franchise head.",
              height: 350.0,
            ),
            Post(
              name: "Divya",
              imgSrc: "assets/beforeAfter.jpeg",
              strRat: 1,
              desc:
                  "Divya got herself changed not by starvation, not by green tea, not by even avocado and broccoli. She eats tasty roti, sabzi, dudh vali chaii etc. Reason: We give our clients protein, vitamins, minerals, zinc and calcium that the human body needs to stay fit.",
              height: 550.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                      height: 200,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )),
                            label: const Text("Upload Image"),
                            icon: const Icon(Icons.image),
                            onPressed: () => Navigator.pop(context),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )),
                            icon: const Icon(Icons.movie),
                            label: const Text('Upload Video'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      )));
                });
          },
          child: const Icon(Icons.upload)),
    );
  }
}

class Post extends StatelessWidget {
  final String name, imgSrc, desc;
  final int strRat;
  String? avtrSrc = "assets/avatar.jpg";
  double height;
  Post(
      {Key? key,
      required this.name,
      required this.imgSrc,
      this.avtrSrc,
      required this.desc,
      required this.strRat,
      required this.height})
      : super(key: key);

  final List<Widget> _stars = <Widget>[
    SizedBox(
      width: 1,
    ),
    Row(
      children: const [
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
      ],
    ),
    Row(
      children: const [
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
      ],
    ),
    Row(
      children: const [
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        // color: Colors.pink[100],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    AssetImage(this.avtrSrc ?? "assets/avatar.jpg"),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                this.name,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 8,
              ),
              _stars[this.strRat]
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image(
              image: AssetImage(this.imgSrc),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            this.desc,
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}
