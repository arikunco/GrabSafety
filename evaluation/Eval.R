### Title       : Eval.R
### Description : This is a script to perform evaluation of testing
### Author      : Bernardus Ari Kuncoro

### Step 1. Prepare the dataset for testing, and load it. 
### According to the guidance, format of the test data has the same field and distribution as the training data provided. To make it easy, please just rename the test data into test_data.csv

feature_all <- read.csv("evaluation/test_data.csv")

### Step 2. Feature engineering 
# Average speed, Median, Max Speed, Duration of Booking
candidate_feature_1 <- feature_all %>% group_by(bookingID) %>%
  summarise(avg_speed=mean(Speed), median_speed=median(Speed), max_speed=max(Speed), duration=max(second), sd_speed=sd(Speed))

# Delta Bearing: Average delta bearing, Max delta bearing, Median delta bearing 
candidate_feature_2 <- feature_all %>% select(bookingID,Bearing) %>%
  mutate(lag_bearing=lag(Bearing),delta_bearing=abs(Bearing-lag_bearing)) %>%
  filter(!is.na(delta_bearing)) %>% group_by(bookingID) %>%
  summarise(avg_delta_bearing=mean(delta_bearing),
            max_delta_bearing=max(delta_bearing),
            median_delta_bearing= median(delta_bearing),
            sd_delta_bearing=sd(delta_bearing))

# Acceleration: Average acceleration, median acceleration, max acceleration 
candidate_feature_3 <- feature_all %>% 
  select(bookingID, acceleration_x,acceleration_y, acceleration_z) %>% 
  group_by(bookingID) %>% summarise(avg_acceleration_x=mean(acceleration_x),
                                    avg_acceleration_y=mean(acceleration_y),
                                    avg_acceleration_z=mean(acceleration_z),
                                    median_acceleration_x=median(acceleration_x),
                                    median_acceleration_y=median(acceleration_y),
                                    median_acceleration_z=median(acceleration_z),
                                    max_acceleration_x=max(acceleration_x),
                                    max_acceleration_y=max(acceleration_y),
                                    max_acceleration_z=max(acceleration_z),
                                    sd_acceleration_x=sd(acceleration_x),
                                    sd_acceleration_y=sd(acceleration_y),
                                    sd_acceleration_z=sd(acceleration_z))

# Gyro: average gyroscope, median gyro, max gyro
candidate_feature_4 <- feature_all %>% 
  select(bookingID, gyro_x, gyro_y, gyro_z) %>% group_by(bookingID) %>% 
  summarise(avg_gyro_x=mean(gyro_x),
            avg_gyro_y=mean(gyro_y),
            avg_gyro_z=mean(gyro_z),
            median_gyro_x=median(gyro_x),
            median_gyro_y=median(gyro_y),
            median_gyro_z=median(gyro_z),
            max_gyro_x=max(gyro_x),
            max_gyro_y=max(gyro_y),
            max_gyro_z=max(gyro_z),
            sd_gyro_x=sd(gyro_x),
            sd_gyro_y=sd(gyro_y),
            sd_gyro_z=sd(gyro_z))

# Delta Acceleration: Average Delta acceleration, median delta acceleration, max delta acceleration, and standard deviation 
candidate_feature_5 <- feature_all %>% 
  select(bookingID, acceleration_x,acceleration_y, acceleration_z) %>% 
  mutate(lag_acceleration_x=lag(acceleration_x),
         lag_acceleration_y=lag(acceleration_y),
         lag_acceleration_z=lag(acceleration_z)) %>%
  mutate(delta_accel_x = abs(lag_acceleration_x-acceleration_x),
         delta_accel_y = abs(lag_acceleration_y-acceleration_y), 
         delta_accel_z = abs(lag_acceleration_z-acceleration_z)) %>% 
  filter(!is.na(delta_accel_x)) %>% group_by(bookingID) %>% 
  summarise(avg_delta_accel_x=mean(delta_accel_x),
            avg_delta_accel_y=mean(delta_accel_y),
            avg_delta_accel_z=mean(delta_accel_z),
            max_delta_accel_x=max(delta_accel_x),
            max_delta_accel_y=max(delta_accel_y),
            max_delta_accel_z=max(delta_accel_y),
            median_delta_accel_x=median(delta_accel_x),
            median_delta_accel_y=median(delta_accel_y),
            median_delta_accel_z=median(delta_accel_z),
            sd_delta_accel_x=sd(delta_accel_x),
            sd_delta_accel_y=sd(delta_accel_y),
            sd_delta_accel_z=sd(delta_accel_z))

# Delta Gyro: Average Delta gyro, median delta gyro, max delta gyro, and standard deviation gyro
candidate_feature_6 <- feature_all %>% 
  select(bookingID, gyro_x,gyro_y, gyro_z) %>% 
  mutate(lag_gyro_x=lag(gyro_x),
         lag_gyro_y=lag(gyro_y),
         lag_gyro_z=lag(gyro_z)) %>%
  mutate(delta_gyro_x = abs(lag_gyro_x-gyro_x),
         delta_gyro_y = abs(lag_gyro_y-gyro_y), 
         delta_gyro_z = abs(lag_gyro_z-gyro_z)) %>% 
  filter(!is.na(delta_gyro_x)) %>% group_by(bookingID) %>% 
  summarise(avg_delta_gyro_x=mean(delta_gyro_x),
            avg_delta_gyro_y=mean(delta_gyro_y),
            avg_delta_gyro_z=mean(delta_gyro_z),
            max_delta_gyro_x=max(delta_gyro_x),
            max_delta_gyro_y=max(delta_gyro_y),
            max_delta_gyro_z=max(delta_gyro_y),
            median_delta_gyro_x=median(delta_gyro_x),
            median_delta_gyro_y=median(delta_gyro_y),
            median_delta_gyro_z=median(delta_gyro_z),
            sd_delta_gyro_x=sd(delta_gyro_x),
            sd_delta_gyro_y=sd(delta_gyro_y),
            sd_delta_gyro_z=sd(delta_gyro_z))

# Combine all the feature candidates into one dataframe 
feature_all_fin <- candidate_feature_1 %>% 
  left_join(candidate_feature_2, by='bookingID') %>% 
  left_join(candidate_feature_3, by='bookingID') %>% 
  left_join(candidate_feature_4, by='bookingID') %>% 
  left_join(candidate_feature_5, by='bookingID') %>% 
  left_join(candidate_feature_6, by='bookingID') %>% 
  left_join(label_final_new, by='bookingID')

# Step 4: Load the trained model.
load("evaluation/model_gbm.rda")

# Step 5: Predict probability values using the model: all_probs
prediction <- predict(model_gbm,feature_all_fin,type = "prob") 
prediction <- data.frame(bookingID=feature_all_fin$bookingID,
                         prob_0=prediction$Safe,
                         prob_1=prediction$NotSafe) 

# Step 6: Write the final prediction 
write.csv(prediction,"evaluation/prediction_result_prob.csv",row.names = F)

