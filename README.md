# Cina New-Scene: User Stories

- Cina New-Scene is a meetup-planning application that generates personal itineraries based on a user's location, budget, interests, and desired vibe.

- Users will be able to create and save plans, select multiple interests, and receive a suggested itinerary that fits their preferences.

### Models and Associations: 

- The main models will be User, Plan, Interest, and PlanInterest.

- A user will have many plans, and each plan will belong to a user.

- Plans will have many interests through the PlanInterest join model, allowing users to select multiple interests for each meetup they create.



