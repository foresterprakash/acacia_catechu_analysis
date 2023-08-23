library(dplyr)
library(readxl)
library(xlsx)

# Load Data

acacia <- read.csv("E:/Acacia_data/Rupesh.csv")
names(acacia)
summary(acacia)

# For log diameter - convert girth to diamater (division by pi)

acacia$log_d1_cm <- acacia$girth1_cm/pi
acacia$log_d2_cm <- acacia$girth3_cm/pi

### For log basal area for both end

acacia$ba1_sqcm <- (pi * acacia$log_d1_cm^2)/4
acacia$ba2_sqcm <- (pi * acacia$log_d2_cm^2)/4

### For log volume
acacia$log_volume_cum <- (acacia$ba1_sqcm + acacia$ba2_sqcm)/2 * acacia$length_cm


## Now For Heartwood Volume
# For that we have to calculate basal area of heartwood of both ends

acacia$hw_ba1_sqcm <- (pi * acacia$hw_dia1_cm^2)/4
acacia$hw_ba2_sqcm <- (pi * acacia$hw_dia2_cm^2)/4

## Now heartwood Volume

acacia$hw_volume_cm3 <- (acacia$hw_ba1_sqcm + acacia$hw_ba2_sqcm)/2 * acacia$length_cm

## Now we have both log volume (under bark) and heartwood volume
## Lets calculate sapwood volume which is the subtraction of heartwood volume
## from total log volume.

acacia$sw_volume_cm3 <- acacia$log_volume_cum - acacia$hw_volume_cm3

## lets calculate the ratio of sapwood in log volume.

acacia$sw_ratio_log <- acacia$sw_volume_cm3 / acacia$log_volume_cum

## and calculate the ratio of heartwood in log volume.

acacia$hw_ratio_log <- acacia$hw_volume_cm3 / acacia$log_volume_cum

## now lets calculate ratio of sapwood and heartwood.

acacia$sw_hw_ratio <- acacia$sw_volume_cm3 / acacia$hw_volume_cm3

# Up to here descriptive data analysis and data transformation is complete.
# lets write this file as csv in a desired folder and re-analyse.

write.csv(acacia, "E:/Acacia_data/result_summary.csv")

# Now read the same  file to proceed further

dat <- read.csv("E:/Acacia_data/result_summary.csv")
summary(dat)
boxplot(dat$sw_hw_ratio)
