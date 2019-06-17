# GrabSafety
This is a repository of Grab Safety competition based on telematic data. 

# How to read this code? 
Just simply open html file

# How to run this code? 
Just simply use R Studio, and please extract the dataset under dataset folder you should create first with the following folder hierarchy. 

- dataset/safety/features
- dataset/safety/labels

I did not put the dataset because of the size of the dataset (>800MB upon compressing). 

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
