import numpy as np

#raw and basic data
X = np.array([[-1, -1], [-2, -1], [1, 1], [2, 1]])
y = np.array([1, 1, 2, 2])

#I use SVM as classifier
from sklearn.svm import SVC
clf = SVC(probability=True)
clf.fit(X, y) 
print(clf.predict([[-0.8, -1]]))
print(clf.decision_function([[-0.8, -1]]))
print(clf.predict_proba([[-0.8, -1]]))
