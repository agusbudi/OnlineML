#http://www.i-programmer.info/programming/python/3942-arrays-in-python.html

myList=[1,2,3,4,5,6]
print(myList) #is the entire list.
print(myList[:]) #is the entire list.
print(myList[2]) #will display the third element
myList[2]=100 #change the value
print(myList[2:5]) #is a sublist from the third element to the fifth
print(myList[4:]) #is the list from List[4] to the end of the list 
print(myList[:5]) #is the list up to and not including myList[5] 

myList[0:2]=[0,1] # same as myList[0]=0 and myList[1]=1

#For example, to find the maximum value (forgetting for a moment that there is a built-in max function)  you could use:
m=0
for e in myList:
 if m<e:
  m=e
  print(m)

# In most cases arrays are accessed by index and you can do this in Python:
m=0
for i in range(len(myList)):
 if m<myList[i]:
  m=myList[i]
  print(m)

#if you wanted to return not the maximum element but its index position in the list you could use
m=0
mi=0
for i in range(len(myList)):
 if m<myList[i]:
  m=myList[i]
  mi=i
  print(mi)

#or you could use the non-indexed loop and the index method:
m=0
for e in myList:
 if m<e:
  m=e

mi=myList.index(m)
print(mi)

#The only problem is that index(m) returns the index of m in the list or an error if m isn't in the list. There is also the slight problem that behind the scenes it is clear that index is performing another scan of the entire list.


#more complex
print ("Opening the file...")
train = open("diabetes/diabetes-train-py.txt", 'r')

temp =[]
datatrain = []
ztrain = []
for row in train:
	temp = row.strip().split(',')
	#if all values are float, we have to convert
	print(temp)
	temp2 = []
	label = len(temp)
	j=1
	for column in temp:
		if j==label:
			ztrain.append(int(column))
		else:
			temp2.append(float(column))
		j=j+1
	datatrain.append(temp2)
train.close()

print(datatrain[1][2]) #second line, third column
print(ztrain)
