# Program input

The input consists of a string containing a sequence of commands, where
a command is represented by a single capital letter at the beginning of the line.
Parameters of the command are separated by white spaces and they follow the command character.

Pixel co-ordinates are a pair of integers: a column number between 1 and 250, and a row number between 1 and 250. Bitmaps starts at coordinates 1,1. Colours are specified by capital letters.

# Commands

There are 8 supported commands:

* I M N - Create a new M x N image with all pixels coloured white (O).
* C - Clears the table, setting all pixels to white (O).
* L X Y C - Colours the pixel (X,Y) with colour C.
* V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
* H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
* F X Y C - Fill an area with colour only areas which are the same as the original colour.
* S - Show the contents of the current image
* ? - Displays help text
* X - Terminate the session

# Example

In the example below, > represents input

note that the drawing is zero indexed.

```
> I 5 6
> L 1 1 A
> S
OOOOO
OAOOO
OOOOO
OOOOO
OOOOO
OOOOO
> V 1 2 5 W
> H 2 4 1 Z
> S
OOOOO
OAZZZ
OWOOO
OWOOO
OWOOO
OWOOO
> F 0 0 G
> S
GGGGG
GAZZZ
GWOOO
GWOOO
GWOOO
GWOOO
```
