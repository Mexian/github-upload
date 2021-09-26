library(nycflights13)
library(ggplot2)
library(dplyr)

head(flights)
str(flights)

#filter Alaska Airlines 
alaska_flights <- flights %>% 
  filter(carrier == "AS")

#View alaska flights
View(alaska_flights)

#create a scatterplot
ggplot(data = alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) + 
  geom_point()

#changing transparency to fix overplotting
ggplot(data = alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) +
  geom_point(alpha = 0.2)

#jittering the points to fix overplotting
ggplot(data = alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) +
  geom_jitter(width = 30, height = 30)

#Make a linegraph using weather dataframe
#explore it
View(weather)
glimpse(weather)
?weather

#choose hourly temperatures at Newark airport for the first 15 days in January
early_january_weather <- weather %>% 
  filter(origin == "EWR" & month == 1 & day <= 15)

#explore it 
View(early_january_weather)

#create a linegraph
ggplot(data = early_january_weather, mapping = aes(x = time_hour ,y = temp)) +
  geom_line()


#create a histogram

#using binwidth = 10
ggplot(data = weather, mapping = aes(x= temp)) +
  geom_histogram(binwidth = 10, color = "white", fill = "purple")

#using bins = 40
ggplot(data = weather, mapping = aes(x= temp)) +
  geom_histogram(bins = 40, color = "white", fill = "purple")


#Faceting tempetures by month
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white") +
  facet_wrap(~ month)

#let's say we want it to have 4 rows instead of 3 (nrow & ncol)
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white") +
  facet_wrap(~ month, nrow = 4)

#create a boxplot
ggplot(data = weather, mapping = aes(x = month, y = temp)) +
  geom_boxplot() #this boxplot is useless cos month is not a cetgorical variable

#make month a categorical variable using factor function
ggplot(data = weather, mapping = aes(x = factor(month), y = temp)) +
  geom_boxplot()
  
#create a barplot

#Is the categorical variable precounted or not?
fruits <- tibble(
  fruit = c("apple", "apple", "orange", "apple", "orange")
)
fruits_counted <- tibble(
  fruit = c("apple", "orange"),
  number = c(3, 2)
)

str(fruits)  
str(fruits_counted)

ggplot(data = fruits, mapping = aes(x = fruit)) +
  geom_bar() #use this when variables not precounted

ggplot(data = fruits_counted, mapping = aes(x = fruit, y = number)) +
  geom_col() #use this when variables precounted

#visualize flights in nycflights13

View(flights)

#create a barplot of the carrier distributions
ggplot(data = flights, mapping = aes(x = carrier)) +
  geom_bar()

#compare two categorical variables, adding origin
ggplot(data = flights, mapping = aes(x = carrier, fill = origin)) +
  geom_bar()

#when using only color = origin (not using 'fill')
ggplot(data = flights, mapping = aes(x = carrier, color = origin)) +
  geom_bar()

#create side-by-side barplots
ggplot(data = flights, mapping = aes(x = carrier, fill = origin)) +
  geom_bar(position = "dodge")

#fix width bar issues with position_dodge()
ggplot(data = flights, mapping = aes(x = carrier, fill = origin)) +
  geom_bar(position = position_dodge(preserve = "single"))

#create a faceted barplot with hourly temperatures at the 3 NYC airports split by month
ggplot(data = flights, mapping = aes(x = carrier)) +
  geom_bar() +
  facet_wrap(~ origin, ncol = 1)
  geom_bar() +
