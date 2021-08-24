class Restaurant{

  String? imageUrl;
  String? name;
  String? categories; // csv

  Restaurant.name(this.imageUrl, this.name, this.categories,
      );

  toMap() => {
    "imageUrl": imageUrl,
    "name": name,
    "categories": categories,

  };

  /*sort(){
  }*/

  @override
  String toString() {
    return 'Restaurant{imageUrl: $imageUrl, name: $name, categories: $categories,}';
  }
}