import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/mobile/view/rondpagem/rondpageblocm/rondPageStateM.dart';
import '../../profilpagem/screens/profilPageScreenM.dart';
import '../rondpageblocm/rondPageBlocM.dart';
import '../rondpageblocm/rondPageEventM.dart';

class RondPageScreenM extends StatefulWidget {
  const RondPageScreenM({super.key});
  @override
  State<RondPageScreenM> createState() => _RondPageScreenStateM();
}

class _RondPageScreenStateM extends State<RondPageScreenM> {
  @override
  void initState() {
    BlocProvider.of<RondPageBlocM>(context);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
            180.0), // Augmente la hauteur de l'AppBar pour inclure le bouton
        child: AppBar(
          backgroundColor: Colors.green,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(
                        top: 17.0,
                        left: 17.0,
                        right: 17.0,
                      ),
                      height: 50.0,
                      width: 50.0,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePageScreenM(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            //border: Border.all(),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/logo.jpeg',
                              ),
                            ),
                          ),
                        ),
                      )),
                  const Spacer(),
                  const Icon(
                    Icons.notifications,
                    size: 34.0,
                    color: Colors.white,
                  )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'SOUTRALI DEALS',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 1.0,
                        ),
                        const Icon(
                          Icons.search,
                          color: Colors.black12,
                          size: 20.0,
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 2.0, right: 2.0, bottom: 9.0),
                          width: 250.0,
                          height: 30.0,
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Recherchez sur soutrali',
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.location_searching,
                          color: Colors.black12,
                          size: 20.0,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 4.0,
                      right: 4.0,
                    ),
                    width: 190.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.lightGreenAccent.shade700,
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.map, size: 20.0, color: Colors.white),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text("Toute la Côte d'Ivoire"),
                        SizedBox(
                          width: 4.0,
                        ),
                        Icon(Icons.my_location,
                            size: 20.0, color: Colors.white),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Corps principal de la page
            Text("Page Rond"),
          ],
        ),
      ),
    );
  }
}
