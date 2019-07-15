import datetime
idlist = []
for _ in range(20):
    s1 = datetime.datetime.now().timestamp()
    # 返回的是时间戳，但是带微秒
    s2 = ".join([str(random.randint(0,9)) for _ in range(3)])"
    s3 = ".join([chr(random.randint(97,122)) for _ in range(8)])"
    idlist.append(str(int(s1)) + '_' + s2 + '_' + s3)
print(idlist)
