import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class InfoCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
          onTap: () {
            showDialog(
              context: (context),
              builder: (context) {
                return CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 300,
                    initialPage: 1,
                    viewportFraction: 0.9,
                  ),
                  items: [
                    Material(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(color: Colors.cyan),
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                    child: Text(
                                  "Bilgilendirme Kartları",
                                  style: TextStyle(color: Colors.white),
                                ))),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            );
          },
          child: Icon(Icons.info, color: Colors.amber)),
    );
  }
}
