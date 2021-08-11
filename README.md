# Main Objective

The main goal of this project is to complete the final challenge from Indicium's Academy Analitycs Engineer's course and serve as a training to my skills in ELT (yes ELT not ETL) and git and for everyone that want to learn something from it. 
In this repository you will found the third step of ELT (Transform) via DBT, a very practical tool to manipulate raw data to develop a data warehouse to use for deeper analytics works.  

The source data is from Adventure Works and can be fund in https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver15&tabs=ssms.

## DBT docs

You can acess the documentation via this commands inside the project:
- dbt docs generate
- dbt docs serve
  
Or you can get it in https://reverent-poitras-2a2580.netlify.app

## BI Panels 
Here are some BI panels contructed from this data warehouse project:

- https://datastudio.google.com/reporting/9c0d779c-0b86-428c-8712-bb93e72bf5e2
- https://datastudio.google.com/reporting/fbe8a6f3-c217-4d66-a3e0-29af98579297
- https://datastudio.google.com/reporting/b53da289-bb99-4c2b-9aad-6753d8a1ded8

## Tools

Tools used in this project:
- Stitch (https://www.stitchdata.com/) (Extract)
- GoogleBigQuery (https://cloud.google.com/bigquery) (Load)
- DBT (https://www.getdbt.com/) (Transform)
- GoogleDataStudio (https://datastudio.google.com/) BI Panels

## Install dependencies

All dependencies are in requirements.txt.
- pip install -r requirements.txt

## Useful commands in the project

To make use of dbt in this project try the following commands:
- dbt run
- dbt test
