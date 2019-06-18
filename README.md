# GrabSafety
This is a repository of Grab Safety competition based on telematic data. 

# How to read this code? 
Just simply fork or download this repository, then open .Rmd or html file (precisely this file: Grab_Safety.Rmd or Grab_Safety.nb.html). 

# How to run this code? 
1. Open Grab_Safety.Rproj with R Studio + R (v 3.5.1).
2. Extract the dataset under dataset folder you should create first with the following folder hierarchy. 
- dataset/safety/features/...
- dataset/safety/labels/...
- dataset/safety/data_dictionary.xls
3. Open .Rmd file

I did not put the dataset because of the size of the dataset (>800MB upon compressing). 

# How to evaluate the model?
1. Step 1. Prepare the dataset for testing.  According to the guidance, format of the test data has the same field and distribution as the training data provided. To make it easy, please just rename the test data into test_data.csv, then put them in the directory evaluation. 
2. Step 2. Run Eval.R inside evaluation directory with RStudio + R (recommend with 3.5.1) 
3. Step 3. There will be a file of prediction result: prediction_result_prob.csv in the directory evaluateion with the following columns: 
- bookingID
- prob_0 (probability Safe)
- prob_1 (probability Not Safe)
Grab team then can evaluate with the AUC parameter. 

# Programming Language: 
R, running on R version 3.5.1 

# Problem Description

Given the telematics data for each trip and the label if the trip is tagged as dangerous driving, derive a model that can detect dangerous driving trips.

# Dataset 

The given dataset contains telematics data during trips (bookingID). Each trip will be assigned with label 1 or 0 in a separate label file to indicate dangerous driving.
Field

**Data Dictionary**

- bookingID: trip id
- Accuracy: accuracy inferred by GPS in meters
- Bearing: GPS bearing in degree
- acceleration_x: accelerometer reading at x axis (m/s2)
- acceleration_y: accelerometer reading at y axis (m/s2)
- acceleration_z: accelerometer reading at z axis (m/s2)
- gyro_x: gyroscope reading in x axis (rad/s)
- gyro_y: gyroscope reading in y axis (rad/s)
- gyro_z: gyroscope reading in z axis (rad/s)
- second: time of the record by number of seconds
- Speed: speed measured by GPS in m/s
