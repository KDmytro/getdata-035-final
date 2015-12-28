The analysis script is broken down into 5 sections. Explanations for each section are provided below:

# ***************************************
# SECTION 1 - LOADING DATA
# ***************************************

In the first section the script reads and loads relevant sets of data for both test and training groups. Relevant sets of data are then combined, using rbind(), into 3 full lists of data - subjects, subject activitites, and the corresponding measurements. 

Resulting sets are then merged, using cbind(), into a complete single set of measurement data - full set.

# ***************************************
# SECTION 2 - LABELING THE DATA
# ***************************************

In the second section the script loads the list of features from "features.txt" file. All labels are then converted to proper names using make.names() function. The resulting list is then applied as variable names of the full set. First two columns are manally labled as "Subject" and "Activity".

Next, "Activity" variable of the full set is then converted into a factor variable type and is updated with labels from the "activities_lables.txt" file.

# ***************************************
# SECTION 3 - SELECTING MEASUREMENTS
# ***************************************

In this section the script creates a logical vector of the required features (containing "mean" and "std") using regular expression. The resulting subset of the full data is then stored as a new set - summary_set.

# ***************************************
# SECTION 4 - CREATING A SUMMARY TABLE
# ***************************************

In this section the script loads "dplyr" labrary and then perfoms two step manipulation to group and then summarize the data. Resulting set is stored as - summary_final.

# ***************************************
# SECTION 5 - WRITING SUMMARY FILE
# ***************************************

In this section the script writes summary_final set into "summary_final.txt" file in the working directory.
