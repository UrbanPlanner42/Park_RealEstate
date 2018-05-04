![alt text](https://github.com/UrbanPlanner42/PRINCIPLES-OF-URBAN-INFORMATICS/blob/master/NYU_Logo.png)

Urban Science Intensive 

<b>The Effect of Parks on Real Estate in New York City
Group Members: Matthew Sloane, Alexis Soto-Colorado, Sichen Tang, William Xia </b>


<b>Introduction / Executive Summary</b>

Throughout the last few years, New York City has experienced both a rapid development of parks as well as rapid increases in real estate prices.  Several noticeable projects, such as the Highline Park, have yielded drastic increases in economic activity and real estate prices in the areas immediately surrounding it.  The goal of this Social Impact Project was to identify the relationship between parks and real estate value to aid future public policy initiatives for city development. 

Park data was obtained from the NYC Parks Inspection Program reports and property values from the NYC MapPLUTO shapefile.  The study focused on ten “Neighborhood”-category parks in each borough, a quarter-mile buffer radius around each park, and land with 75% or greater residential use.  Multiple regression analysis was run to identify each independent variable’s (lot area, total number of units, park score, etc.) effect on the dependent variable (calculated price of lot).

The analysis model showed that for each 0.1-unit increase in aggregate park score, lot prices increased by $319,500 - with an R-squared of 0.564,statistically significant at the 1% level. It was determined that this study would be extremely valuable for city planners to not only predict price increases, but also determine when neighborhoods may potentially become too expensive for existing and future residents.  Further studies would have gone further into studying the effects of radial distance on real estate price increases.  

<b>Data Preparation and Processing</b>

Three primary datasets were utilized to form the basis of the analysis presented in this paper.  Those datasets and their pertinent information are described below:

1.     New York City MapPLUTO – tax lot-level spatial data with associated attribute data for each lot, provided by the New York City Department of City Planning (NYCDCP) for each borough. For the purposes of this analysis, land use and total assessed value were used.  This data was obtained from the New York City Bytes of Big Apple webpage.
2.     New York City Park Inspections Data - The Parks Inspection Program (PIP) is a performance measurement system that involved detailed inspections on New York City’s parks, with each amenity at east park receiving a rating of "Acceptable" or "Unacceptable."  This data, created by the New York City Department of Parks and Recreation (NYCDPR), was obtained form from the New York City Open Data portal.
3.     New York City Parks Shapefile – This is a dataset mapping all New York City parks and providing associated data, such as park size (in acres), type of park (e.g., neighborhood, community, flagship, etc.), and other associated data.  This data, created by the NYCDPR, was obtained from the New York City Open Data portal.

This data was utilized to identify 10 parks in each borough (50 parks total) for later analyses.  The identification of these 50 parks was undertaken via the following methodology:

1.     Selection of all neighborhood parks from the Parks shapefile via the ArcMap “Select by Attributes” tool.
2.     Generation of a ¼-mile radius around all the neighborhood parks (¼-mile is a common planning standard to generalize the distance people are willing to walk to use an amenity regularly) via the ArcMap “Buffer” tool.
3.     Selection of all parcels (via the MapPLUTO data) within all of the ¼-mile radii and computation of the land use composition within each radii via the ArcMap “Select by Location” and “Summary Statistics” tool.
4.     Selecting 10 parks from each borough whose land use composition within the radii was 75 percent or more residential, ensuring consistency across the park samples (this was accomplished via the “Select by Attributes” tool).

With the selected parks and associated radii and tax parcels in hand, the mean assessed value of all residential properties within the selected radii was calculated using the ArcMap “Summary Statistics” tool.  In order to calculate a baseline for comparison, all residential tax parcels outside a ¼-mile of any park in New York City were selected and the mean total assessed value of all these residential properties in that subset of data was calculated (“Select by Location” and “Summary Statistics” tools).

Using the Park Inspection Data, a park condition metric was calculated for each park analyzed by assigning a 1 for each amenity at the park rated “Acceptable” and a 0 for each amenity rated “Unacceptable,” and those scores were then averaged to compute an overall condition metric for each park (on a scale from 0 to 1). 

Links in the Appendix to source code used in later analyses contain a list of all the selected parks, their associated mean total associated value for all residential parcels within their respective quarter-mile radii, as well as their associated computed park condition metric. Figure 1 in the Appendix illustrates the location of each park analyzed and its associated ¼-mile radius over a New York City basemap.  

<b>Analysis:</b>

The relationship between park quality score and residential real estate price was analyzed using the Ordinary Least Squares regression method. The park score variable suffers from a multicollinearity issue - for example, Cleanness of Weeds Score is related to the Landscape Score.  Because of the multicollinearity issue, it was decided to combine the different categories of park scores into an average score to indicate the overall quality of the park - which is was also beneficial for ease of interpretation.  The six independent variables used were the following:

1.	Lot Area
2.	Building Area
3.	Residential Area
4.	Number of Floors
5.	Total of Units
6.	Average Park Score 

The dependent variable was the calculated mean assessed value for all residential properties within the individually generated quarter-mile radii (the base data for which was provided from the MapPLUTO data, as indicated previously). 
Results:

The results Ordinary Least Squares (OLS) regression as described in the previous section of this report are indicated below in the table.

The OLS regression results show a clear relationship between quality park score and residential total assessment prices in New York City. For every 0.1-unit increase in average overall condition score of the park (on a scale of 0.0 to 1.0), the assessment price of the residential lot increases by $319,500, statistically significant at the 1% level.  Based on the results of the OLS regression, approximately 50 percent of the variation in the lot price can be attributed to the regression (indicated by an R-square value of 0.564).

<b>Conclusions:</b>

Based on the OLS regression performed, there appears to be a significant relationship between park quality and residential assessed value for those properties within a quarter-mile of a park.  This potentially has many far-reaching policy implications for the City as a whole.  On the positive side, higher real estate prices can yield higher taxes that the city can collect, which can then be used to further city development and services, as well as projecting the tax benefit of standalone park development or as part of a larger development plan.  This could also be capitalized on by mandating a park impact fee on new developments to account for the added financial benefits of being located near a park.  On the other hand, however, excessively high property values can have a detrimental effect on both incumbent and future residents.  To this end, a quantifiable metric related to the effect of parks on property values can be used is a potential indicator of gentrification.  

<b>Opportunities for Further Research and Study:</b>

The following items represent opportunities for further study in order to refine and expand on the analysis presented in this report:
1.	There are many types of parks in New York City, including community parks, playgrounds, Flagship Parks (e.g., Central Park, Prospect Park, etc.).  Differentiating the effect of individual park types on residential assessed values would give a more comprehensive picture of this impact.  Isolating the impact on a borough-by-borough basis (e.g., the effect on assessed values in Queens versus the effect in the Bronx) would also provide a more nuanced analysis.   

2.	Most properties in New York City fall within a ¼-mile of two or more parks.  Calculating the incremental impact of the presence of each additional park within a ¼-mile of a property would help further quantify impacts.

3.	A more granular study that focused on the impact on property value based on distance to the park within the ¼-mile radii (e.g., is there a difference in impact on property values on properties adjacent to the park versus those properties at the periphery of the radii). 


References:

•	Impact of Parks | NYCEDC. Web. 29 Mar. 2017.

•	Barbanel, Josh. "The High Line's 'Halo Effect' on Property." The Wall Street Journal. Dow Jones & Company

•	"Podcast." #19 The Economist, 7 Aug. 2016. Web. 29 Mar. 2017.

•	Sheftell, Jason. "Central Park: The World's Greatest Real Estate Engine." NY Daily News. 03 June 2010. Web. 29 Mar. 2017.

•	Sheftell, Jason. "Central Park: The World's Greatest Real Estate Engine." NY Daily News. 03 June 2010. Web. 29 Mar. 2017.






Appendix Items:

Source Code:
Ipython code for the linear regression and lasso regression
https://github.com/st1671/PUI2016_st1671/blob/master/USI_regress.ipynb

R code for data wrangling and ordinary least square regression:
https://github.com/UrbanPlanner42/Park_RealEstate


