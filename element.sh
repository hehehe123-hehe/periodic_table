#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Check if an argument is provided
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

# Check if the argument is a number (atomic_number)
if [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT_INFO=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements AS e JOIN properties AS p ON e.atomic_number = p.atomic_number JOIN types AS t ON p.type_id = t.type_id WHERE e.atomic_number = $1")

# Check if the argument is a letter/string (symbol or name)
else
  ELEMENT_INFO=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements AS e JOIN properties AS p ON e.atomic_number = p.atomic_number JOIN types AS t ON p.type_id = t.type_id WHERE e.symbol = '$1' OR e.name = '$1'")
fi


