import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fts/pages/homepage.dart';

class Agreement extends StatefulWidget {
  const Agreement({Key? key}) : super(key: key);

  @override
  State<Agreement> createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/agreementBg.png"),
                  fit: BoxFit.cover)),
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  "SAS Fat to Slim",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 100),
              const Text(
                "By clicking Proceed, you agree to the",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 200,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              "Terms and Conditions:- \n\n1.You will use this device solely for business purposes.",
                            ),
                          );
                        });
                  },
                  child: Text("Terms and Conditions")),
              const SizedBox(height: 80),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                  child: const Text("Proceed"),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ])
      ],
    ));
  }
}
