# Data Lake

Big data applications are about handling masses of data or data in short period
of time.
The 3Vs describe the factors of a system being a big data system if it can
handle high loads of
* Volume
* Variety
* Velocity
(Note that there has been additions to the 3Vs proposed such as Value as
  additioal factor. Yet, we will stick to the original ones as these are
  the most commonly agreed ones)
When we are talking about volume in the context of *big* data then we mean data
being larger in size to be handled on a single server. Or in other words,
we would consider a Peta Byte as big while we could handle a Tera Byte with
small data solutions.

Some consider the hadoop eco system as the solution to cope with all big data
issues. However, some data intensive applications are by far too big so that
such a system could handle them efficiently. It would either be too complex or
too expensive.

Thus, here we want to show how to build a system that is capable to handle
very large sets of data efficiently. In the following we will provide
techniques needed to build and use a *data lake*. The Term *data lake* has
been used for various products in the past---maybe, it also has been used too
much or at least to much like a buzzword. However, we will not try and invent
a new term but rather use the Term *data lake* in the meaning to provide
a system to store various types of data in large quantities and enable
data usage patterns that follow the *Schema-on-Read* Approach.

Moreover, as artificial intelligence applications are on the rise there is
a also an increase in sets of data other than classical structured data such
as image or video data or audio data. These applications require intensive
data handling but the previously used techniques might not be sufficient to do
so. Yet, we will provide techniques with which we can handle these types of
data as well.

# Scenario: Satellite Data

Not every person has access to applications that require building a huge
data lake. Yet in order to illustrate the concepts in this document, we want
to use an open scenario which the interested reader can build on one's own.

Therefore, we picked analysing data from satellites as an illustrative example.
The Copernicus Open Access Hub is providing data from the Sentinel missions
with open access for free. Once registered, a user can download data from
satellite ground stations and use that data, e.g. for scientific purposes.

Each instrument in one of these satellites produces high resolution images or
readings in wavelengths we cannot see. There a many images taken per revolution
of a satellite and many observations of the same place per day. Hence, the
total amount of data for a region of interest might be quite huge. So, analysing
that data is nothing we want to do on our laptop or nothing we want to sit the
whole time of analysis next to it. We will need some means of automisation.

In our scenario we will use data from the Copernicus Open Access Hub.
There is a good guideline for the interested reader available at
https://scihub.copernicus.eu/userguide/
The guide is open for unregistered users but one has to register to use
the Copernicus Open Access Hub, documentation
see https://scihub.copernicus.eu/userguide/SelfRegistration

Once registered one can use either the graphical user interface or search and
download data using the API. We will use the API to access data later.

However, it is good practise to use the graphical interface for first
exploratory searches until we know exactly what we are looking for.
One can find the graphical user interface at https://scihub.copernicus.eu/dhus/#/home
and its documentation at https://scihub.copernicus.eu/userguide/GraphicalUserInterface

The downloadable observations can be filtered by several criteria. Unfortunately,
the names of these criteria are non-selfexplanatory abbreviations. There is
a good starter describing the meaning of abbreviations stored at
https://sentinel.esa.int/web/sentinel/missions/sentinel-3/data-products

For our small scenario let us assume that we want to analyse the bush fires
in New South Wales for the season 2019/2020. The Sentinel-3 Satellite provides
us with data about *Sea and Land Surface Temperature Radiation* (*SLSTR*), as
well as it is eqipped with an *Ocean and Land Color Instrument* (*OLCI*).

In the graphical user interface we found out that by searching for a position
around Canberra we receive images covering New South Wales and the East Coast
quite well. We can preview some of the images found whether or not they
contain the type of information we are looking for. That way we identify the
product type we are interested in. Finished doing this, we finally must
translate our selection into a query for the API access.

Information about to write such a query can be found at https://scihub.copernicus.eu/userguide/OpenSearchAPI

https://scihub.copernicus.eu/userguide/BatchScripting

```
cd ./$AWS_BATCH_JOB_ID
curl -JLO -u  $user:$pw $link
```


https://scihub.copernicus.eu/dhus/search?q=(footprint:%22Intersects(-34.5000,148.5000)%22%20AND%20platformname:%22Sentinel-3%22%20AND%20producttype:%22OL_1_EFR___%22%20AND%20creationdate:%20%5bNOW-120DAYS%20TO%20NOW-30DAYS%5d)&rows=100

# Design for Cost

# Comparing Data Warehouse ETL and Data Lake Ingest and Lifecycle Process

Data warehouses are designed to make


## ETL
* persistent staging area
* data warehouse layer
* data mart layer

## Loading Data in a Data Lake
* insert
* curate
* use
* recycle
* delete
