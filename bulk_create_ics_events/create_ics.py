''' 
AIRLab ICS-generator script
Creates ICS-file for opening-hours calendar in outlook

PRIOR TO USING PLEASE N0TE...
- Script will account for Daylight Saving Time periods (until 2029...)
- Also accounts for timezone by moving entered events two hours back
- Period before lunch must end a minute before - eg: 12.00 = 11.59, due to outlook bug.
- Remember to change dates for starting week, and amount of weeks the script should create events for

Halfdan Hauch, Thomas Kaufmanas
'''


from ics import Calendar, Event
import datetime




def is_dst(date_input):
    '''Function checking if input date is within "summertime"-period from 2022-2029. Will subtract 1 hour and return date if not. Also accounts for timezone by moving back the datetime-input two hours'''
    result = date_input - datetime.timedelta(hours=2)
    dst_end_dates   = [datetime.datetime(2022,  3, 27, 2, 00, 00), datetime.datetime(2023,  3, 26, 2, 00, 00), datetime.datetime(2024,  3, 31, 2, 00, 00), datetime.datetime(2025,  3, 30, 2, 00, 00), datetime.datetime(2026,  3, 29, 2, 00, 00), datetime.datetime(2027,   3, 28, 2, 00, 00), datetime.datetime(2028,   3, 26, 2, 00, 00), datetime.datetime(2029,   3, 25, 2, 00, 00)]
    dst_begin_dates = [datetime.datetime(2022, 10, 30, 2, 00, 00), datetime.datetime(2023, 10, 29, 2, 00, 00), datetime.datetime(2024, 10, 27, 2, 00, 00), datetime.datetime(2025, 10, 26, 2, 00, 00), datetime.datetime(2026, 10, 25, 2, 00, 00), datetime.datetime(2027,  10, 31, 2, 00, 00), datetime.datetime(2028,  10, 29, 2, 00, 00), datetime.datetime(2029,  10, 28, 2, 00, 00)]

    for i in range(2):
        if dst_end_dates[i] < date_input < dst_begin_dates[i]: #If not dst (summertime)
            return result
    result += datetime.timedelta(hours=1)
    return result

def add_weekday(title, start_time, end_time, weeks):
    ''' Function to add a calendar event. Takes start-end time, and runs for x amount of weeks.'''

    for i in range(weeks):
        e = Event()
        e.name = title
        e.begin = is_dst(start_time)
        e.end = is_dst(end_time)
        c.events.add(e)

        start_time += datetime.timedelta(days=7)
        end_time += datetime.timedelta(days=7)



c = Calendar() # calendar object to insert the events in
nr_of_weeks = 15 # for how many weeks should the event keep running





# ADD THE EVENTS

# Tuesdays (YYYY, M, D, H, M, S)
before_lunch_start_time = datetime.datetime(2022, 2, 22, 10, 00, 00) 
before_lunch_end_time = datetime.datetime(2022, 2, 22, 11, 59, 59)
add_weekday("Equipment", before_lunch_start_time, before_lunch_end_time, nr_of_weeks)
add_weekday("Project support", before_lunch_start_time, before_lunch_end_time, nr_of_weeks)

after_lunch_start_time = datetime.datetime(2022, 2, 22, 12, 30, 00)                                                                    
after_lunch_end_time = datetime.datetime(2022, 2, 22, 15, 00, 00)
add_weekday("Equipment", after_lunch_start_time, after_lunch_end_time, nr_of_weeks)
add_weekday("Project support", after_lunch_start_time, after_lunch_end_time, nr_of_weeks)


# Thursdays (YYYY, M, D, H, M, S)
before_lunch_start_time = datetime.datetime(2022, 2, 24, 10, 00, 00)
before_lunch_end_time = datetime.datetime(2022, 2, 24, 11, 59, 00)
add_weekday("Equipment", before_lunch_start_time, before_lunch_end_time, nr_of_weeks)
add_weekday("Project support", before_lunch_start_time, before_lunch_end_time, nr_of_weeks)

after_lunch_start_time = datetime.datetime(2022, 2, 24, 12, 30, 00)
after_lunch_end_time = datetime.datetime(2022, 2, 24, 16, 00, 00)
add_weekday("Equipment", after_lunch_start_time, after_lunch_end_time, nr_of_weeks)
add_weekday("Project support", after_lunch_start_time, after_lunch_end_time, nr_of_weeks)


# Fridays (YYYY, M, D, H, M, S)
before_lunch_start_time = datetime.datetime(2022, 2, 25, 10, 00, 00)
before_lunch_end_time = datetime.datetime(2022, 2, 25, 11, 59, 00)
add_weekday("Equipment", before_lunch_start_time, before_lunch_end_time, nr_of_weeks)
add_weekday("Project support", before_lunch_start_time, before_lunch_end_time, nr_of_weeks)

after_lunch_start_time = datetime.datetime(2022, 2, 25, 12, 30, 00)
after_lunch_end_time = datetime.datetime(2022, 2, 25, 14, 00, 00)
add_weekday("Equipment", after_lunch_start_time, after_lunch_end_time, nr_of_weeks)
add_weekday("Project support", after_lunch_start_time, after_lunch_end_time, nr_of_weeks)

    
# write events to a file
c.events
# [<Event 'My cool event' begin:2014-01-01 00:00:00 end:2014-01-01 00:00:01>]
with open('air_lab_opening_hours.ics', 'w') as my_file:
    my_file.writelines(c)
# and it's done !