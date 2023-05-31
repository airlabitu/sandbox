// Random.pde
// -*- mode: C++ -*-
//
// Make a single stepper perform random changes in speed, position and acceleration
//
// Copyright (C) 2009 Mike McCauley
// $Id: Random.pde,v 1.1 2011/01/05 01:51:01 mikem Exp mikem $

#include <AccelStepper.h>

int dir_pin = 3;
int pulse_pin = 2;

long timer;
int interval = 3000;

// Define a stepper and the pins it will use
//AccelStepper stepper; // Defaults to AccelStepper::FULL4WIRE (4 pins) on 2, 3, 4, 5
AccelStepper stepper(AccelStepper::DRIVER, pulse_pin, dir_pin);

void setup()
{  
  stepper.setMaxSpeed(1000);
   stepper.setSpeed(300);
}

void loop()
{
  if (millis() > timer + interval){

    timer = millis();
    if (stepper.distanceToGo() == 0)
    {
	// Random change to speed, position and acceleration
	// Make sure we dont get 0 speed or accelerations
	stepper.moveTo(random(100, 1000));
	stepper.setMaxSpeed(1000);
	stepper.setAcceleration(100);
    }
    
}



  
stepper.run();
//  stepper.runSpeed();
  /*
    if (stepper.distanceToGo() == 0)
    {
	// Random change to speed, position and acceleration
	// Make sure we dont get 0 speed or accelerations

    

	  delay(1000);
	  stepper.moveTo(100);
	  stepper.setMaxSpeed(300);
	  stepper.setAcceleration(50);
    }
    stepper.run();
*/    
}
