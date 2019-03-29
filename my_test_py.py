# 第一题


class Person(object):
    x = 1


class Chird1(Person):
    pass


class Chird2(Person):
    pass


p = Person()
chird1 = Chird1()
chird2 = Chird2()

print("Person.x:", Person.x, "\tChird1.x:", Chird1.x, "\tChird2.x:", Chird2.x)
print("p.x:", p.x, "\t\t\tchird1.x:", chird1.x, "\tchird2.x:", chird2.x)
print()

Person.x = 2
print("Person.x:", Person.x, "\tChird1.x:", Chird1.x, "\tChird2.x:", Chird2.x)
print("p.x:", p.x, "\t\t\tchird1.x:", chird1.x, "\tchird2.x:", chird2.x)
print()

p.x = 3
print("Person.x:", Person.x, "\tChird1.x:", Chird1.x, "\tChird2.x:", Chird2.x)
print("p.x:", p.x, "\t\t\tchird1.x:", chird1.x, "\tchird2.x:", chird2.x)
print()

Chird1.x = 4
print("Person.x:", Person.x, "\tChird1.x:", Chird1.x, "\tChird2.x:", Chird2.x)
print("p.x:", p.x, "\t\t\tchird1.x:", chird1.x, "\tchird2.x:", chird2.x)
print()

chird1.x = 5
print("Person.x:", Person.x, "\tChird1.x:", Chird1.x, "\tChird2.x:", Chird2.x)
print("p.x:", p.x, "\t\t\tchird1.x:", chird1.x, "\tchird2.x:", chird2.x)
print()

# 第二题
my_str = ['a', 'b', 'c']

my_str.append("d")
print(my_str)

my_str.extend("cfre")
print(my_str)

my_str.pop()
print(my_str)


# 第三题

def func(n):
    if n == 0:
        return 0
    elif n == 1 or n == 2:
        return 1
    else:
        return func(n - 1) + func(n - 2)
print(func(6))


# 第四题
dict1 = {1: {2: 3}}
dict2 = dict1
dict1[3] = 4
print(dict1)
print(dict2)
dict2[5] = 6
print(dict1)
print(dict2)

# 第五题
print(sum(range(1, 101)))