class HomeModel
{
bool? status ;
HomeDataModel? data;
HomeModel .fromJson(Map<String,dynamic>json)
{
status = json['status'];
data = HomeDataModel .fromJson(json['data']);
}
}

class HomeDataModel{
  late List<BannersModel> banners= [];
  late List<ProductsModel> products= [];

  HomeDataModel.fromJson(Map<String,dynamic> json){
    json['banners'].forEach((element)
    {
      banners.add(BannersModel.fromJson(element));
    });
    json['products'].forEach((element)
    {
      products.add(ProductsModel.fromJson(element));
    });
  }
}
class BannersModel
{
  int? id ;
  String? image ;

  BannersModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    image=json['image'];

  }
}

class ProductsModel
{
  int? id ;
  dynamic price ;
  dynamic oldprice;
  dynamic discount ;
  String? image ;
  String? name ;
  bool? infavorites;
  bool? incart;


  ProductsModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    price=json['price'];
    oldprice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    infavorites =json['in_favorites'];
    incart=json['in_cart'];
    name=json['name'];

  }
}
