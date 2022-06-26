import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  Widget desktopLayout() {
    return Row(children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Website\nDevelopers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'We have taken each and every project handed over to us as a challenge, which has helped us achieve a high project success rate.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () {},
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                  child: Text(
                    'Our Packages',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Expanded(child: Image.asset('assets/images/lp_image.png')),
    ]);
  }

  Widget mobileLayout() {
    return Column(children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Website\nDevelopers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'We have taken each and every project handed over to us as a challenge, which has helped us achieve a high project success rate.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {},
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                child: Text(
                  'Our Packages',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Image.asset('assets/images/lp_image.png'),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext buildContext, BoxConstraints boxConstraints) {
        if (boxConstraints.maxWidth > 800) {
          return desktopLayout();
        } else if (boxConstraints.maxWidth > 200) {
          return mobileLayout();
        }

        return Container(
          color: Colors.red[20],
          child: const Text('Not fittable content'),
        );
      },
    );
  }
}
