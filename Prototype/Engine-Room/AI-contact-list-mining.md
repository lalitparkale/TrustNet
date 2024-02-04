This outlines all the aspects for a working AI module for:
  - **Intention**: Given a contact list, identify contacts of service providers based on few fields, like name, note, label, number.
  - **Input**: Contacts list in .csv format
  - **Output**: class label that identifies the service provider category, like plumber, car-service

Azure source [Pipeline-contacts-mining](https://ml.azure.com/visualinterface/authoring/Normal/769593dc-0178-4ca9-9d9d-f42b5d2065e1?wsid=/subscriptions/4cd92326-3609-40ab-b2a6-ba9862b17b7a/resourceGroups/lalitparkale-rg/providers/Microsoft.MachineLearningServices/workspaces/lapar-training-wksp&tid=00f77b24-6ed6-4627-bff1-f4b90f0d54af)

1. Data set - export contacts list in CSV format from Google account
2. Labelling - create new column in CSV file and assigned text category for service provider contact
3. Azure AI Designer - create pipepline using 'Classic prebuilt' option
   - ML model - Multiclass Logistic Regression

<img width="694" alt="image" src="https://github.com/lalitparkale/TrustNet/assets/20618830/f03791a0-d930-4c78-90d2-3a4094a888ab">
