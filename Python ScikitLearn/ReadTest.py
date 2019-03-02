print ("Opening the file...")
train = open("dataset/diabetes-train-py.txt", 'r')

#print ("Read all:\n")
#print(train.read())

#print ("Read each char:")
#print(train.read(1))

#print ("\nRead each line:")
#print(train.readline())

#iterate directly
for instance in train:
   print(instance.strip() + "\n")
train.close()