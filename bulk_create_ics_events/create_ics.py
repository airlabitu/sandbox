import datetime
from ics import Calendar, Event

# function to add one event to the calendar
def add_weekday(title, start_time, end_time,  weeks):
    for i in range(weeks):

        e = Event()
        e.name = title
        e.begin = start_time
        e.end = end_time
        c.events.add(e)

        start_time += datetime.timedelta(days=7)
        end_time += datetime.timedelta(days=7)


c = Calendar() # calendar variable to insert the events in

nr_of_weeks = 15 # for how many weeks should the event keep running




# ADD THE EVENTS


# Tuesdays

# (YYYY, M, D, H, M, S) needs to be set one hour earlier for import to outlook calenday
before_lunch_start_time = datetime.datetime(2022, 2, 22, 9, 00, 00)
before_lunch_end_time = datetime.datetime(2022, 2, 22, 11, 00, 00)
add_weekday("Equipment", before_lunch_start_time, before_lunch_end_time, nr_of_weeks)
add_weekday("Project support", before_lunch_start_time, before_lunch_end_time, nr_of_weeks)

after_lunch_start_time = datetime.datetime(2022, 2, 22, 11, 30, 00)                                                                    
after_lunch_end_time = datetime.datetime(2022, 2, 22, 14, 00, 00)
add_weekday("Equipment", after_lunch_start_time, after_lunch_end_time, nr_of_weeks)
add_weekday("Project support", after_lunch_start_time, after_lunch_end_time, nr_of_weeks)



# Thursdays

# (YYYY, M, D, H, M, S) needs to be set one hour earlier for import to outlook calenday
before_lunch_start_time = datetime.datetime(2022, 2, 24, 9, 00, 00)
before_lunch_end_time = datetime.datetime(2022, 2, 24, 11, 00, 00)
add_weekday("Equipment", before_lunch_start_time, before_lunch_end_time, nr_of_weeks)
add_weekday("Project support", before_lunch_start_time, before_lunch_end_time, nr_of_weeks)

after_lunch_start_time = datetime.datetime(2022, 2, 24, 11, 30, 00)
after_lunch_end_time = datetime.datetime(2022, 2, 24, 15, 00, 00)
add_weekday("Equipment", after_lunch_start_time, after_lunch_end_time, nr_of_weeks)
add_weekday("Project support", after_lunch_start_time, after_lunch_end_time, nr_of_weeks)


# Fridays

# (YYYY, M, D, H, M, S) needs to be set one hour earlier for import to outlook calenday
before_lunch_start_time = datetime.datetime(2022, 2, 25, 9, 00, 00)
before_lunch_end_time = datetime.datetime(2022, 2, 25, 11, 00, 00)
add_weekday("Equipment", before_lunch_start_time, before_lunch_end_time, nr_of_weeks)
add_weekday("Project support", before_lunch_start_time, before_lunch_end_time, nr_of_weeks)

after_lunch_start_time = datetime.datetime(2022, 2, 25, 11, 30, 00)
after_lunch_end_time = datetime.datetime(2022, 2, 25, 13, 00, 00)
add_weekday("Equipment", after_lunch_start_time, after_lunch_end_time, nr_of_weeks)
add_weekday("Project support", after_lunch_start_time, after_lunch_end_time, nr_of_weeks)

    
# write events to a file
c.events
# [<Event 'My cool event' begin:2014-01-01 00:00:00 end:2014-01-01 00:00:01>]
with open('air_lab_opening_hours.ics', 'w') as my_file:
    my_file.writelines(c)
# and it's done !
