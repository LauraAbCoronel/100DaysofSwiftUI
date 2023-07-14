import Cocoa

/*
 - Make a class hierarchy for animals
 - Start with Animal. Add a legs property for the number of legs an animal has.
 - Make Dog a subclass of Animal, giving it a speak() method that prints a dog barking string, but each subclass should print something different
 - Make Corgi and Poodle subclasses of a Dog
 - Make Cat an Animal subclass. Add a speak() method, with each subclass printing something different, and an isTame Boolean, set with an initializer
 - Make Persian and Lion as subclasses of Cat
*/

class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
    
    func speak() {
        assertionFailure("This should never be called")
    }
}

class Dog: Animal {
    override func speak() {
        print("Woof!")
    }
}

final class Corgi: Dog {
    override func speak() {
        print("Bark")
    }
}

final class Poodle: Dog {
    override func speak() {
        print("Fancy Bark")
    }
}

class Cat: Animal {
    let isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    
    override func speak() {
        print("Purr")
    }
}

final class Persian: Cat {
    override func speak() {
        print("Meow")
    }
}

final class Lion: Cat {
    override func speak() {
        print("Roar")
    }
}
