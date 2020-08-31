class CreateChat {
  String member1;
  String member2;

  CreateChat({
    this.member1,
    this.member2,
  });

  Map<String, dynamic> toMap() {
    return {
      'member1': member1,
      'member2': member2,
    };
  }
  
  


}
