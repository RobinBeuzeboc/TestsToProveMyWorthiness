
# Thoughts and Conclusion
Not quite the same result, but the prices are overall more interesting for the people. Instead of using the beds as a list, i kinda focused myself on separating the pairs and the odds number and give a guest room whenever i had the chance.
Not gonna lie, I thought the program had to compute this way at the beginning, so that's an incomprehension on my side. I didn't want to go for more than an hour and a half thought, so i left it here, still, i'm pretty sure my way to see things is more complex than what was ask. 
I've challenged myself to not code for more than 1h20 (also because i didn't have more time than that...)
Still, i hope my skills are relevant and that i'm not to rusty.




# Bed price computing utility

The goal of this exercise is to compute a bed price based on different parameters, for a given set of passengers.

## Entities:
1. Bed: the bed entity
- name
- bedType (`double`, `guest` or `baby`)
- price: price applied for `adults`
- childPrice: price applied for `children` and `babies`
2. PAX: the passengers list
- nb of adults
- nb of children
- nb of babies
3. BedPolicy: Given a bedType, which type of people is allowed in there, and how many of them can fit 


## Business rules:
There a 3 bed policies:
- `double` beds allow adults and children. 2 people can fit in there.
- `guest` beds allow adults and children. 1 people can fit in there.
- `baby` beds allow babies. 1 people can fit in there. 

2 `adults` can share a `double` bed
2 `children` can share a `double` bed
1 `adult` and 1 `child` cannot be in the same bed


## Example:
With the following beds:
- 1 free `double` bed
- 1 `double` bed at price 100$ and child price 30$
- 2 `guest` beds at price 50$ and child price 0$
- 1 `baby` bed at 10$

The following adults/children/babies passengers set should compute a bed price of:
- 2/0/0 => 0$
- 2/1/0 => 30$
- 2/0/1 => 10$
- 3/1/0 => 100$
- 4/1/0 => 100$
- 5/0/1 => 160$
- 2/2/1 => 40$
- 3/2/0 => 80$ // this one is a bit tricky ;) It tests pass without this one it's ok!
- 1/5/0 should raise because the configuration is not possible.
- 2/0/2 should raise because the configuration is not possible.


## What is expected of you:
- Write a script that computes bed price for the examples
- A few things that I'm looking for in your program design are: 
                - class definitions
                - clean and easy-to-read code
                - variable immutability (easier in Scala)
                - correct variable typing (Scala only)


Good luck!


##Conclusion
Not quite the same result, but the prices are overall more interesting for the people. Instead of using the beds as a list, i kinda focused myself on separating the pairs and the odds number and give a guest room whenever i had the chance.
Not gonna lie, I thought the program had to compute this way at the beginning, so that's an incomprehension on my side. I didn't want to go for more than an hour and a half thought, so i left it here, still, i'm pretty sure my way to see things is more complex than what was ask.


