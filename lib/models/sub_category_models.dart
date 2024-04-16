class SubCategoryModel {
  final String categoryName;
  final String subcategoryId;
  final String subcategoryName;
  final String image; // Add this field

  SubCategoryModel(
      {required this.categoryName,
      required this.image,
      required this.subcategoryId, required this.subcategoryName});
}
