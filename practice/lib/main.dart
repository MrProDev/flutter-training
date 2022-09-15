import 'package:flutter/material.dart';
import 'package:practice/app/app.locator.dart';
import 'package:practice/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: StackedService.navigatorKey,
      initialRoute: Routes.homeScreen,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: index == 0 ? const HomeView() : const LoginView(),
      persistentFooterButtons: [
        OutlinedButton(
          onPressed: () {
            final snackbarService = locator<SnackbarService>();
            snackbarService.registerSnackbarConfig(
              SnackbarConfig(
                backgroundColor: Colors.grey.shade300,
                textColor: Colors.black,
                snackPosition: SnackPosition.TOP,
              ),
            );

            snackbarService.showSnackbar(
              title: 'Notification',
              message: 'User has been added',
              duration: const Duration(seconds: 1),
              mainButtonTitle: 'Show User',
            );
          },
          child: const Text('Show Snackbar'),
        ),
        OutlinedButton(
          onPressed: () async {
            final dialogService = locator<DialogService>();
            await dialogService.showDialog(
              title: 'Test Dialog Title',
              description: 'Test Dialog Description',
              buttonTitle: 'Agree',
              cancelTitle: 'Cancel',
              barrierDismissible: true,
            );
          },
          child: const Text('Show Dialog'),
        ),
        OutlinedButton(
          onPressed: () async {
            final bottomSheetService = locator<BottomSheetService>();
            await bottomSheetService.showBottomSheet(
              title: 'Confirm this action with one of the options below',
              description:
                  'The result from this call will return a SheetResponse object with confirmed set to true. See the logs where we print out the confirmed value for you.',
              confirmButtonTitle: 'Agree',
              cancelButtonTitle: 'Cancel',
            );
          },
          child: const Text('Show Bottomsheet'),
        ),
        OutlinedButton(
          onPressed: () {
            final navigationService = locator<NavigationService>();
            navigationService.navigateWithTransition(const SignUpView());
          },
          child: const Text('Next'),
        ),
      ],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
        ],
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home'),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Login'),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Sign Up'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final navigator = locator<NavigationService>();
          navigator.popUntil((route) => route.isFirst);
        },
        label: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
