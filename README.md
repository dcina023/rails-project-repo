# Cina New-Scene

Cina New-Scene is a meetup-planning application that generates personal itineraries for users.

Users can create and save plans, select a vibe for the type of experience they want, and receive a suggested itinerary made from activities that match their selected vibe.

## Models and Associations

The main models are `User`, `Plan`, `Activity`, and `PlanActivity`.

A `User` has many `Plans`, and each `Plan` belongs to a `User`.

A `Plan` has many `Activities` through the `PlanActivity` join model.

An `Activity` has many `Plans` through the `PlanActivity` join model.

`PlanActivity` stores the relationship between a plan and an activity, along with plan-specific details such as notes and rating.

## Vibe-Based Itinerary Generation

Plans include a selected `vibe`, chosen from a frozen list of supported vibe options.

Activities also include a `vibe` category.

When a user creates a plan, the application finds activities that match the plan’s selected vibe and randomly assigns activities to the plan through `PlanActivity`.

## Reviewer Setup Instructions

1. Fork and clone this repository.

2. Navigate into the cloned project folder in your terminal:

```bash
cd your-project-folder

## Install dependencies:

bundle install

## Set up the database:

bin/rails db:migrate
bin/rails db:seed

## Start the Rails server

bin/rails s

## Open the app in your browser:
http://localhost:3000/

