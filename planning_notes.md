Notes from pairing (slightly sporadic):


Challenge 11
-------------------------
In order to pay for my journey
As a customer
I need to know where I've travelled from

User tops up
User touches in
User sees station that they touched in from


Challenge12
-------------------------

In order to know where I have been
As a customer
I want to see all my previous trips

User tops up
User taps in
User taps out
User can see complete journey
Rinse and repeat


Use an array to capture Entry_station and exit_station

--------------------------------
journey_array = []

User tops up
User taps in
current_journey = [station1]
User taps out
current_journey = [station1, station2]
safe_journey



Save journey method
--------------------------------
if the length of journey_array == 2

 Store Journey in hash
 hash {Journey(n) => [station1, station2]}
       :journey1
       :journey2
 Reset the journey_array
 journey_array = []
 increment journey (n) += 1


--------------------------------
In order to know how far I have travelled
As a customer
I want to know what zone a station is in
-------------------------------
class: station
         Zone, name
         what_zone


let(name) {double :name}
let(zone) {double :zone}

Challenge 14
------------------------------

Extracting classes

Starting a journey

User touch in
  -> get station from Station class
  -> pass to Journey class
      -> add to Current Journey

User touch out
  -> get station from Station class
  -> start a new journey
      -> add to current journey
      -> save to journey history

Save journey(station)
  -> add station to current journey
    -> if journey is complete
      -> add to journey history on 

On a journey?
  -> ask Journey if I'm in_journey
   -> Journey checks if I have touched in
      but not touched out
      <- lets card know if its on a journey
