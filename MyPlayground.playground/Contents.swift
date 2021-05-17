class People {
    let name: String
    init(name: String) { self.name = name; self.dc = DC() }
    var apartment: Apartment?              // 人住的公寓属性
    var desc: String?
    var dc: DC
deinit {
        print("People被销毁")
    }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: People?                   // 公寓中的人的属性
    var desc: String?
    var dc: DC?
    deinit {
        print("Apartment被销毁")
    }
}

class DC {
    let num = 0
}

var people1: People? = People(name: "Dariel")  // 定义两个实例变量
var apartment1: Apartment? = Apartment(unit: "4A")

people1!.apartment = apartment1           // 两者相互引用
apartment1?.tenant = people1              // 而且彼此都是强引用
people1?.desc = "1"
apartment1?.desc = people1?.desc
apartment1?.dc = people1?.dc

people1 = nil
apartment1 = nil                          // 两个引用都置为nil了,但实例并没有销毁
