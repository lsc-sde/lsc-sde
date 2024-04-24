set search_path = demo_cdm_results;

CREATE TABLE achilles_analysis
(
  analysis_id integer,
  analysis_name text,
  stratum_1_name text,
  stratum_2_name text,
  stratum_3_name text,
  stratum_4_name text,
  stratum_5_name text,
  is_default text,
  category text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE achilles_analysis
  OWNER TO postgres;

CREATE TABLE achilles_heel_results
(
  analysis_id integer,
  achilles_heel_warning character varying(255),
  rule_id integer,
  record_count numeric
)
WITH (
  OIDS=FALSE
);
ALTER TABLE achilles_heel_results
  OWNER TO postgres;

CREATE TABLE achilles_results
(
  analysis_id integer,
  stratum_1 character varying,
  stratum_2 character varying,
  stratum_3 character varying,
  stratum_4 character varying,
  stratum_5 character varying,
  count_value bigint
)
WITH (
  OIDS=FALSE
);
ALTER TABLE achilles_results
  OWNER TO postgres;

CREATE INDEX idx_ar_aid
  ON achilles_results
  USING btree
  (analysis_id);

CREATE INDEX idx_ar_aid_s1
  ON achilles_results
  USING btree
  (analysis_id, stratum_1 COLLATE pg_catalog."default");

CREATE INDEX idx_ar_aid_s1234
  ON achilles_results
  USING btree
  (analysis_id, stratum_1 COLLATE pg_catalog."default", stratum_2 COLLATE pg_catalog."default", stratum_3 COLLATE pg_catalog."default", stratum_4 COLLATE pg_catalog."default");

CREATE INDEX idx_ar_s1
  ON achilles_results
  USING btree
  (stratum_1 COLLATE pg_catalog."default");

CREATE INDEX idx_ar_s2
  ON achilles_results
  USING btree
  (stratum_2 COLLATE pg_catalog."default");

CREATE TABLE achilles_results_derived
(
  analysis_id integer,
  stratum_1 character varying(255),
  stratum_2 character varying(255),
  statistic_value numeric,
  measure_id character varying
)
WITH (
  OIDS=FALSE
);
ALTER TABLE achilles_results_derived
  OWNER TO postgres;

CREATE TABLE achilles_results_dist
(
  analysis_id integer,
  stratum_1 character varying,
  stratum_2 character varying,
  stratum_3 character varying,
  stratum_4 character varying,
  stratum_5 character varying,
  count_value bigint,
  min_value numeric,
  max_value numeric,
  avg_value numeric,
  stdev_value numeric,
  median_value numeric,
  p10_value numeric,
  p25_value numeric,
  p75_value numeric,
  p90_value numeric
)
WITH (
  OIDS=FALSE
);
ALTER TABLE achilles_results_dist
  OWNER TO postgres;

CREATE INDEX idx_ard_aid
  ON achilles_results_dist
  USING btree
  (analysis_id);

CREATE INDEX idx_ard_s1
  ON achilles_results_dist
  USING btree
  (stratum_1 COLLATE pg_catalog."default");

CREATE INDEX idx_ard_s2
  ON achilles_results_dist
  USING btree
  (stratum_2 COLLATE pg_catalog."default");

CREATE TABLE achilles_result_concept_count
(
  concept_id character varying,
  record_count numeric,
  descendant_record_count numeric
)
WITH (
  OIDS=FALSE
);
ALTER TABLE achilles_result_concept_count
  OWNER TO postgres;
