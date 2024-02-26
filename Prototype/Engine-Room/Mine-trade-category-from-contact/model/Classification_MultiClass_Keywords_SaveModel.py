# -*- coding: utf-8 -*-
"""
Created on Tue Feb 25 05:11:51 2024

@author: josep
"""

import pandas as pd
import numpy as np
import os
import seaborn as sns # used for plot interactive graph.
import matplotlib.pyplot as plt
import joblib
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_selection import chi2
from sklearn.model_selection import train_test_split
from sklearn.svm import LinearSVC
from sklearn.metrics import confusion_matrix
from sklearn import metrics

# lOAD the dataset from the subfolder /data
path = r'C:\Users\rajesh.joseph\Documents\Python\Text Classification'
os.chdir(path)
datapath = "data/Keywords_Search_Database_1Deleted.csv"
df = pd.read_csv(datapath)
# Mapping each category to a number
df['category_id']=np.unique(df['category'], return_inverse=True)[1]
category_id_df = df[['category', 'category_id']].drop_duplicates()
# Dictionary for correlation search
category_to_id = dict(category_id_df.values)
id_to_category = dict(category_id_df[['category_id', 'category']].values)

# Transformingtexts into vectors using Term Frequency-Inverse Document Frequency (TFIDF)
## Parameters of  TfidfVectorizer function##
# min_df: remove the words which has occurred in less than ‘min_df’ number of files
# Sublinear_tf: if True, then scale the frequency in logarithmic scale
# top_words: it removes stop words which are predefined in ‘english’

tfidf = TfidfVectorizer(sublinear_tf=True, min_df=5,
                        ngram_range=(1, 2), 
                        stop_words='english')
# We transform each user text into a vector
features = tfidf.fit_transform(df.text).toarray()
labels = df.category_id
print("Each of the %d user text is represented by %d features (TF-IDF score of unigrams and bigrams)" %(features.shape))

# Finding N most correlated terms with each of the product categories
N = 6
for category, category_id in sorted(category_to_id.items()):
  features_chi2 = chi2(features, labels == category_id)
  indices = np.argsort(features_chi2[0])
  feature_names = np.array(tfidf.get_feature_names_out())[indices]
  unigrams = [v for v in feature_names if len(v.split(' ')) == 1]
  bigrams = [v for v in feature_names if len(v.split(' ')) == 2]
  print("n==> %s:" %(category))
  print("  * Most Correlated Unigrams are: %s" %(', '.join(unigrams[-N:])))
  print("  * Most Correlated Bigrams are: %s" %(', '.join(bigrams[-N:])))
  
## Training Linear Support Vector Machine model ##
X_train, X_test, y_train, y_test,indices_train,indices_test = train_test_split(features, 
                                                               labels, 
                                                               df.index, test_size=0.25, 
                                                               random_state=1)
model = LinearSVC(dual=False)
model.fit(X_train, y_train)
y_pred = model.predict(X_test)

# Classification report
print('\t\t\t\tCLASSIFICATIION METRICS\n')
print(metrics.classification_report(y_test, y_pred, 
                                    target_names= df['category'].unique()))

# Generating a confusion matrix
conf_mat = confusion_matrix(y_test, y_pred)
fig, ax = plt.subplots(figsize=(8,8))
sns.heatmap(conf_mat, annot=True, cmap="Blues", fmt='d',
            xticklabels=category_id_df.category.values, 
            yticklabels=category_id_df.category.values)
plt.ylabel('Actual')
plt.xlabel('Predicted')
plt.title("CONFUSION MATRIX - LinearSVCn", size=16);

# Make prediction with unseen data
X = df['text'] # Collection of user text
y = df['category'] # Target category we want to predict

X_train, X_test, y_train, y_test = train_test_split(X, y, 
                                                    test_size=0.25,
                                                    random_state = 0)
tfidf = TfidfVectorizer(sublinear_tf=True, min_df=5,
                        ngram_range=(1, 2), 
                        stop_words='english')
fitted_vectorizer = tfidf.fit(X_train)
tfidf_vectorizer_vectors = fitted_vectorizer.transform(X_train)
model = LinearSVC(dual=False).fit(tfidf_vectorizer_vectors, y_train)

# Test prediction
## Enter the user the text here to test the model prediction
category_to_test = "Removing old or damaged plaster before applying new finishes or making repairs"
#print(model.predict(fitted_vectorizer.transform([category_to_test])))

joblib.dump(model, 'model.pkl')
print("Model loaded!")

# Load the model that you just saved
model_loaded = joblib.load('model.pkl')
joblib.dump(category_to_test, 'model_columns.pkl')
print("Models columns dumped!")


