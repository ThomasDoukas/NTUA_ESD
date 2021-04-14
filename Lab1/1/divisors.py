import math
  
# method to print the divisors 
def divisors(n) : 
    div=[]
    i = 1
    while i <= math.sqrt(n): 
        if (n % i == 0) : 
            if (n / i == i) : 
                div.append(int(i)) 
            else : 
                div.append(int(i))
                div.append(int(n/i))  
        i = i + 1
    div.sort()
    print("Divisors of", n, div)

# method to print common divisors
def common_div(a, b):
    div=[]
    for i in range(1, min(a, b)+1): 
        if a%i==b%i==0: 
            div.append(int(i))
    div.sort()
    print("Common divisors of", a, b, div )

divisors(144)
divisors(176)
common_div(144, 176)