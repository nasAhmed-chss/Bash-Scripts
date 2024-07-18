<h1>Summary</h1>
This repository contains five scripts for various tasks, including moving source files, calculating column sums, computing weighted averages, assigning letter grades, and checking the spelling of four-letter words. Each script takes specific command-line arguments and performs the described operations, ensuring robust error handling and user interaction where necessary.



**Program 1: Moving Source Files**
This script moves C source files while preserving directory structure and ensuring interactive confirmation for directories with more than three files.

Ex:
./prog1.sh <src-dir> <dest-dir>

**Program 2: Column Sum Calculator**
This script computes the sum of each column in a data file with numbers separated by commas, semicolons, or colons.

Ex:
./prog2.sh <data-file> <output-file>

**Program 3: Weighted Average Calculator**
This script calculates the weighted average score for each student based on the weights provided for exam parts.

Ex:
./prog3.sh <data-file> [weight1 weight2 ... weightN]

**Program 4: Grade Assigner**
This script assigns letter grades based on the percentage score of students from a directory of score files.

Ex:
./prog4.sh <scores-directory>

**Program 5: Four-Letter Word Spell Checker**
This script checks and displays incorrectly spelled four-letter words in a file against a dictionary.

Ex:
./prog5.sh <input-file> <dictionary-file>
