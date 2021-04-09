
import '../models/internship_text.dart';

class Internship {
  final int id;
  final String name;
  final List<InternshipDetail> details;
  final String companyName;
  static List<Internship> appliedInt;

  Internship(this.id,this.name, this.details,this.companyName);

  static Internship apply(int id)
  {

    List<Internship> internships = Internship.fetchAll();

    for (var i =0; i<internships.length; i++)
    {
      if (internships[i].id == id)
      {
        appliedInt.add(Internship.fetchById(id));
        return appliedInt[i];
      }

    }
    return null;
    
  }

  static Internship fetchById(int id)
  {
    List<Internship> internships = Internship.fetchAll();

    for (var i =0; i<internships.length; i++)
      {
        if (internships[i].id == id)
          {
            return internships[i];
          }

      }
    return null;

  }


  static List<Internship> fetchAll() {
    return [
      Internship(1,'Frontend mips deveper',
          [InternshipDetail('It is nice job best in village', '#mips #anime #lmao')],'Citebeur'),
      Internship(2,'Backend',
          [InternshipDetail('Backend is good', '#mips #duzob #zob')],'Sebastian studios'),
      Internship(3,'Backend mips developer',
          [InternshipDetail('Best job guys yeah yeah eayh', '#black #cock #gang')],'Mipsilon'),
      Internship(4,'Blowjob squad skopje',
          [InternshipDetail('Travel mips and study with the famous blowjob skopje famous blowjob skopje famous blowjob skopje', '#black #cock #gang')],'Lmao studios')
    ];
  }
}
