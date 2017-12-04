# FastDecorators
A technique to create *decorators* without having to wrap all methods.

# Why?
*Decorators* are a great way to add new features to an existing class, or change existing behaviour. In my opinion, better than *inheritance*, because each feature is isolated from the main class and will never ever never change its behaviour.
There's one problem with *decorators*, though, because if you need to decorate one single method from the original implementation, you still have to create *wrapper methods* for all the other methods, just passing the messages from the decorated object to the original object. And this can be tedious.

# But is that really a problem?
Well, implementation classes shoud have as few as possible methods. The **Single Responsability Principle**, if taken into account like it should, will prevent many methods in the same implementation. On top of that, if you have few *decorators* for a class, it's not that hard to create its wrappers.
Still, if you have as few as two *decorators* for the same object, you will undoubtedly have **code duplication** (even if it is merely structural code). This is a fact. And code duplication is generally one of those things you want to avoid.

# What can be done about it?
There is one thing you can do about it. That's exactly what this technique is about.
It consists in creating one *decorator* with wrappers for all the methods, and leaving the *Origin field* as a **private field**.
Then, every *decorator* will descend from this class and override the methods they actually need to implement/change.

# So does this mean we should always use this?
Hell no! If you will only have one *decorator* for your *interface*, why would you do it? No point in that. Remember, **if you don't need it, don't do it**. And if you have more than one *decorator*, but the *interface* has only one method (or you need to decorate all methods), don't do it. Keep it simple. Why use inheritance to override all methods? No point in that!
**Use it only when its advantages outweigh its disadvantages**. That's the whole point of everything in life, isn't it?

# Usage:
For every *interface* you need to create *decorators* (and are not auto excluded by the criteria stated in the **So does this mean we should always use this?** section) one class should be created.
This class should conform to traditional *decorators*, implementing the *interface* it aims to decorate:
* It should accept in its constructor an origin object that implements the same *interface*.
* It should also create wrappers for all *interface* methods.
* All of these wrappers should be overridable.

That's it. Every *decorator* will then descend from this class, and override the methods it needs to decorate. No other method need to be touched, and the base class will do all the wrapping. If needed, the constructor could be overloaded to allow other parameters needed by the *decorator*, but it should always, like every *decorator*, have its Origin field.

# The example:
This example was created in **Object Pascal**, but it applies to almost every language.
* On the file **FooIntf.pas** you'll find the *interface* declaration, and the "*Decorable Class*".
* On the file **FooImpl.pas** you'll find the *interface* implementation class, and some *decorators* to simulate its usage.
* The files **"FastDecoratorTest.*"** are a simple Delphi project to test this technique.

# Conclusion
This is definitely not a consensual technique, nor does it mean to be. If you don't feel at ease with using *inheritance* in this manner, don't. You don't need this to create *decorators*. This only allows saving a small amount of work in some cases.
If, however, you don't see a problem with this, then why not? 
