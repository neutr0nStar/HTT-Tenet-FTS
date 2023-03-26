import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Profile")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.fromLTRB(80, 10, 80, 10),
            child: const CircleAvatar(
              radius: 120.0,
              backgroundImage: AssetImage("assets/avatar.jpg"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Yogita Sharma",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            "Franchise Head",
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.star, size: 32.0, color: Colors.amber),
              Icon(Icons.star, size: 32.0, color: Colors.amber),
            ],
          ),
          const SizedBox(height: 40),
          const Text("Total sales: 4000"),
          const SizedBox(height: 10),
          const Text("Monthly sales: 200"),
        ],
      ),
    );
  }
}
