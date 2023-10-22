import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit_shop_search.dart';
import 'package:social_app/cubit/states_shop_search.dart';
import 'package:social_app/remote/components.dart';

class SearchScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    var formKey = GlobalKey<FormState>();
    var searchController =TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context ,state)
        {
          return Scaffold(
            appBar:AppBar() ,
            body:Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    TextFormField(
                      controller: searchController,
                      keyboardType:TextInputType.text,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return' enter text to search';
                        }
                        return null ;
                      },
                      onFieldSubmitted: (String text)
                      {
                        SearchCubit.get(context).search(text);
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon:Icon(
                          Icons.search,
                        ) ,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,),
                    if (state is SearchSuccessState)
                    Expanded(

                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index) => buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice:false, ),
                        separatorBuilder: (context,index) => Divider(height: 2,color: Colors.grey,),
                        itemCount:SearchCubit.get(context).model!.data!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

    );
  }

}
