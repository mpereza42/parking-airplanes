# Redis / Lua - Parking Airplanes

## Task description
Since we wrote our first task, Picky Airlines has gotten really popular. We expanded our fleet
and now we have 80 autonomous planes! They are pretty awesome, but we haven't
programmed them to find their parking spot yet and the airports are really mad at us since they
just stay on the runway after landing, and the passengers have to walk to the terminal as well.
We own one hundred parking spots, and we are planning to use Redis to assign each plane
(with IDs 1 to 80) to its own parking spot (IDs 1 to 99) which will stay assigned to it forever.

Your task is to write a Redis script in Lua that takes an airplane ID as an argument and assigns
a random available parking spot to the plane if it doesn't have one yet. It should always return
the parking spot ID (even if it was assigned earlier). And don't worry about multiple airports, 
we will have a separate Redis instance running with this script at each airport.

## Usage

First step is to initialize keys

    > redis-cli --eval init_parking.lua , init
    (integer) 0

Example how to get parking spot for `plane1`

    > redis-cli --eval parking_airplanes.lua , plane1
    "1"

If no more available spots, method will return nil

    > redis-cli --eval parking_airplanes.lua , plane101
    (nil)

To uninitialize everything call `init_parking` with `del` argument

    > redis-cli --eval init_parking.lua , del
    (integer) 0

