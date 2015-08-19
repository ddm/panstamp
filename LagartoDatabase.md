#Datatabase module for Lagarto Max

# Introduction #
One missing feature of Lagarto is the storage of time series of data in a SQL or nonSQL database.
This is an SQLAlchemy module that stores the SWAP traffic in tables for later analysis of temporal data.



# Details #

The module comes with a standard sqlite connection and saves the data to a local file in python/lagarto/database/events.db.
The class is located in lagarto-max/storage.py and is instantiated in the evnmanager.py when the thread for logging events is called.
Don't worry about concurrency or multiple instances as the class DatabaseManager is using the singleton pattern so you can create as many objects you like.

The table network stores the following informations:

  * event\_id: primary key that is a sequence of integers
  * name: the name of the endpoint
  * location: the location
  * type: the type of endpoint (num,bin etc)
  * direction: the direction (inp,out etc)
  * value: the value like temperature etc
  * time: the time when it was logged

I was thinking that probably the best way is to move the timestamp as the primary key rather then the event\_id.

# Usage #
In events.py is used in this way:

database.addEntry(evnobj.location,evnobj.name,evnobj.value,evnobj.type)

and the database object is created simply as:
database=DatabaseManager()

the constructor take care of creating a new database if not present or loading the tables if already present.

That's all for now.