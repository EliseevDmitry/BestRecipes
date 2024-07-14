import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.spoonacular.com"
    static let apiKey = Token.notOne
}

struct Token {
    // сюда надо будет добавлять ключи по мере надобности, если буду заканчиваться запросы
    static let first = "c43c39b0497e4b8097041fadd20b4b81"
    static let second = "8f5e1777a6114f57849b7b0de3c210ca"
    static let third = "964e220d4a9c416bb49c29c11a8b633a"
    static let forth = "c56516ad0a6d44779012eb74893b6af2"
    static let fifth = "f9cc19628f7c4aec92404da9af033f0c"
    static let six = "b49c1606b4d744d69c543e592c416db1"
    static let seven = "2b1c595159634ca9ba0e817b419a533b"
    static let eight = "42e4c545906048f28d1037cb79d9eb72"
    
    static let reservOne = "2970b49d7c754669aece7b55a25ef7b8"
    static let reservTwo = "3df4748a170f45ce9c519d7371a16480"
    static let reservThree = "3ea21aa2dee34d8382cc0c92fa86348d"
    static let reservFour = "961884e4a54a440693fc978235b835e2"
    static let reservFive = "8c612b11d5b74a1b908fd6d65a886e50"
    static let reservSix = "ec166d4297494de6980de93119696ed9"
    static let reservSeven = "bd24d1d058c4386b650f7ce1bbdce07"
    static let reservEight = "823b69d6de03422398b29958e6cb178f"
    static let reservTen = "59ece5a665f9455c92dad51057fd5100"
    
    //Резервные для защиты проекта - тратьть только экстренно
    static let notOne = "0fed29fb2c044908aba3c7879ffb5b46"
    static let notTwo = "f7288bef5fe84596a8c1f3a33a8e1a47"
    static let notThree = "eb24898795f34d798113b57081d58185"
    
    //"36437384580348f2ae7250f5236a3440"
    //"5d260a98d98e4415a350998bcf1228dc"
    //"317592d32b1e4346ba205b6abdd25330@
   // d26a93b80f2a42ce92bb50e11f919a5a
   // ebe130adc0bc4d12880fb57604199462
   // 8536fb33b7c54bc38372aca6b29a9f8a
   // 7ddb73a2fb89463ba5a46c2e00a4f0b9
   // b20f3313345d433e9d05456ea127e83c
   // 00435827194f450a97ac4576ed729102
   // eaf1139adca04256a9e88a79b320db9c
}
