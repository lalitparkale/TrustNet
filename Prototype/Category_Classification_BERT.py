# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

# Libraries needed for data preparation
import pandas as pd
import numpy as np

# Download the dataset and put it in subfolder called data
datapath = "data/Keyword_Search_Database.csv"
df = pd.read_csv(datapath)
df = df[["category", "text"]]

# Show the data
df.head()

print('Total number of news: {}'.format(len(df)))
print(40*'-')
print('Split by category:')
print(df["category"].value_counts())
print(40*'-')
nr_categories = len(df["category"].unique())
print("Number of categories: {n}".format(n=nr_categories))

# Renaming, Input -> X, Output -> y
X = df['text']
y=np.unique(df['category'], return_inverse=True)[1]
print(y)

# distilBERT tokenizer
import transformers
tokenizer = transformers.DistilBertTokenizer.from_pretrained('distilbert-base-uncased')

import tensorflow as tf
X_tf = [tokenizer(text, padding='max_length', max_length = 512, truncation=True)['input_ids'] for text in X]
X_tf = np.array(X_tf, dtype='int32')
# Train/test split
from sklearn.model_selection import train_test_split
X_tf_train, X_tf_test, y_tf_train, y_tf_test = train_test_split(X_tf, y, test_size=0.3, random_state=42, stratify=y)
print('Shape of training data: ',X_tf_train.shape)
print('Shape of test data: ',X_tf_test.shape)

# Get BERT layer
config = transformers.DistilBertConfig(dropout=0.2, attention_dropout=0.2)
dbert_tf = transformers.TFDistilBertModel.from_pretrained('distilbert-base-uncased', config=config, trainable=False)

# Let's create a sample of size 5 from the training data
sample = X_tf_train[0:5]
print('Object type: ', type(dbert_tf(sample)))
print('Output format (shape): ',dbert_tf(sample)[0].shape)
print('Output used as input for the classifier (shape): ', dbert_tf(sample)[0][:,0,:].shape)

from tensorflow.keras import models, layers, metrics

input_ids_in = layers.Input(shape=(512,), name='input_token', dtype='int32')

x = dbert_tf(input_ids=input_ids_in)[0][:,0,:]
x = layers.Dropout(0.2, name='dropout')(x)
x = layers.Dense(64, activation='relu', name='dense')(x)
x = layers.Dense(5, activation='softmax', name='classification')(x)

model_tf = models.Model(inputs=input_ids_in, outputs = x, name='ClassificationModelTF')

model_tf.compile(optimizer='adam',loss='sparse_categorical_crossentropy', metrics=[metrics.SparseCategoricalAccuracy()])
model_tf.summary()

from datetime import datetime
# Train the model
start_time = datetime.now()
history = model_tf.fit(X_tf_train, y_tf_train, batch_size=32, shuffle=True, epochs=5, validation_data=(X_tf_test, y_tf_test))
end_time = datetime.now()

training_time_tf = (end_time - start_time).total_seconds()

from matplotlib import pyplot as plt

fig, ax = plt.subplots(nrows=1, ncols=2, figsize=(15, 5))
ax[0].set(title='Loss')
ax[0].plot(history.history['loss'], label='Training')
ax[0].plot(history.history['val_loss'], label='Validation')
ax[0].legend(loc="upper right")

ax[1].set(title='Accuracy')
ax[1].plot(history.history['sparse_categorical_accuracy'], label='Training')
ax[1].plot(history.history['val_sparse_categorical_accuracy'], label='Validation')
ax[1].legend(loc="lower right")

accuracy_tf = history.history['val_sparse_categorical_accuracy'][-1]
print('Accuracy Training data: {:.1%}'.format(history.history['sparse_categorical_accuracy'][-1]))
print('Accuracy Test data: {:.1%}'.format(history.history['val_sparse_categorical_accuracy'][-1]))
print('Training time: {:.1f}s (or {:.1f} minutes)'.format(training_time_tf, training_time_tf/60))

model_tf.save('model_tf.h5', save_format='h5')
model_tf2 = models.load_model('model_tf.h5', custom_objects={'TFDistilBertModel': dbert_tf})
model_tf2.summary()

def print_my_examples(inputs, results):
  result_for_printing = \
    [f'input: {inputs[i]:<30} : score: {results[i][0]:.6f}'
                         for i in range(len(inputs))]
  print(*result_for_printing, sep='\n')
  print()

examples = [
    'Undertaking unique woodworking projects based on client specifications',
    'Building walls to mark property boundaries',
    'Installing decorative cornices or moldings on walls and ceilings for aesthetic appeal',
    'Applying waterproofing membranes or sealants in areas where tiles are installed, such as bathrooms and wet rooms',
    'Installing concrete curbs along driveways, walkways, or landscaped areas'
]

# Tokenize the examples
tokenized_examples = [tokenizer(example, padding='max_length', max_length=512, truncation=True)['input_ids'] for example in examples]
tokenized_examples = np.array(tokenized_examples, dtype='int32')

# Obtain predictions from the model
predictions = model_tf.predict(tokenized_examples)

# Print the results
print_my_examples(examples, predictions)
