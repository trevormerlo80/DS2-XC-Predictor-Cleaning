# DS2-XC-Predictor-Cleaning
Cross Country race predictor

This project sought to predict the results of the 2026 Dickinson Long Short meet based off of past results of the 
Galen Piper meet and the Dickinson Long Short meet. Many teams run both races annually, providing overlapping results.
A simple linear regression model was used to predict runners 2026 Dickinson Long Short performances based off of their
past results in the two races.

Data Cleaning Log:
  -Meet results were taken from Milesplit.com
    -Despite not containing every year for either meet, the most consistent results were found here
    -Since Milesplit has no native way to download results, the page had to be inspected to extract the results
  
  -Extracted data from Milesplit was pasted into separate txt files
    -Inside each txt file, column headers had to be added, as well as column spacing to set up the 'read_delim' function
    
  -After putting the extracted data into a table through the 'read_delim' function, it is isn't quite formatted correctly
    -In the general case this works, but many entries on Milesplit are formatted differently. Some entries (namely 
    unattached runners) don't have a class year, and some schools and or names have inconsistent spacing
    -To address this, the time column was overwritten by any string in the format of a time that was found in the
    Team or Time column, as the only data needed was the runner and their time.
    
  -For every year, cleaned data from both meets were joined by matching runner names, and then the each separate year
  data frame was concatenated into one
  
  -The only thing left to prepare the data for graphing and modeling was to convert the time formatted string into
  a numerical object, which was acheived using lubridates 'period_to_seconds' function
    
    
    