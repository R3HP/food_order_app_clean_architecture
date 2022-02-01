import 'package:flutter/material.dart';
import 'package:food_order_app/features/accounting/presentation/cubit/account_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/pictures/pasta2.jpeg'),
              fit: BoxFit.fitHeight),
        ),
        width: double.infinity,
        child: Container(
          padding:
              EdgeInsets.only(left: 15.0, right: 15.0, top: size.height * 0.65),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.black.withOpacity(0.5),
            Colors.black.withOpacity(0.75)
          ], begin: Alignment.center, end: Alignment.bottomCenter)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Fast Healthy Food',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Discover More Than 10 Foods In All Categories Even Fucing Vegan',
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 10),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () => showMyModalBottomSheet(context, true),
                child: const Text(
                  'SignUp',
                ),
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(25.0),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    fixedSize:
                        MaterialStateProperty.all<Size>(Size(size.width, 60)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => showMyModalBottomSheet(context, false),
                child: const Text('SignIn'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    elevation: 15,
                    side: BorderSide(width: 1, color: Colors.green),
                    onPrimary: Theme.of(context).colorScheme.onPrimary,
                    primary: Colors.transparent,
                    minimumSize: Size(size.width, 60),
                    textStyle: TextStyle(fontStyle: FontStyle.italic)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showMyModalBottomSheet(BuildContext context, bool isSignUp) {
    String? email;
    String? password;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      enableDrag: true,
      elevation: 35,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AnimatedContainer(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        // padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: MediaQuery.of(context).viewInsets.bottom),
        duration: const Duration(milliseconds: 1),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (string) {
                email = string;
              },
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              onChanged: (string) {
                password = string;
              },
              onEditingComplete: (email == null) || (password == null)
                  ? null
                  : () {
                      Navigator.of(context).pop();
                      if (isSignUp) {
                        singup(email!, password!, context);
                      } else {
                        singIn(email!, password!, context);
                      }
                    },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(180, 30), primary: Colors.green),
                onPressed:
                    //  (email == null) || (password == null)
                    //     ? null
                    //     :
                    () {
                  Navigator.of(context).pop();
                  if (isSignUp) {
                    singup(email!, password!, context);
                  } else {
                    singIn(email!, password!, context);
                  }
                },
                child: const Text('Submit'))
          ],
        ),
      ),
    );
  }

  singup(String email, String password, BuildContext context) {
    context.read<AccountCubit>().signUpAccount(email, password);
  }

  void singIn(String email, String password, BuildContext context) {
    context.read<AccountCubit>().signInAccount(email, password);
  }
}
