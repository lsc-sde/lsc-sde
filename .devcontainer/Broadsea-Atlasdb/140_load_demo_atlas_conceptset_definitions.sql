INSERT INTO webapi.concept_set(
            concept_set_id, concept_set_name, created_date, modified_date,
            created_by, modified_by)
VALUES
(
1,'Demo chronic sinusitis','2019-12-01 21:47:19.034+00','2019-12-01 22:06:20.883+00','ohdsi','ohdsi'
);

INSERT INTO webapi.concept_set_item(
            concept_set_item_id, concept_set_id, concept_id, is_excluded,
            include_descendants, include_mapped)
VALUES
(1,1,257012,0,0,0)
;

