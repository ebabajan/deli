
import 'package:delidove_api/models/customer.dart';
import 'package:delidove_api/service/api_service.dart';
import 'package:flutter/material.dart';


class SignupPage extends StatefulWidget
{
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() =>_SignupPageState();
  
}

class _SignupPageState extends State<SignupPage>
{

  var firstName = "";
  var lastName = "";
  var email = "";
  var password = "";

  APIService apiService = APIService();
  CustomerModel  model = CustomerModel();
   final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

 


  @override
  
  void initState(){
    super.initState();
  }

   void createCustomer(){
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      apiService.createCustomer(model).then((ret){
        print(ret);
      });
    }
    print(model.firstName);
    print(model.email);
  }
  
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(140, 50, 30, 0.2),
        automaticallyImplyLeading: true,
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('First Name'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters.';
                  }
                  return null;
                },
                onSaved: (value) {
                  model.firstName = value!;
                },
              ), 
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Last Name'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50) {
                          return 'Must be between 1 and 50 characters.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        model.lastName = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('email'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50) {
                          return 'Must be between 1 and 50 characters.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        model.email = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  
                ],
              ),
              const SizedBox(height: 12),
               Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Password'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50) {
                          return 'Must be between 1 and 50 characters.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        model.password = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed:(){
                      createCustomer();
                    },// _saveItem,
                    child: const Text('Add Item'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  

}