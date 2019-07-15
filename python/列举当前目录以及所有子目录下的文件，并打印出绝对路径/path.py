import os
for root, dirs, files in os.walk('/tmp'):
    for name in files:
        print(os.path.join(root, name))
os.walk()