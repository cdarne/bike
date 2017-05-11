Bike
====

This project is a simple web app to fetch and find the BIXI stations downtown Montreal.
You can test it online [here](https://bike-status.herokuapp.com/) (https://bike-status.herokuapp.com/)

Ruby version
------------

Developed with ruby 2.4.1

System dependencies
-------------------

node.js and yarn are required to handle the front end dependencies:

    brew install node yarn
    
Then run the yarn install command, it will install bower and update the dependencies in vendor/assets/components
    
    yarn install
    

Configuration
-------------

In addition to the config/database.yml for the DB a config/datasource.yml file is used to configure how the bike stations
 data is fetched.


Database creation
-----------------

This project use PostgreSQL DB. To setup the DB run the rake db commands: 

    rake db:create db:migrate


Test suite
----------

This project is using rspec for testing. To run the tests:

    rspec spec


Services
--------

This application rely on a cron job to update the data from the API. The API documentation states that the data is updated every 5 mins.
So the default configuration for the cron job will be to run every 5 min. There is a dedicated rake task to update the stations data:

    rake data:update_from_remote
