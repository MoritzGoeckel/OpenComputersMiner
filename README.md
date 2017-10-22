# OpenComputers Miner

This is a fully modular software for an open computers mining robot

## Features

* Digs a tunnel with an height of two blocks
* Places torches
* Places chests
* Puts all found ores in the chests
* Disposes insignificant items (e.g. cobblestone)
* Builds a bridge when necessary
* Stable behavior in case of mobs, falling blocks like grave etc.
* Zigzag pattern for maximum visibility coverage of blocks

## Todo

* UI
* Startup routine
* Create detailed documentation of the modules here in the readme

## Known bugs

* Interference between the placement of torches and stone when building bridges

## Modules

The code is fully functional and modular. The functions and variables are located in different modules. Non of the modules are executed on itself, they only provide functions to the main module which defines the starting point of the program. These are the currently available modules:

### HEADER

Imports all the necessary components which are used in the subsequent modules. Always import this first 

### INVENTORY

Handles all the inventory management. Is imported as "invHelper"

### MOVEMENT

The movement module is responsible for stable and highly error tolerant movement and digging

### ZIGZAG

This module contains all the functions for the "zigzag" mining pattern

### MAIN

This is where the software starts. The modules are imported and subsequently executed here