list = []
f = file('/usr/local/nginx/logs/access.log')
str1 = f.readlines()
f.close()
for i in str1:
    ip = i.split()[0]
    list.append(ip)
    list_num = set(list)
for j in list_num:
    num = list.count(j)
    print '%s : %s' % (j, num)
