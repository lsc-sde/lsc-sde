-- load cdm tables that have data

set search_path = demo_cdm;

set datestyle to 'ymd';
copy care_site from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/care_site.csv.gz' with csv header;
copy cdm_source from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/cdm_source.csv.gz' with csv header;
--copy cohort_definition from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/cohort_definition.csv.gz' with csv header;
--copy cohort from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/cohort.csv.gz' with csv header;
copy concept_ancestor from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/concept_ancestor.csv.gz' with csv header;
copy concept_class from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/concept_class.csv.gz' with csv header;
copy concept_relationship from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/concept_relationship.csv.gz' with csv header;
copy concept_synonym from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/concept_synonym.csv.gz' with csv header;
copy concept from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/concept.csv.gz' with csv header;
--copy concept from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/omop_generated_metadata_concepts.csv.gz' with csv header;
copy condition_era from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/condition_era.csv.gz' with csv header;
copy condition_occurrence from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/condition_occurrence.csv.gz' with csv header;
copy cost from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/cost.csv.gz' with csv header;
copy death from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/death.csv.gz' with csv header;
copy device_exposure from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/device_exposure.csv.gz' with csv header;
copy domain from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/domain.csv.gz'  with csv header;
copy dose_era from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/dose_era.csv.gz'  with csv header;
copy drug_era from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/drug_era.csv.gz' with csv header;
copy drug_exposure from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/drug_exposure.csv.gz' with csv header;
copy drug_strength from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/drug_strength.csv.gz' with csv header;
--copy episode_event from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/episode_event.csv.gz' with csv header;
--copy episode from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/episode.csv.gz' with csv header;
copy fact_relationship from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/fact_relationship.csv.gz' with csv header;
copy location from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/location.csv.gz' with csv header;
copy measurement from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/measurement.csv.gz' with csv header;
copy metadata from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/metadata.csv.gz' with csv header;
copy note_nlp from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/note_nlp.csv.gz' with csv header;
copy note from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/note.csv.gz' with csv header;
copy observation_period from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/observation_period.csv.gz' with csv header;
copy observation from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/observation.csv.gz' with csv header;
copy payer_plan_period from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/payer_plan_period.csv.gz' with csv header;
copy person from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/person.csv.gz' with csv header;
copy procedure_occurrence from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/procedure_occurrence.csv.gz' with csv header;
copy provider from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/provider.csv.gz' with csv header;
copy relationship from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/relationship.csv.gz' with csv header;
copy source_to_concept_map from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/source_to_concept_map.csv.gz' with csv header;
copy specimen from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/specimen.csv.gz' with csv header;
copy visit_detail from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/visit_detail.csv.gz' with csv header;
copy visit_occurrence from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/visit_occurrence.csv.gz' with csv header;
copy vocabulary from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/vocabulary.csv.gz' with csv header;


-- load demo cdm achilles data into cdm results achilles tables

set search_path = demo_cdm_results;
--
copy achilles_analysis from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/achilles_analysis.csv.gz' with csv header;
--copy achilles_heel_results from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/achilles_heel_results.csv.gz' with csv header;
copy achilles_results from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/achilles_results.csv.gz' with csv header;
--copy achilles_results_derived from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/achilles_results_derived.csv.gz' with csv header;
copy achilles_results_dist from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/achilles_results_dist.csv.gz' with csv header;
--
set search_path = demo_cdm;

