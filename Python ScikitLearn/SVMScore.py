#the aim of this program is to understand the original classifier score of SVM and after Platt scaling (in interval [0,1])

#open data
print ("training data...")
train = open("dataset/diabetes-train-py.txt", 'r')

temp =[]
datatrain = []
ztrain = []
for row in train:
	temp = row.strip().split(',')
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

#import numpy
import numpy as np
X = np.array(datatrain)
y = np.array(ztrain)

#do classification
from sklearn import svm
clf = svm.SVC(kernel='linear',probability=True)
clf.fit(X, y) #train


#test
print ("testing data...")
test = open("dataset/diabetes-test-py.txt", 'r')
datatest = []
ztest = []
accuracy = 0
for row in test:
	temp =[]
	temp = row.strip().split(',')
	temp2 = []
	label = len(temp)
	j=1
	for column in temp:
		if j==label:
			ztest.append(int(column))
		else:
			temp2.append(float(column))
		j=j+1
	datatest.append(temp2)
test.close()

#printout into file
target = open("dataset/SVMpredict-diabetes.txt", 'w')
i=0
X = np.array(datatest)
y = np.array(ztest)
for row in X:
	target.write(np.array_str(clf.predict([row])))
	print(clf.predict([row]), end="")
	target.write(" ")

	print(" ", end="")
	target.write(np.array_str(clf.score([row],[y[i]], sample_weight=None)))
	print(clf.score([row],[y[i]], sample_weight=None), end="")
	target.write(" ")

	print(" ", end="")
	target.write(np.array_str(clf.decision_function([row])))
	print(clf.decision_function([row]), end="")
	target.write(" ")

	print(" ", end="")
	target.write(np.array_str(clf.predict_proba([row])))
	print(clf.predict_proba([row]), end="")

	target.write(" ")
	print(" ", end="")
	target.write(np.array_str(y[i]))
	print(y[i])
	target.write("\n")
	i=i+1

target.close()
