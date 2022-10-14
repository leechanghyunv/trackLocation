class SubwayModel {
  final int line, id;
  final String name;
  final double lat, lng;

  SubwayModel({
    required this.line,
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,

  });


}

List<SubwayModel> SubwayInfo2 = [
  SubwayModel(
    id: 1,
    name: '을지로4가',
    line: 2,
    lat : 37.566040,
    lng : 126.997754,

  ),
  SubwayModel(
    id: 2,
    name: '을지로3가',
    line: 2,
    lat : 37.566220,
    lng : 126.990912,

  ),
  SubwayModel(
    id: 3,
    name: '을지로입구',
    line: 2,
    lat : 37.566140,
    lng : 126.982561,

  ),
  SubwayModel(
    id: 4,
    name: '시청',
    line: 2,
    lat : 37.566014,
    lng : 126.982651,

  ),
  SubwayModel(
    id: 5,
    name: '로컬스티치',
    line: 2,
    lat : 37.563396,
    lng : 126.978632,
  ),
  SubwayModel(
    id: 6,
    name: '로컬스티치합정',
    line: 2,
    lat : 37.78583,
    lng : 126.40662,
  ),
];