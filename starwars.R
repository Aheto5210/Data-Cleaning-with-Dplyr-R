install.packages("tidyverse")
install.packages("mice")
install.packages("lme4")

library(mice)
library(dplyr)
library(tidyverse)

#loading the starwars inbuilt dataset in R
data("starwars")

#assigning the dataset to a new variable
dstar <- data.frame(starwars)

#to display the actual dataset
view(dstar)



# To display first few roles in the dataset
head(dstar)

#check for number of rows and columns of the dataset
dim(starwars)

#data cleaning with Dplyr
colnames(starwars)


#Handling Missing data with "Mice"
md.pattern(dstar)

#Using the filter() command to change the rows based on the columns values

dstar %>% filter(eye_color == "brown") 
starwars %>% filter(skin_color == "light", eye_color == "brown")

# Arrange rows with arrange()
datasetnew <- dstar %>% arrange(height , mass)



# To display the new changes in the dataset
datasetnew

# Choose rows using their position with slice()
datasetnew <- dstar %>% slice(5:10)

# Note, we these too - slice_head, slice_tail, slice_sample, slice_min, slice_max, etc

datasetnew <- dstar %>% slice_sample(n=20)

# Select columns with select()
datasetnew <- dstar %>% select(height, mass, birth_year)

# To select between columns
datasetnew <- dstar %>% select(name:gender)

# Using rename to rename variable 
datasetnew <- dstar %>%rename(DOB = birth_year, Gender = gender)

# Using Mutate in DPlYR to add new colums and also select existing columns
datasetnew <- dstar %>% mutate(height_m = height / 100) 
# The above line of code generated a new column called height_m with values based on the function specified on the existing coloumn "height"
# This will divide the existing column "height" and divide it values by 100.

datasetnew <- dstar %>% mutate (height_m = height / 100, BMI = mass / (height_m^2), .keep = "none") %>% 
  select(BMI, everything())

datasetnew <- dstar %>%  mutate(   height_m = height / 100, BMI = mass / (height_m^2))%>% 
  select(BMI, everything())

#Change column order with relocate()
datasetnew <- dstar %>% relocate(sex:homeworld, .before = height)

# change the location of height, mass and birthyear
datasetnew <- dstar %>% relocate(height,mass,birth_year,sex, .after  = name )

# check to see if there are NA's in the dataset
is.na(datasetnew)

# Using filter() to remove NA's in the dataset
datasetnew <- datasetnew %>% filter(across(everything(), ~!is.na(.)))

# Removing unwanted columns from the dataset
datasetnew <- datasetnew %>% 
  select(name:species)%>% 
  filter(across(everything(), ~!is.na(.)))

# make a summary of the entire dataset
dim(datasetnew)
datasetnew %>% summarise(height = mean(height))
# mean of the height is 178.6552

# Confirm that there are no missing values
md.pattern(datasetnew)








