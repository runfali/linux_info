s = input("请输入密码： ")
count = 0
flag1, flag2, flag3, flag4 = True, True, True, True
len = len(s)
if len >= 10 and len <= 15:
    for i in s:
        if i in "0123456789":
            if flag1:
                count += 1
            flag1 = False
        if i in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
            if flag2:
                count += 1
            flag2 = False
        if i in "abcdefghijklmnopqrstuvwxyz":
            if flag3:
                count += 1
            flag3 = False
        if i in "_":
            if flag4:
                count += 1
            flag4 = False
    if count == 4:
        print("it's a right passwd")
    else:
        print("passwd is wrong")
else:
    print("the length is wrong")
