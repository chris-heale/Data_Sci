# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import numpy as np
import pandas as pd
import matplotlib as plt
import re

text_file = open("/Users/chris_heale/Desktop/Data_science/Data/German_Credit/german.doc", "r")
German_schema = text_file.readlines()
text_file.close()
#Take the lines in german_schema when the regexp search is matched and place it in a list"
Schema=[line for line in German_schema if re.search("A[0-9][0-9]*",line) ]
#Pull out just the number part from each line"
LHS=[re.findall("A[0-9][0-9]*",line)[0] for line in Schema]
#Pull out the explaination part to the right of the :"
RHS=[re.split(": ",line)[1] for line in Schema]
#remove the newline on the end
RHS=[re.sub("\n","",line) for line in RHS]
#Find the column headers (we know that they are the line after Atributte then strip whitespace
headercol=[German_schema[i+1] for i in range(len(German_schema)) if re.search(r"Attribute [0-9]",German_schema[i])]
headercol=[re.sub("\n","",line) for line in headercol]
headercol=[s.lstrip() for s in headercol]

#load the German credit data as a dataframe with header cols as headers (header=None otherwise)
German_credit=pd.read_table("/Users/chris_heale/Desktop/Data_science/Data/German_Credit/germancredit.data",sep=' ',names=headercol,index_col=False)

#use dictionary to re-assign values of A** using LHS and RHS
dicti = dict(zip(LHS, RHS))
for i in range(len(headercol)): 
    if type(German_credit[headercol[i]][0])==str:
      German_credit[headercol[i] ].replace(dicti, inplace=True)
  
