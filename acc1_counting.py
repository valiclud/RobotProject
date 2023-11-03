'''
Created on 2. 11. 2023

@author: valic
'''

if __name__ == '__main__':
    n = 100
    for x in range(n, 0, -1):
        flag = True
        if (x%5==0):
            print("Agile")
            flag = False
        if (x%3==0):
            print("Software")
            flag = False
        if (x%5==0 and x%3==0):
            print("Testing")
        if flag:
            print(x)