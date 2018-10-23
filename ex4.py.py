#!/usr/bin/env python
# coding: utf-8

# In[ ]:


# assign value 100 to variable "cars"
cars = 100

# assign value 4.0 to variable "space_in_a_car"
space_in_a_car = 4.0

# assign value 30 to variable "drivers"
drivers = 30

# assign value 90 to variable "passengers"
passengers = 90

# assign value cars - drivers = 100-30=70 to variable "cars_not_driven"
cars_not_driven = cars - drivers

# assign value drivers=30 to variable "cars_driven"
cars_driven = drivers

# assign value cars_driven * space_in_a_car = 30*4.0 =120 to variable "carpool_capacity"
carpool_capacity = cars_driven * space_in_a_car

# assign value passengers / cars_driven = 90/30 = 3 to variable "average_passengers_per_car"
average_passengers_per_car = passengers / cars_driven

# print "There are 100 cars available."
print("There are", cars, "cars available.")

# print "There are only 30 drivers available."
print("There are only", drivers, "drivers available.")

# print "There will be 70 empty cars today."
print("There will be", cars_not_driven, "empty cars today.")

# print "We can transport 120.0 people today."
print("We can transport", carpool_capacity, "people today.")

# print "We have 90 to carpool today."
print("We have", passengers, "to carpool today.")

# print "We need to put about 3.0 in each car."
print("We need to put about", average_passengers_per_car,"in each car.")



# Study Drills

# Traceback (most recent call last):
# File "ex4.py", line 8, in <module>
#   average_passengers_per_car = car_pool_capacity / passenger
# NameError: name 'car_pool_capacity' is not defined

# The error occurs because you did not assign any value to variable "car_pool_capacity" 
# so cannot assign value using variable "car_pool_capacity" to variable "average_passengers_per_car"


# We get the same result if we just use 4 instead of 4.0. 
# So it is unnecessary to use 4.0 to assign value to variable "space_in_a_car"

