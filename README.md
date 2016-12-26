# FastDecorators
A technique to create *decorators* without having to wrap all methods.

# Why
*Decorators* are a great way to add new features to an existing class, or change existing behaviour. In my opinion, better than *inheritance*, because each feature is isolated from the main class and will never ever never change its behaviour.
There's one problem with *decorators*, though, because if you need to decorate one single method from the original implementation, you still have to create *wrapper methods* for all the other methods, just passing the messages from the decorated object to the original object. And this can be tedious.

# But is that really a problem?
Well, implementation classes shoud have as few as possible methods. The **Single Responsability Principle**, if taken into account like it should, will prevent many methods in the same implementation. On top of that, if you have few *decorators* for a class, it's not that hard to create its wrappers.
Still, if you have as few as two *decorators* for the same object, you will undoubtedly have **code duplication**. This is a fact. And code duplication is generally one of those things you want to avoid.

# What can be done about it?
There is one thing you can do about it. That's exactly what this technique is about.
It consists in creating one *decorator* with wrappers for all the methods, and leaving the *Origin field* as a **protected field**.
Then, every *decorator* will descend from this class and override the methods they actually need to implement/change.

# Wait, what? Protected? No way!!!
Yeah, I know what you mean. *Protected fields* are like *global variables* in the scope of the class hierarchy. And that's bad, right?
Yeah, I actually think it is bad... Most of the times. Like every other feature, *protected fields* can be used to create really destructive stuff, so you should definitely avoid them. But like every other feature, there's a time and a place. I do believe that in this particular case, the advantages might, sometimes, outweigh the costs.

# Let's think this through
There are some common dangers to the use of *protected fields*:
* "They tend to lead to **YAGNI** issues". If you don't actually need to do something with the *protected field*, just don't use it.
  Well, that's for sure. No argument there. In this case, will we actually need it? Of course. The *decorator* class can't inherit the wrappers and still override them when needed if the field isn't accessible by them.
* "They tend to lead to **LSP** issues". *Substitutability* means you can replace the use of a class with another class derived from the first one. Than can be a problem with *protected fields*.
  Once again, true story. It can be a problem most of the times. But not in this particular case, I believe. We're talking about *decorators*, so this particular *protected field* will be used as the Origin class, whatever that is. As long as it obeys its contract (*Interface*), it doesn't matter what class it is.
* "They tend to violate **OCP**". If the base class relies heavily on the known behaviour of the *protected field*, might end up being affected by it.
  Also true, and this applies to every case, even this one. If a *decorator* descends from this special class changes the value of the *protected field*, all wrappers will wrap that value's behaviour, and not the original one. Will that be a problem? Could be. But we're also counting on that behaviour for this to work, so... Sometimes, a *decorator* constructor will need not only the Origin class as a parameter, it will also need other other values to do its decoration. In that case, overloading the constructor for this special class with be mandatory. The wrappers should reflect that change in the origin field, and wrap that new value. So this is really what we need. Is it dangerous? Yes. So is crossing the street, but sometimes we need to do it.
* "They tend to lead to inheritance for extension rather than composition". 
  This is also a fact. And there's no defense for this. We will be inheriting in order to extend its behaviour, not for composition.
  The only thing I can say for this is that this particular class is made for extension. The only behaviour it has is wrapping the behaviour of other. It doesn't have behaviour of its own to test, so it will not be a source of trouble when testing it's descendants. We'll just have to make a leap of faith on that one.
  
**Using this method does require the developer to have self-control. No processing of any kind should be done in this class. It can only have a constructor with an Origin field, and the wrappers for the interface it applies to. Any deviation from this will make its own point to proove why a protected field shouldn't be considered.

# So does this mean we should always use this?
Hell no! If you will only have one *decorator* for your *interface*, why would you do it? No point in that. Remember, **if you don't need it, don't do it**. And if you have more than one *decorator*, but the *interface* has only one method (or you need to decorate all methods), don't do it. Keep it simple. Why use inheritance to override all methods? No point in that!
**Use it only when its advantages outweigh its disadvantages**. That's the whole point of everything in life, isn't it?

# Usage:
For every *interface* you need to create *decorators* (and are not auto excluded by the criteria stated in the **So does this mean we should always use this?** section, one class should be created.
This class should conform to traditional *decorators*, implementing the *interface* it aims to decorate:
* It should accept in its constructor an origin object that implements the same *interface*.
* It should also create wrappers for all *interface* methods.
* All of these wrappers should be overridable.
* Its Origin field should be *protected*, rather than *private*.

That's it. Every *decorator* will then descend from this class, and override the methods it needs to decorate. No other method need to be touched, and the base class will do all the wrapping. If needed, the constructor could be overloaded to allow other parameters needed by the *decorator*, but it should always, like every *decorator*, have its Origin field.
