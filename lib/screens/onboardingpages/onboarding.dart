import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:coachui/screens/onboardingpages/authpages/signin.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();
    final List<Map<String, dynamic>> onboardingData = [
      {
        'text': 'Welcome to CrickWorld',
        'subtitle': 'Discover your cricket journey.',
        'buttonText': 'Get Started',
        'buttonAction': () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      {
        'text': 'Cricket Training',
        'subtitle': 'Enhance your skills with our training.',
        'buttonText': 'Start Training',
        'buttonAction': () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      {
        'text': 'Custom Training',
        'subtitle': 'Tailored training plans just for you.',
        'buttonText': 'Start Training',
        'buttonAction': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
          );
        }
      },
    ];

    // List of image paths for each onboarding page
    final List<String> imagePaths = [
      'assets/u1.png', // Image for the first page
      'assets/u2.png', // Image for the second page
      'assets/u3.png', // Image for the third page
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                final data = onboardingData[index];

                // Define your custom flex values here
                final double imageFlex = 3.5; // Example: you can adjust this
                final double containerFlex = 2.5; // Example: you can adjust this

                return Column(
                  children: <Widget>[
                    Expanded(
                      flex: imageFlex.toInt(), // Use toInt() to convert double to int for flex
                      child: Image.asset(
                        imagePaths[index], // Use the corresponding image path
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      flex: containerFlex.toInt(), // Use toInt() to convert double to int for flex
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, -5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              data['text'],
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8), // Added space between title and subtitle
                            Text(
                              data['subtitle'], // New subtitle text
                              style: const TextStyle(fontSize: 16, color: Colors.grey), // Light dark color text
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => data['buttonAction'](),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  data['buttonText'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6A41B8),
                                minimumSize: const Size(double.infinity, 0),
                              ),
                            ),
                            if (index == 0) // Add text only on the first page
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  SignInPage()),
                                    ); // Navigate to the SignIn page
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                                    child: Row(
                                      children: const [
                                        Text(
                                          'Already have an account?',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          ' Sign in',
                                          style: TextStyle(color: Color(0xFF6A41B8)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: onboardingData.length,
            effect: ExpandingDotsEffect(
              dotColor: Colors.grey,
              activeDotColor: Theme.of(context).primaryColor,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 10,
            ),
          ),
        ],
      ),
    );
  }
}
