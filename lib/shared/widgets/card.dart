import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class CardImage extends StatelessWidget {
  const CardImage(
      {Key? key,
      required this.image,
      required this.onPressCard,
      required this.title})
      : super(key: key);
  final VoidCallback onPressCard;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 20,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: <Widget>[
          _buildImage(),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 0,
            child: Container(
              width: 450,
              height: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(20),
                ),
                color: Color.fromRGBO(103, 58, 183, 0.4),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onPressCard(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 175, 157, 207),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: FancyShimmerImage(
            imageUrl: image,
            boxFit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
