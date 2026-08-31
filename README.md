# Cina-New-Scene - User Stories

### Cina-New-Scene is a meetup-planning application that generates personal itineraries based on a user's location, budget, interests, and desired vibe.

Users will be able to create and save plans, select multiple interests, and receive a suggested itinerary that fits their preferences.

The main models will be User, Plan, Interest, and PlanInterest.

A user will have many plans, and each plan will belong to a user.

Plans will have many interests through the PlanInterest join model, allowing users to select multiple interests for each meetup they create.

## Features

1. Create a plan  
   As a user, I want to create a meetup plan using my location, budget, interests, and desired vibe so that I can receive an outing that fits my preferences.

2. Generate an itinerary  
   As a user, I want the application to generate a meetup itinerary with multiple activities so that I don't have to plan the outing myself.

3. View a plan  
   As a user, I want to view the details and activities included in my plan so that I know where to go and what to do.

4. Manage saved plans  
   As a user, I want to view, edit, or delete my saved plans so that I can manage my upcoming outings.

5. User Sign in 
    Users will need to sign up, log in, and log out. Users will only be authorized to create, view edit, and delete their own content. 


