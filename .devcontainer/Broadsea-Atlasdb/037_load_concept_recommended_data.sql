set search_path = demo_cdm;

set datestyle to 'ymd';
copy concept_recommended from PROGRAM 'gunzip -c /tmp/concept_recommended.csv.gz' with csv header;
